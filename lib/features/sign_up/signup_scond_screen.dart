import 'package:flutter/material.dart';
import 'package:petspaw_user/common_widgets.dart/custom_button.dart';
import 'package:petspaw_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:petspaw_user/util/value_validator.dart';

class SignupScondScreen extends StatelessWidget {
  SignupScondScreen({super.key});
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

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
                  "SignUp",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Name',
                  controller: _nameController,
                  validator: notEmptyValidator,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Phone',
                  controller: _phoneController,
                  validator: notEmptyValidator,
                ),
                SizedBox(height: 10),

                SizedBox(height: 20),
                CustomButton(onPressed: () {}, label: 'Signup'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
