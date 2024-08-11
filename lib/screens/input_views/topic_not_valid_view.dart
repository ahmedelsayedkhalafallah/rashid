import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';
import 'package:rashid/components/my_button.dart';

import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class TopicNotValidView extends StatefulWidget {
  const TopicNotValidView({super.key});

  @override
  State<TopicNotValidView> createState() => _TopicNotValidViewState();
}

class _TopicNotValidViewState extends State<TopicNotValidView> {
  @override
  void initState() {
    
    super.initState();
    List<String> paragraph = [];
    paragraph.add(
        "The topic you would like to learn and the purpose for learning are not valid");
        paragraph.add(
        "Go to the home screen and try something else");
    
    sayParagraph(paragraph,0);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: myBoolean,
            builder: (BuildContext context, bool value, Widget? child) {
              return Align(
                  child: Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
                child: SpeakingPrompt(),
              ));
            },
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
              width: mediaQueryWidth(context)*.9,
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
                child: Text(
                          "The topic you would like to learn and the purpose for learning are not valid",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: colorScheme(context).primary,
                             ),
                              
                        ),
                
              )
            ),
                    
                    SizedBox(
                      height: mediaQueryHeight(context) * .025,
                    ),
                    MyButton(
                        fun: () {
                          context
                              .read<CurrentViewBloc>()
                              .add(LaunchInitialView());
                        },
                        text: "Learn Something Else")
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
