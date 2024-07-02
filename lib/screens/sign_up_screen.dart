import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kira/providers/auth_provider.dart';
import 'package:kira/widgets/custom_text_field.dart';
import 'package:kira/widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              controller: _nameController,
              labelText: 'Name',
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                // Implement sign up logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
