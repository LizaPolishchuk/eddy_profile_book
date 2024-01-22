import 'dart:io';
import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:eddy_profile_book/presentation/pages/add_edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfilesCubit>()..fetchProfiles(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Main List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            const IconButton(
              onPressed: null, // Navigate to the settings page
              icon: Icon(Icons.settings, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                getIt<AuthCubit>().signOut();
              },
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
        body: BlocBuilder<ProfilesCubit, ProfilesState>(
          builder: (context, state) {
            if (state is ProfilesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfilesLoaded) {
              print("ProfilesLoaded: ${state.profiles.length}");
              if (state.profiles.isEmpty) {
                return const Center(child: Text("No profiles added"));
              }
              return ListView.builder(
                itemCount: state.profiles.length,
                itemBuilder: (context, index) {
                  final profile = state.profiles[index];
                  return Dismissible(
                    confirmDismiss: (DismissDirection direction) => _onConfirmDelete(context),
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    key: ValueKey<String>(profile.id),
                    onDismissed: (DismissDirection direction) {
                      getIt<ProfilesCubit>().deleteProfile(profile.id);
                    },
                    child: ListTile(
                      onLongPress: () {
                        setState(() {});
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditProfilePage(profileToEdit: profile),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                          backgroundImage: profile.imagePath == null || profile.imagePath!.isEmpty
                              ? const AssetImage("assets/images/profile_placeholder.jpeg")
                              : FileImage(File(profile.imagePath!)) as ImageProvider),
                      title: Text(
                        profile.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        profile.nickname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(profile.dateAdded),
                    ),
                  );
                },
              );
            } else if (state is ProfilesError) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditProfilePage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<bool?> _onConfirmDelete(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this profile?"),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("CANCEL")),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("DELETE")),
          ],
        );
      },
    );
  }

// void _onLongPressedItem() {
//   final AppBar _selectedItemAppBar = AppBar(
//     title: const Text(
//       'Selected Profile',
//       style: TextStyle(color: Colors.white),
//     ),
//     backgroundColor: Colors.green,
//     actions: <Widget>[
//       const IconButton(
//         onPressed: null, // Navigate to the settings page
//         icon: Icon(Icons.edit, color: Colors.white),
//       ),
//       IconButton(
//         onPressed: () {
//           getIt<ProfilesCubit>().deleteProfile(1);
//         },
//         icon: const Icon(Icons.delete, color: Colors.white),
//       ),
//     ],
//   );
//
//   setState(() {});
// }
}
