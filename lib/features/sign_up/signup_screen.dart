import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspaw_user/common_widgets.dart/custom_button.dart';
import 'package:petspaw_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:petspaw_user/features/sign_up/signup_scond_screen.dart';
import 'package:petspaw_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../home/home_screen.dart';
import '../signin/signin_screen.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
    super.initState();
  }

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignupScondScreen(
                  signupDetails: {
                    'email': _emailController.text.trim(),
                  },
                ),
              ),
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
                          "SignUp",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
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
                        CustomTextFormField(
                          labelText: 'ConfirmPassword',
                          controller: _confirmPassController,
                          validator: notEmptyValidator,
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text(
                              'Already Have Account! Signin?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                SignUpUserEvent(
                                  email: _emailController.text.trim(),
                                  password: _passController.text.trim(),
                                ),
                              );
                            }
                          },
                          label: 'Next',
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
