import 'package:flutter/material.dart';

class SpeakingBot extends StatefulWidget {
  Animation<double> animation;
   SpeakingBot({super.key, required this.animation});

  @override
  State<SpeakingBot> createState() => _SpeakingBotState();
}

class _SpeakingBotState extends State<SpeakingBot> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0),
              child: Image.asset(
                'assets/images/bot_speak.png',
              ),),
          AnimatedOpacity(
            opacity: widget.animation.value,
            duration: Duration(milliseconds: 750),
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0),
              child: Image.asset(
                'assets/images/bot.png',
              ),
            ),
          ),
          
        ],
      );
  }
}