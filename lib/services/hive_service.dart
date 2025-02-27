import 'package:hive/hive.dart';
import '../models/schedule_model.dart';

class HiveService {
  static late Box<ScheduleModel> _scheduleBox;

  static Future<void> init() async {
    _scheduleBox = await Hive.openBox<ScheduleModel>('scheduleBox');
  }

  static void saveSchedule(ScheduleModel schedule) {
    _scheduleBox.put(schedule.date, schedule);
  }

  static List<ScheduleModel> getSchedules() {
    return _scheduleBox.values.toList();
  }
}
