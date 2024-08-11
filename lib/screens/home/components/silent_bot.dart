import 'package:flutter/material.dart';

class SilentBot extends StatefulWidget {
  const SilentBot({super.key});

  @override
  State<SilentBot> createState() => _SilentBotState();
}

class _SilentBotState extends State<SilentBot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0),
              child: Image.asset(
                'assets/images/bot_speak.png',
              ),);
  }
}