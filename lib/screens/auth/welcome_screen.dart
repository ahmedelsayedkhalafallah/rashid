// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/current_view_bloc/current_view_bloc.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/reset_password_bloc/reset_password_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../blocs/social_authentication_bloc/social_authentication_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import '../../blocs/verification_bloc/verification_bloc.dart';
import '../../components/my_button.dart';
import '../../components/my_phone_field.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';
import '../home/components/moving_bot.dart';
import '../home/home_screen.dart';
import 'components/square_tile.dart';
import 'forgot_password_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'verify_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // text editing controllers
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  final double _width = 350;

  final double _height = 300;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAuthenticationBloc, SocialAuthenticationState>(
        listener: (context, state) {
      if (state is SocialAuthenticationSuccess) {
        if (state.myUser.isVerified) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(providers: [
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                        ),
                        BlocProvider<UpdateUserInfoBloc>(
                          create: (context) => UpdateUserInfoBloc(context
                              .read<AuthenticationBloc>()
                              .userRepository),
                        ),
                        BlocProvider<MyUserBloc>(
                          create: (context) => MyUserBloc(
                              context.read<AuthenticationBloc>().userRepository)
                            ..add(GetMyUserEvent()),
                        ),
                                        BlocProvider(create:(context) => CurrentViewBloc()..add(LaunchInitialView()),)

                      ], child: HomeScreen())));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => VerificationBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(SendVerificationCode(
                    phoneNumber: state.myUser.phoneNumber)),
              child: VerifyScreen(
                phoneNumber: state.myUser.phoneNumber,
              ),
            );
          }));
        }
      } else if (state is SocialAuthenticationFailure) {
        showToast(
            msg: S.of(context).wrongPassword, toastState: ToastState.FAILURE);
      }
    }, builder: (context, state) {
      return BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInUserDoesNotExist) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => SignUpBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
                child: SignUpScreen(
                  phoneNumber: phoneController.text.trim(),
                ),
              );
            }));
          } else if (state is SignInUserExist) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
                child: SignInScreen(
                  initialUser: state.myUser,
                ),
              );
            }));
          }
        },
        builder: (context, state) {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        IconButton(
                          padding: EdgeInsets.only(
                              left: isArabic()
                                  ? MediaQuery.of(context).size.width * 0.7
                                  : 0,
                              right: isArabic()
                                  ? 0
                                  : MediaQuery.of(context).size.width * 0.7),
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: _sigmaX, sigmaY: _sigmaY),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 1)
                                      .withOpacity(_opacity),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.69,
                              child: state is! SignInCheck
                                  ? Form(
                                      key: _formKey,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: mediaQueryHeight(context)*.2,
                                              width: mediaQueryWidth(context)*.2,
                                              child: MovingBot()),
                                            
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: !isArabic()
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .1
                                                      : 0),
                                              child: Text(
                                                  S.of(context).welcomeSignIn,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                            // username textfield

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

                                            // sign in button
                                            MyButton(
                                              text: S
                                                  .of(context)
                                                  .continueButtonText,
                                              fun: (() {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  context.read<SignInBloc>()
                                                    ..add(SignInCheckUser(
                                                        phoneController.text
                                                            .trim()));
                                                } else {
                                                  print('not valid');
                                                }
                                              }),
                                            ),

                                            const SizedBox(height: 10),

                                            const SizedBox(height: 10),

                                            // not a member? register now
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .doNotHaveAnAccount,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        S.of(context).signUp,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                BlocProvider<
                                                                    ResetPasswordBloc>(
                                                              create: (context) =>
                                                                  ResetPasswordBloc(context
                                                                      .read<
                                                                          AuthenticationBloc>()
                                                                      .userRepository),
                                                              child:
                                                                  ForgotPasswordScreen(),
                                                            ),
                                                          ));
                                                    },
                                                    child: Text(
                                                        S
                                                            .of(context)
                                                            .forgotPassword,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.start),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                      height: 50.0,
                                      width: 50.0,
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
        },
      );
    });
  }
}
