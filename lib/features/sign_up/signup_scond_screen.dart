import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspaw_user/common_widgets.dart/custom_button.dart';
import 'package:petspaw_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:petspaw_user/features/home/home_screen.dart';
import 'package:petspaw_user/util/value_validator.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../common_widgets.dart/custom_image_picker_button.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

class SignupScondScreen extends StatefulWidget {
  final Map<String, String> signupDetails;

  const SignupScondScreen({super.key, required this.signupDetails});

  @override
  State<SignupScondScreen> createState() => _SignupScondScreenState();
}

class _SignupScondScreenState extends State<SignupScondScreen> {
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  File? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is SignUpSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verify...",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Profile photo',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomImagePickerButton(
                            showRequiredError: true,
                            onPick: (file) {
                              profilePhoto = file;
                              setState(() {});
                            },
                          ),
                        ),
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
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                profilePhoto != null) {
                              Map<String, dynamic> details = {
                                'email': widget.signupDetails['email'],
                                'name': _nameController.text.trim(),
                                'phone': _phoneController.text.trim(),
                              };
                              if (profilePhoto != null) {
                                details['photo_file'] = profilePhoto!;
                                details['photo_name'] = profilePhoto!.path;
                              }
                              BlocProvider.of<SignUpBloc>(context).add(
                                InsertUserDataEvent(
                                  userDetails: details,
                                ),
                              );
                            }
                          },
                          label: 'Signup',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
