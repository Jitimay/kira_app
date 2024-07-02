import 'package:flutter/material.dart';
import 'package:kira/models/patient.dart';
import 'package:kira/services/patient_service.dart';

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  void addPatient(Patient patient) {
    _patients.add(patient);
    notifyListeners();
  }

  void updatePatient(Patient updatedPatient) {
    final index = _patients.indexWhere((patient) => patient.id == updatedPatient.id);
    if (index != -1) {
      _patients[index] = updatedPatient;
      notifyListeners();
    }
  }

  void deletePatient(String id) {
    _patients.removeWhere((patient) => patient.id == id);
    notifyListeners();
  }
}
