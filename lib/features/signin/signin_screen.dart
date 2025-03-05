import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspaw_user/common_widgets.dart/custom_button.dart';
import 'package:petspaw_user/common_widgets.dart/custom_text_formfield.dart';
import 'package:petspaw_user/features/home/home_screen.dart';
import 'package:petspaw_user/features/sign_up/signup_screen.dart';
import 'package:petspaw_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import 'signin_bloc/signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
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
      create: (context) => SigninBloc(),
      child: BlocConsumer<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (state is SigninFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                description: state.message,
                primaryButton: 'Ok',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
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
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            '''Don't Have Account! Signup?''',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SigninBloc>(context).add(
                              SigninEvent(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim(),
                              ),
                            );
                          }
                        },
                        label: 'Login',
                      ),
                    ],
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
