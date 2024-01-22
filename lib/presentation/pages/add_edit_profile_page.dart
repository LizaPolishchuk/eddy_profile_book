import 'dart:io';

import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddEditProfilePage extends StatefulWidget {
  final Profile? profileToEdit;

  const AddEditProfilePage({super.key, this.profileToEdit});

  @override
  State<AddEditProfilePage> createState() => _AddEditProfilePageState();
}

class _AddEditProfilePageState extends State<AddEditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  late final AddEditProfileCubit _addEditProfileCubit;

  @override
  initState() {
    super.initState();

    _addEditProfileCubit = getIt<AddEditProfileCubit>();

    if (widget.profileToEdit != null) {
      _fullNameController.text = widget.profileToEdit!.name;
      _nicknameController.text = widget.profileToEdit!.nickname;
      _descriptionController.text = widget.profileToEdit!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addEditProfileCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: BlocBuilder<AddEditProfileCubit, AddEditProfileState>(builder: (context, state) {
          if (state is AddEditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () => _onChangePhoto(context),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            image: _pickedFile != null
                                ? FileImage(_pickedFile!)
                                : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: _pickedFile == null
                            ? const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Full Name',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    TextFormField(
                      controller: _nicknameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline),
                        labelText: 'Nickname',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      minLines: 5,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        icon: const Icon(Icons.description),
                        labelText: 'Description',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onPressedSave(context),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  void _onChangePhoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Photo Library'),
            onTap: () {
              _pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Camera'),
            onTap: () {
              _pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onPressedSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _addEditProfileCubit.addProfile(
        Profile(
          id: const Uuid().v4(),
          name: _fullNameController.text,
          nickname: _nicknameController.text,
          description: _descriptionController.text,
          imagePath: _pickedFile?.path,
          dateAdded: DateTime.now().toIso8601String(),
        ),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    var savedImage = await _savePhoto(File(pickedFile.path));
    setState(() {
      _pickedFile = savedImage;
    });
  }

  Future<File> _savePhoto(File pickedFile) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    final File newImage = await pickedFile.copy('$path/${const Uuid().v4()}.png');
    return newImage;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }
}
