import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: hiveTypeUsers)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String password;

  User({
    required this.id,
    required this.email,
    required this.password,
  });
}
