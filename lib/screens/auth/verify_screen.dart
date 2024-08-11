// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/current_view_bloc/current_view_bloc.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import '../../blocs/verification_bloc/verification_bloc.dart';
import '../../components/my_button.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';
import '../home/home_screen.dart';
import 'components/verify_field.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  //final AnimationController? animationController;
  const VerifyScreen(
      {super.key,
     // required this.animationController,
      required this.phoneNumber});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  // text editing controllers
  final input1Controller = TextEditingController();
  final input2Controller = TextEditingController();
  final input3Controller = TextEditingController();
  final input4Controller = TextEditingController();
  final input5Controller = TextEditingController();
  final input6Controller = TextEditingController();
  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    IconData iconPassword = CupertinoIcons.eye_fill;
    bool obscurePassword = true;
    String? errorMsg;
    return BlocConsumer<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationMatchingSuccess) {
         Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MultiBlocProvider(
              providers:[
               BlocProvider(create:  (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),),
               BlocProvider(create:  (context) => MyUserBloc(
                 
                      context.read<AuthenticationBloc>().userRepository)..add(GetMyUserEvent()),),
                      BlocProvider(create:  (context) => UpdateUserInfoBloc(
                 
                      context.read<AuthenticationBloc>().userRepository),),
                                      BlocProvider(create:(context) => CurrentViewBloc()..add(LaunchInitialView()),)

                             
              ], 
              child: HomeScreen(),
            );
          }));
        
        } else if (state is VerificationSendFaild) {
          Navigator.pop(context);
          showToast(
              msg: state.message.toString(), toastState: ToastState.FAILURE);
        }
      },
      builder: (context, state) {
        if (state is VerificationSendSuccess) {
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
                        Text(S.of(context).signIn,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                key: formKey,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      Row(
                                        children: [
                                          VerifyField(
                                              errorMsg: errorMsg,
                                              inputController: input1Controller,
                                              focusNode: isArabic() ? f1 : f6,
                                              nextNode: isArabic() ? f2 : f5,
                                              previousNode: null,
                                              nextController: input2Controller,
                                              autoFocus: true),
                                          VerifyField(
                                            errorMsg: errorMsg,
                                            inputController: input2Controller,
                                            focusNode: isArabic() ? f2 : f5,
                                            nextNode: isArabic() ? f3 : f4,
                                            previousNode: isArabic() ? f1 : f6,
                                            nextController: input3Controller,
                                          ),
                                          VerifyField(
                                            errorMsg: errorMsg,
                                            inputController: input3Controller,
                                            focusNode: isArabic() ? f3 : f4,
                                            nextNode: isArabic() ? f4 : f3,
                                            previousNode: isArabic() ? f2 : f5,
                                            nextController: input4Controller,
                                          ),
                                          VerifyField(
                                            errorMsg: errorMsg,
                                            inputController: input4Controller,
                                            focusNode: isArabic() ? f4 : f3,
                                            nextNode: isArabic() ? f5 : f2,
                                            previousNode: isArabic() ? f3 : f4,
                                            nextController: input5Controller,
                                          ),
                                          VerifyField(
                                            errorMsg: errorMsg,
                                            inputController: input5Controller,
                                            focusNode: isArabic() ? f5 : f2,
                                            nextNode: isArabic() ? f6 : f1,
                                            previousNode: isArabic() ? f4 : f3,
                                            nextController: input6Controller,
                                          ),
                                          VerifyField(
                                              errorMsg: errorMsg,
                                              inputController: input6Controller,
                                              focusNode: isArabic() ? f6 : f1,
                                              previousNode:
                                                  isArabic() ? f5 : f2,
                                              nextController: input6Controller,
                                              nextNode: null),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      MyButton(
                                        
                                        text: S.of(context).signIn,
                                        fun: () {
                                          if (formKey.currentState!
                                                    .validate()) {
                                          context.read<VerificationBloc>().add(
                                              VerifyCode(
                                                  phoneNumber:
                                                      widget.phoneNumber,
                                                  smsCode: input1Controller
                                                          .text +
                                                      input2Controller.text +
                                                      input3Controller.text +
                                                      input4Controller.text +
                                                      input5Controller.text +
                                                      input6Controller.text));}
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
        // else if (state is VerificationSendFaild) {
        //   Navigator.pop(context);
        //   showToast(
        //       msg: state.message.toString(), toastState: ToastState.FAILURE);
        // }
        else if (state is VerificationSendCode) {
          return SizedBox(
            child: Center(child: CircularProgressIndicator()),
            height: 50.0,
            width: 50.0,
          );
        } else if (state is VerificationMatching) {
          return SizedBox(
            child: Center(child: CircularProgressIndicator()),
            height: 50.0,
            width: 50.0,
          );
        }
        // else if (state is VerificationMatchingSuccess) {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (BuildContext context) {
        //     return BlocProvider(
        //       create: (context) => VerificationBloc(
        //           userRepository:
        //               context.read<AuthenticationBloc>().userRepository),
        //       child: HomeScreen(),
        //     );
        //   }));

        // }
        else {
          return Container();
        }
      },
    );
  }
}
