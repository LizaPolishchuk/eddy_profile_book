import 'package:eddy_profile_book/data/local_data/profiles_storage.dart';
import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: hiveTypeProfiles)
class Profile {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? imageUrl;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String nickname;

  @HiveField(4)
  final String dateAdded;

  @HiveField(5)
  final String? description;

  Profile({
    required this.id,
    this.imageUrl,
    required this.name,
    required this.nickname,
    required this.dateAdded,
    this.description,
  });
}
