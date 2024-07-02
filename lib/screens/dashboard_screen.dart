import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kira/providers/patient_provider.dart';
import '../models/patient.dart';
import 'patient_list_screen.dart';
import 'appointment_screen.dart';
import 'prescription_screen.dart';
import 'billing_screen.dart';
import 'reports_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    PatientListScreen(),
    AppointmentScreen(),
    PrescriptionScreen(),
    BillingScreen(),
    ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Alex'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: _pageIndex == 0 ? _buildDashboardContent() : _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.black,
        height: 60,
        items: <Widget>[
          Icon(Icons.people, size: 30, color: Colors.white),
          Icon(Icons.calendar_today, size: 30, color: Colors.white),
          Icon(Icons.receipt, size: 30, color: Colors.white),
          Icon(Icons.attach_money, size: 30, color: Colors.white),
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDashboardCard(
                  context,
                  title: 'Clinic Visit',
                  subtitle: 'Make an appointment',
                  icon: Icons.local_hospital,
                  color: Colors.black,
                  onTap: () {
                    setState(() {
                      _pageIndex = 1; // Navigate to AppointmentScreen
                    });
                  },
                ),
                _buildDashboardCard(
                  context,
                  title: 'Home Visit',
                  subtitle: 'Call the doctor home',
                  icon: Icons.home,
                  color: Colors.grey,
                  onTap: () {
                    // Implement functionality
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('What are your symptoms?', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Temperature', 'Snuffle', 'Fever', 'Headache', 'Cough'].map((symptom) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      label: Text(symptom),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Popular Doctors', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            _buildDoctorList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    return Consumer<PatientProvider>(
      builder: (context, provider, child) {
        // For demonstration purposes, we'll use patients as doctors
        // In a real app, you'd have a separate DoctorProvider
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: provider.patients.length,
          itemBuilder: (context, index) {
            final patient = provider.patients[index];
            return _buildDoctorCard(patient);
          },
        );
      },
    );
  }

  Widget _buildDoctorCard(Patient patient) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patient.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("General Practitioner", style: TextStyle(color: Colors.grey)), // Placeholder specialty
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.9', style: TextStyle(color: Colors.amber)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}