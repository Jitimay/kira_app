import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kira/providers/appointment_provider.dart';
import 'package:kira/models/appointment.dart';
import 'package:kira/widgets/custom_text_field.dart';
import 'package:kira/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientIdController = TextEditingController();
  final _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make an Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _patientIdController,
                labelText: 'Patient ID',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _reasonController,
                labelText: 'Reason for Appointment',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reason for appointment';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                onPressed: _submitForm,
                text: 'Make Appointment', // Pass text parameter
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final appointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        patientId: _patientIdController.text,
        date: _selectedDate,
        reason: _reasonController.text,
      );

      final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
      await appointmentProvider.addAppointment(appointment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment scheduled successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
}
