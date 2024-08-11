// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/screens/auth/verify_screen.dart';

import 'package:user_repository/user_repository.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/reset_password_bloc/reset_password_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import '../../blocs/verification_bloc/verification_bloc.dart';
import '../../components/my_button.dart';
import '../../components/my_text_field.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';
import '../home/home_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  final MyUser? initialUser;
  const SignInScreen({super.key,required this.initialUser});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // text editing controllers
  final passwordController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    IconData iconPassword = CupertinoIcons.eye_fill;
    bool obscurePassword = true;
    String? errorMsg;
    return BlocConsumer<SignInBloc,SignInState>(listener:(context, state) {
      if(state is SignInSuccess){
       if(widget.initialUser!.isVerified){
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>MultiBlocProvider(providers: [
               BlocProvider<SignInBloc>(
                  create: (context) =>
                      SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                  
                ),
                BlocProvider<UpdateUserInfoBloc>(
                  create: (context) =>
                      UpdateUserInfoBloc(  context.read<AuthenticationBloc>().userRepository),
                  
                ),
                BlocProvider<MyUserBloc>(
                  create: (context) =>
                      MyUserBloc(  context.read<AuthenticationBloc>().userRepository)..add(GetMyUserEvent()),
                  
                ),
                BlocProvider(create:(context) => CurrentViewBloc()..add(LaunchInitialView()),)
                
                ],
             child: HomeScreen())));
       }else{
        Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => VerificationBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(SendVerificationCode(phoneNumber: widget.initialUser!.phoneNumber)),
              child: VerifyScreen(
                phoneNumber: widget.initialUser!.phoneNumber,
               
              ),
            );
          }));
       }
        }else if(state is SignInFailure){
          showToast(msg: S.of(context).wrongPassword, toastState: ToastState.FAILURE);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                  
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Form(
                          key: formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: mediaQueryWidth(context)*.05),
                                    child: Text(S.of(context).signIn,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: MediaQuery.of(context).size.height * 0.05,
                                                              fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(children: [
                                    (widget.initialUser?.profilePictureUrl == ""?
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            'assets/images/no-profile-image.png'),
                                        )
                                    :
                                     CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            widget.initialUser!.profilePictureUrl))),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(widget.initialUser?.name??"",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text(widget.initialUser?.phoneNumber??"",
                                            style:  TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.height * 0.015))
                                      ],
                                    )
                                  ]),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.09,
                                  child: MyTextField(
                                    controller: passwordController,
                                    hintText: S.of(context).password,
                                    obscureText: obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon:
                                        const Icon(CupertinoIcons.lock_fill),
                                    errorMsg: errorMsg,
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
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                          if (obscurePassword) {
                                            iconPassword =
                                                CupertinoIcons.eye_fill;
                                          } else {
                                            iconPassword =
                                                CupertinoIcons.eye_slash_fill;
                                          }
                                        });
                                      },
                                      icon: Icon(iconPassword),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyButton(
                               
                                  text: S.of(context).signIn,
                                  fun: () {
                                   context.read<SignInBloc>().add(SignInRequired(widget.initialUser?.email??"", passwordController.text));
                                  },
                                ),
                                // SizedBox(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.005),
                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => BlocProvider<
                                                                  ResetPasswordBloc>(
                                                              create:(context) => ResetPasswordBloc(
                                                                  context
                                                                      .read<
                                                                          AuthenticationBloc>()
                                                                      .userRepository),
                                                                      child: ForgotPasswordScreen() ,),
                                                        ));
                                                  },
                                                  child:Text(S.of(context).forgotPassword,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.height * 0.025),
                                    textAlign: TextAlign.start),)
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
    },);
  }
}
