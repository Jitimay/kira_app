import 'package:flutter/material.dart';
import 'package:kira/models/appointment.dart';
import 'package:kira/services/appointment_service.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  Future<void> addAppointment(Appointment appointment) async {
    final insertedId = await _appointmentService.insertAppointment(appointment);
    if (insertedId != null) {
      _appointments.add(appointment);
      notifyListeners();
    }
  }

  Future<void> updateAppointment(Appointment updatedAppointment) async {
    final success = await _appointmentService.updateAppointment(updatedAppointment);
    if (success) {
      final index = _appointments.indexWhere((appointment) => appointment.id == updatedAppointment.id);
      if (index != -1) {
        _appointments[index] = updatedAppointment;
        notifyListeners();
      }
    }
  }

  Future<void> deleteAppointment(String id) async {
    final success = await _appointmentService.deleteAppointment(id);
    if (success) {
      _appointments.removeWhere((appointment) => appointment.id == id);
      notifyListeners();
    }
  }

  Future<List<Appointment>> getAppointments() async {
    _appointments = await _appointmentService.getAppointments();
    notifyListeners();
    return _appointments;
  }
}