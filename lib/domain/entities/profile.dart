import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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

  @HiveField(6)
  String creatorEmail;

  get dateAdded => StringUtils.formatDate(DateTime.fromMillisecondsSinceEpoch(dateAddedInMillis));

  Profile({
    required this.id,
    this.imagePath,
    required this.name,
    required this.nickname,
    required this.dateAddedInMillis,
    this.description,
    required this.creatorEmail,
  });

  factory Profile.emptyProfile() {
    return Profile(id: const Uuid().v4(), name: "", nickname: "", dateAddedInMillis: 0, creatorEmail: "");
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
      creatorEmail: creatorEmail,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      dateAddedInMillis: dateAddedInMillis ?? this.dateAddedInMillis,
      description: description ?? this.description,
    );
  }
}
