class Invoice {
  final String id;
  final String patientId;
  final DateTime date;
  final double amount;

  Invoice({
    required this.id,
    required this.patientId,
    required this.date,
    required this.amount,
  });
}
