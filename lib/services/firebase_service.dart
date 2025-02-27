import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/schedule_model.dart';

class FirebaseService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> syncSchedule(ScheduleModel schedule, String userId) async {
    await _db.collection('users').doc(userId).collection('schedules').doc(schedule.date).set({
      'date': schedule.date,
      'workHours': schedule.workHours,
      'breakHours': schedule.breakHours,
      'totalHours': schedule.totalHours,
    });
  }

  static Stream<List<ScheduleModel>> getSchedulesStream(String userId) {
    return _db.collection('users').doc(userId).collection('schedules').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ScheduleModel(
        date: doc['date'],
        workHours: doc['workHours'],
        breakHours: doc['breakHours'],
        totalHours: doc['totalHours'],
      )).toList();
    });
  }
}
