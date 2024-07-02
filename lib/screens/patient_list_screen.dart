import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kira/providers/patient_provider.dart';
import 'package:kira/widgets/patient_card.dart';

class PatientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return ListView.builder(
      itemCount: patientProvider.patients.length,
      itemBuilder: (context, index) {
        final patient = patientProvider.patients[index];
        return PatientCard(patient: patient);
      },
    );
  }
}
