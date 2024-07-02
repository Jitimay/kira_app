class Prescription {
  final String id;
  final String patientId;
  final String medicationName;
  final String dosage;
  final String instructions;

  Prescription({
    required this.id,
    required this.patientId,
    required this.medicationName,
    required this.dosage,
    required this.instructions,
  });
}
