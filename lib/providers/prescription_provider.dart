import 'package:flutter/material.dart';
import 'package:kira/models/prescription.dart';
import 'package:kira/services/prescription_service.dart';

class PrescriptionProvider with ChangeNotifier {
  final PrescriptionService _prescriptionService = PrescriptionService();
  List<Prescription> _prescriptions = [];

  List<Prescription> get prescriptions => _prescriptions;

  void addPrescription(Prescription prescription) {
    _prescriptions.add(prescription);
    notifyListeners();
  }

  void updatePrescription(Prescription updatedPrescription) {
    final index = _prescriptions.indexWhere((prescription) => prescription.id == updatedPrescription.id);
    if (index != -1) {
      _prescriptions[index] = updatedPrescription;
      notifyListeners();
    }
  }

  void deletePrescription(String id) {
    _prescriptions.removeWhere((prescription) => prescription.id == id);
    notifyListeners();
  }
}
