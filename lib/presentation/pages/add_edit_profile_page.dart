import 'dart:io';

import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_state.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  initState() {
    super.initState();
    if (widget.profileToEdit != null) {
      _fullNameController.text = widget.profileToEdit!.name;
      _nicknameController.text = widget.profileToEdit!.nickname;
      _descriptionController.text = widget.profileToEdit!.description ?? '';
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selected = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = File(selected!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddEditProfileCubit>(),
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
                      onTap: () {
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
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          // image: DecorationImage(
                          //   image: _imageFile != null
                          //       ? FileImage(_imageFile!)
                          //       : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: _imageFile == null
                            ? const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Full Name',
                      ),
                    ),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline),
                        labelText: 'Nickname',
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.description),
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

  void _onPressedSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      getIt<ProfilesCubit>().addProfile(
        Profile(
          id: '1',
          name: "_fullNameController.text",
          nickname: "_nicknameController.text",
          description: "_descriptionController.text",
          imageUrl: "_imageFile",
          dateAdded: DateTime.now().toIso8601String(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }
}
