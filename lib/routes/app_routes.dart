import 'package:flutter/material.dart';
import 'package:kira/screens/login_screen.dart';
import 'package:kira/screens/sign_up_screen.dart';
import 'package:kira/screens/dashboard_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginScreen(),
    '/signup': (context) => SignUpScreen(),
    '/dashboard': (context) => DashboardScreen(),
    // Add other routes here
  };
}
