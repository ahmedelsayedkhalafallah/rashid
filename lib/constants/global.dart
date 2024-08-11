import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

ValueNotifier<bool> myBoolean = ValueNotifier(false);
String typingText = "";
int voiceId = 0;
int typingTextLength = 0;
String learningTopic = "";
String learningPurpose = "";
String learningType = "do";
Map<String, Curriculum> curriculums ={};
bool curriculumsRefresh= false;
ValueNotifier<int> explainLessonIndex = ValueNotifier(-1);
int voiceLaunch = 0;

enum TtsState { playing, stopped, paused, continued }

FlutterTts flutterTts = FlutterTts();
TtsState ttsState = TtsState.stopped;

sayParagraph(List<String> paragraph, int delay) async {
  voiceId++;
  int paragraphVoiceId = voiceId;
  if (ttsState == TtsState.playing) {
    flutterTts.stop();
  }
      log('pvid = $paragraphVoiceId, vid= $voiceId ,');

  for (var phrase in paragraph) {
    while (myBoolean.value) {
      await Future.delayed(Duration(milliseconds: 50));
    }
    if (paragraphVoiceId == voiceId) {
      await saySomething(phrase, .4);
    } else {
      break;
    }
    while (!myBoolean.value) {
      await Future.delayed(Duration(milliseconds: 50));
    }
    await Future.delayed(Duration(milliseconds: delay));
  }
}

sayLessonParts(List<String> paragraph, int delay) async {
  voiceId++;
  int paragraphVoiceId = voiceId;
  if (ttsState == TtsState.playing) {
    flutterTts.stop();
  }
  
  for (var phrase in paragraph) {
    while (myBoolean.value) {
      await Future.delayed(Duration(milliseconds: 50));
      log('true delay');
    }
    
    if (paragraphVoiceId == voiceId&& ttsState != TtsState.paused) {
      log((paragraph.indexOf(phrase) == (explainLessonIndex.value+1)).toString());
      if(paragraph.indexOf(phrase) == (explainLessonIndex.value+1)){
        await saySomething(phrase, .3);
explainLessonIndex.value = explainLessonIndex.value +1;
      }
      
      while (ttsState == TtsState.playing) {
      await Future.delayed(Duration(milliseconds: 50));
      log('false delay');
    }
      
    } else {
      explainLessonIndex.value = explainLessonIndex.value -1;
      return;
    }
   
    await Future.delayed(Duration(milliseconds: delay));
  }
  explainLessonIndex.value = -1;
}

 Future saySomething(String speech, double speed) async {
  typingText = speech;
  typingTextLength = speech.length;
  flutterTts.setStartHandler(() {
    myBoolean.value = true;
    ttsState = TtsState.playing;
  });
  flutterTts.setCompletionHandler(() {
    myBoolean.value = false;
    ttsState = TtsState.stopped;
  });
  flutterTts.setSpeechRate(speed);
  flutterTts.setPitch(1.5);
  List<Object?> voices = await flutterTts.getVoices;

  List<String> jsonVoices = voices.map((e) => jsonEncode(e)).toList();

  List availVoices = jsonVoices.map((e) => jsonDecode(e)).toList();
  int voiceIndex = 8;
if (Platform.isAndroid) {
  voiceIndex = 2;
  flutterTts.setPitch(.5);
} else if (Platform.isIOS) {
  voiceIndex = 8;
}
  flutterTts.setVoice(
      {'name': availVoices[voiceIndex]['name'], 'locale': availVoices[voiceIndex]['locale']});
  await flutterTts.speak(speech);
}

colorScheme(BuildContext context) => Theme.of(context).colorScheme;
mediaQueryHeight(BuildContext context) => MediaQuery.of(context).size.height;
mediaQueryWidth(BuildContext context) => MediaQuery.of(context).size.width;
loadingCard() => Center(
      child: SizedBox(
        child: Center(child: CircularProgressIndicator()),
        height: 50.0,
        width: 50.0,
      ),
    );

enum ToastState { SUCCESS, WARNING, FAILURE }

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

showToast({required String msg, required ToastState toastState}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastState == ToastState.SUCCESS
          ? Colors.greenAccent
          : toastState == ToastState.WARNING
              ? Colors.yellowAccent
              : Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}

List mapToList(Map map) {
  List<dynamic> sortedList = [];
  Map sortedMap = Map.fromEntries(
      map.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  sortedMap.forEach((key, element) {
    sortedList.add(element);
  });
  return sortedList;
}
