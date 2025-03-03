import 'package:flutter/material.dart';
import 'package:petspaw_user/common_widgets.dart/custom_button.dart';
import 'package:petspaw_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:petspaw_user/features/sign_up/signup_screen.dart';
import 'package:petspaw_user/util/value_validator.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dog.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Email',
                  controller: _emailController,
                  validator: emailValidator,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Password',
                  controller: _passController,
                  validator: notEmptyValidator,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      '''Don't Have Account! Signup?''',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                CustomButton(onPressed: () {}, label: 'Login'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
