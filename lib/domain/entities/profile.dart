import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: hiveTypeProfiles)
class Profile {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? imagePath;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String nickname;

  @HiveField(4)
  final int dateAddedInMillis;

  @HiveField(5)
  final String? description;

  get dateAdded => StringUtils.formatDate(DateTime.fromMillisecondsSinceEpoch(dateAddedInMillis));

  Profile({
    required this.id,
    this.imagePath,
    required this.name,
    required this.nickname,
    required this.dateAddedInMillis,
    this.description,
  });

  factory Profile.emptyProfile() {
    return Profile(id: "", name: "", nickname: "", dateAddedInMillis: 0);
  }

  Profile copyWith({
    String? imagePath,
    String? name,
    String? nickname,
    int? dateAddedInMillis,
    String? description,
  }) {
    return Profile(
      id: id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      dateAddedInMillis: dateAddedInMillis ?? this.dateAddedInMillis,
      description: description ?? this.description,
    );
  }
}
