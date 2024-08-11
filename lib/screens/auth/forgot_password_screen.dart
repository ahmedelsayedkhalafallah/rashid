import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/reset_password_bloc/reset_password_bloc.dart';
import '../../components/my_button.dart';
import '../../components/my_text_field.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;
  String? _errorMsg;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if(state is ResetPasswordSuccess){
           showToast(msg: S.of(context).resetEmailSent, toastState: ToastState.SUCCESS);
          Navigator.pop(context);
        }else if(state is ResetPasswordFailure){
          showToast(msg: state.message, toastState: ToastState.FAILURE);
        }
      },
      builder: (context, state) {
        if(state is ResetPasswordLoading){
          return SizedBox(
            child: Center(child: CircularProgressIndicator()),
            height: 50.0,
            width: 50.0,
          );
        }else{
          return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/background.jpeg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17),
                      Text(S.of(context).resetPassword,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(_opacity),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      child: MyTextField(
                                        controller: emailController,
                                        hintText: S.of(context).emailAddress,
                                        obscureText: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        prefixIcon: Icon(Icons.email),
                                        errorMsg: _errorMsg,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return S.of(context).fillThisField;
                                          } else if (!RegExp(
                                                  r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                              .hasMatch(val)) {
                                            return S.of(context).enterValidEmail;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    MyButton(
                                      text: S.of(context).send,
                                      fun: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<ResetPasswordBloc>().add(
                                              SendResetLink(
                                                  email: emailController.text
                                                      .trim()));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        }
      },
    );
  }
}
