import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:rashid/generated/l10n.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/current_view_bloc/current_view_bloc.dart';
import 'blocs/my_user_bloc/my_user_bloc.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';
import 'blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'blocs/verification_bloc/verification_bloc.dart';
import 'screens/auth/verify_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/introduction_animation/introduction_animation_screen.dart'; 

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            surface: Color(0xffe1e5ee),
            onSurface: Colors.black,
            primary: Colors.black,
            onPrimary: Colors.black,
            secondary: Color(0xff54e0ef),
            onSecondary: Colors.white,
            tertiary: Color(0xffedeeff),
            error: Colors.red,
            outline: Color(0xFF424242),

          ),
        ),
        title: "Rashid",
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            
            return MultiBlocProvider(providers: [
              BlocProvider<MyUserBloc>(
                create: (context) {
                  return MyUserBloc(
                      context.read<AuthenticationBloc>().userRepository)
                    ..add(GetMyUserEvent());
                },
              ),
              BlocProvider<SignInBloc>(create: (context) {
                return SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository);
              }),
              BlocProvider<UpdateUserInfoBloc>(
                create: (context) => UpdateUserInfoBloc(
                    context.read<AuthenticationBloc>().userRepository),
                    
              ),
                              BlocProvider(create:(context) => CurrentViewBloc()..add(LaunchInitialView()),)

            ], child: HomeScreen());
          } else if (state.status == AuthenticationStatus.notVerified) {
            return BlocProvider(
                create: (context) => VerificationBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(SendVerificationCode(
                      phoneNumber: state.myUser!.phoneNumber)),
                child: VerifyScreen(
                  phoneNumber: state.myUser!.phoneNumber,
                ));
          } else {
            return const IntroductionAnimationScreen();
          }
        }),
      );
  }
}
