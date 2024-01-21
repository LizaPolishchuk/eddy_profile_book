import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfilesCubit>()..getProfiles(),
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
              return ListView.builder(
                itemCount: state.profiles.length,
                itemBuilder: (context, index) {
                  final profile = state.profiles[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profile.imageUrl == null || profile.imageUrl!.isEmpty
                          ? const AssetImage('assets/images/profile_placeholder.png') as ImageProvider
                          : NetworkImage(profile.imageUrl!),
                    ),
                    title: Text(profile.name),
                    subtitle: Text(profile.nickname),
                    trailing: Text(profile.dateAdded),
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
            // Navigate to the add profile page
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}