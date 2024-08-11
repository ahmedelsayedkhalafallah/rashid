import 'package:flutter/material.dart';

import '../../../components/typewriter_text.dart';
import '../../../constants/global.dart';

class SpeakingPrompt extends StatefulWidget {
  const SpeakingPrompt({super.key});

  @override
  State<SpeakingPrompt> createState() => _SpeakingPromptState();
}

class _SpeakingPromptState extends State<SpeakingPrompt> {
  @override
  Widget build(BuildContext context) {
    return Container(
              width: mediaQueryWidth(context)*.6,
              //height: mediaQueryHeight(context)*.075,
              decoration: BoxDecoration(
                
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(24.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorScheme(context).surface.withOpacity(.5), Colors.white.withOpacity(.5)],
                  
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: TypewriterText(text: typingText, style: TextStyle( fontWeight: FontWeight.w500))
                ,
              )
            );
  }
} 