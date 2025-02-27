import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String name;
  
  UserModel({required this.userId, required this.name});
}
