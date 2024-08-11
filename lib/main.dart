
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:rashid/app.dart';
import 'package:rashid/firebase_options.dart';
import 'package:rashid/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:io' show Platform;

import 'constants/global.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: "kyysh",
    options: DefaultFirebaseOptions.currentPlatform,
);
Gemini.init(apiKey: 'AIzaSyDkOVUQpcEebqp3ChuQ_GrbY6s7ROczd34');
 Bloc.observer = MyBlocObserver();
 if (Platform.isIOS) {
      await flutterTts.setSharedInstance(true);
    }
  runApp(  MyApp(userRepository: FirebaseUserRepo(),));
  
}


