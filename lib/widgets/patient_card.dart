import 'package:flutter/material.dart';
import 'package:kira/models/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;

  PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(patient.name),
        subtitle: Text(patient.email),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Implement navigation to patient details
        },
      ),
    );
  }
}
