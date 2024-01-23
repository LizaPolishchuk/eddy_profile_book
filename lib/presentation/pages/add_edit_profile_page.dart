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

    _addEditProfileCubit = AddEditProfileCubit(getIt());

    Listenable.merge([_fullNameController, _nicknameController]).addListener(
      () {
        setState(() {});
      },
    );

    if (widget.profileToEdit != null) {
      _pickedFile = widget.profileToEdit!.imagePath != null ? File(widget.profileToEdit!.imagePath!) : null;
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
        body: BlocConsumer<AddEditProfileCubit, AddEditProfileState>(listener: (context, state) {
          if (state is AddEditProfileSuccess) {
            Navigator.of(context).pop();
          }
        }, builder: (context, state) {
          if (state is AddEditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Padding(
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
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            image: _pickedFile != null
                                ? DecorationImage(
                                    image: FileImage(_pickedFile!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _pickedFile == null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _fullNameController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          icon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Full Name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nicknameController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          icon: const Icon(Icons.person_outline),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Nickname',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          icon: const Icon(Icons.description),
                          labelText: 'Description',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fullNameController.text.isNotEmpty || _nicknameController.text.isNotEmpty
                            ? () => _onPressedSave(context)
                            : null,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
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

  Future<void> _onPressedSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var profile = widget.profileToEdit ?? Profile.emptyProfile();

      String? savedPhotoPath;
      if (_pickedFile != null) {
        savedPhotoPath = (await _savePhoto(_pickedFile!)).path;
      }

      profile = profile.copyWith(
        name: _fullNameController.text,
        nickname: _nicknameController.text,
        description: _descriptionController.text,
        imagePath: savedPhotoPath,
        dateAddedInMillis: DateTime.now().millisecondsSinceEpoch,
      );

      _addEditProfileCubit.setProfile(profile);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _pickedFile = File(pickedFile.path);
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
    _descriptionController.dispose();
    super.dispose();
  }
}
