import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

@HiveType(typeId: 1)
class ScheduleModel {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String workHours;
  @HiveField(2)
  final String breakHours;
  @HiveField(3)
  final String totalHours;
  
  ScheduleModel({required this.date, required this.workHours, required this.breakHours, required this.totalHours});
}
