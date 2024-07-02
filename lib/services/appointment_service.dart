import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:kira/models/appointment.dart';

class AppointmentService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'appointments.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE appointments(
            id TEXT PRIMARY KEY,
            patientId TEXT,
            date TEXT,
            reason TEXT
          )
        ''');
      },
    );
  }

  Future<String?> insertAppointment(Appointment appointment) async {
    final db = await database;
    await db.insert('appointments', {
      'id': appointment.id,
      'patientId': appointment.patientId,
      'date': appointment.date.toIso8601String(),
      'reason': appointment.reason,
    });
    return appointment.id;
  }

  Future<bool> updateAppointment(Appointment appointment) async {
    final db = await database;
    int count = await db.update(
      'appointments',
      {
        'patientId': appointment.patientId,
        'date': appointment.date.toIso8601String(),
        'reason': appointment.reason,
      },
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
    return count > 0;
  }

  Future<bool> deleteAppointment(String id) async {
    final db = await database;
    int count = await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  Future<List<Appointment>> getAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');
    return List.generate(maps.length, (i) {
      return Appointment(
        id: maps[i]['id'],
        patientId: maps[i]['patientId'],
        date: DateTime.parse(maps[i]['date']),
        reason: maps[i]['reason'],
      );
    });
  }
}