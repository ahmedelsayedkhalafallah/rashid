import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../blocs/verification_bloc/verification_bloc.dart';
import '../../components/my_button.dart';
import '../../components/my_phone_field.dart';
import '../../components/my_text_field.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';
import 'verify_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;

  const SignUpScreen(
      {super.key, this.phoneNumber});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // text editing controllers
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  final double _width = 350;

  final double _height = 300;

  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
 

  @override
  Widget build(BuildContext context) {
    widget.phoneNumber != ''
        ? phoneController.text = widget.phoneNumber.toString()
        : phoneController.text = '';
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => VerificationBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(SendVerificationCode(phoneNumber: phoneController.text)),
              child: VerifyScreen(
                phoneNumber: phoneController.text,
                
              ),
            );
          }));
        } else if (state is SignUpFailure) {
          showToast(
              msg: state.message.toString(), toastState: ToastState.FAILURE);
        }
      },
      builder: (context, state) {
        if (state is SignUpProcess) {
          return SizedBox(
            child: Center(child: CircularProgressIndicator()),
            height: 50.0,
            width: 50.0,
          );
        } else {
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
                            height: MediaQuery.of(context).size.height * 0.05),
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Text(S.of(context).signUp,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.04,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: _sigmaX, sigmaY: _sigmaY),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 1)
                                      .withOpacity(_opacity),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            S
                                                .of(context)
                                                .lookLikeDonotHaveAnAccount,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025),
                                            textAlign: TextAlign.start),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          widget.phoneNumber.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 30),

                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: MyTextField(
                                              controller: nameController,
                                              hintText: S.of(context).name,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              prefixIcon:
                                                  const Icon(Icons.person),
                                              errorMsg: _errorMsg,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return S.of(context).fillThisField;
                                                } else if (val.length > 30) {
                                                  return S.of(context).NameTooLong;
                                                }
                                                return null;
                                              }),
                                        ),
                                        const SizedBox(height: 10),

                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: MyPhoneField(
                                            controller: phoneController,
                                            hintText: S.of(context).phone,
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                        ),

                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: MyTextField(
                                            controller: passwordController,
                                            hintText: S.of(context).password,
                                            obscureText: obscurePassword,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            prefixIcon: const Icon(
                                                CupertinoIcons.lock_fill),
                                            errorMsg: _errorMsg,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return S.of(context).fillThisField;
                                              } else if (!RegExp(
                                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                                                  .hasMatch(val)) {
                                                return S.of(context).enterValidPassword;
                                              }
                                              return null;
                                            },
                                            onChanged: (val) {
                                              if (val!
                                                  .contains(RegExp(r'[A-Z]'))) {
                                                setState(() {
                                                  containsUpperCase = true;
                                                });
                                              } else {
                                                setState(() {
                                                  containsUpperCase = false;
                                                });
                                              }
                                              if (val
                                                  .contains(RegExp(r'[a-z]'))) {
                                                setState(() {
                                                  containsLowerCase = true;
                                                });
                                              } else {
                                                setState(() {
                                                  containsLowerCase = false;
                                                });
                                              }
                                              if (val
                                                  .contains(RegExp(r'[0-9]'))) {
                                                setState(() {
                                                  containsNumber = true;
                                                });
                                              } else {
                                                setState(() {
                                                  containsNumber = false;
                                                });
                                              }
                                              if (val.contains(RegExp(
                                                  r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                                                setState(() {
                                                  containsSpecialChar = true;
                                                });
                                              } else {
                                                setState(() {
                                                  containsSpecialChar = false;
                                                });
                                              }
                                              if (val.length >= 8) {
                                                setState(() {
                                                  contains8Length = true;
                                                });
                                              } else {
                                                setState(() {
                                                  contains8Length = false;
                                                });
                                              }
                                              return null;
                                            },
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscurePassword =
                                                      !obscurePassword;
                                                  if (obscurePassword) {
                                                    iconPassword =
                                                        CupertinoIcons.eye_fill;
                                                  } else {
                                                    iconPassword =
                                                        CupertinoIcons
                                                            .eye_slash_fill;
                                                  }
                                                });
                                              },
                                              icon: Icon(iconPassword),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).upperCase,
                                                  style: TextStyle(
                                                      color: containsUpperCase
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                                Text(
                                                  S.of(context).lowerCase,
                                                  style: TextStyle(
                                                      color: containsLowerCase
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                                Text(
                                                  S.of(context).number,
                                                  style: TextStyle(
                                                      color: containsNumber
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).specialCharacter,
                                                  style: TextStyle(
                                                      color: containsSpecialChar
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                                Text(
                                                  S.of(context).eightCharacters,
                                                  style: TextStyle(
                                                      color: contains8Length
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),

                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: MyTextField(
                                            controller: emailController,
                                            hintText:
                                                S.of(context).emailAddress,
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
                                        const SizedBox(height: 30),

                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: '',
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: S
                                                        .of(context)
                                                        .bySelectingYouAgree,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.025),
                                                  ),
                                                  TextSpan(
                                                      text: S
                                                          .of(context)
                                                          .termsOfServices,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            MyButton(
                                             
                                              text: S
                                                  .of(context)
                                                  .agreeAndContinue,
                                              fun: () {
                                                if (_formKey.currentState!
                                                    .validate()) {

                                                  MyUser myUser = MyUser.empty;
                                                  myUser = myUser.copyWith(
                                                      email:
                                                          emailController.text,
                                                      name: nameController.text,
                                                      phoneNumber:
                                                          phoneController.text,
                                                      isVerified: false);

                                                  setState(() {
                                                    context
                                                        .read<SignUpBloc>()
                                                        .add(SignUpRequired(
                                                            myUser,
                                                            passwordController
                                                                .text));
                                                  });

                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
