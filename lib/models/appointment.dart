class Appointment {
  final String id;
  final String patientId;
  final DateTime date;
  final String reason;

  Appointment({
    required this.id,
    required this.patientId,
    required this.date,
    required this.reason,
  });
}
