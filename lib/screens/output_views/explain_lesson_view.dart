import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';
import 'package:rashid/components/my_button.dart';
import 'package:rashid/screens/home/components/moving_bot.dart';
import 'package:rashid/screens/output_views/explain_view.dart';

import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class ExplainLessonView extends StatefulWidget {
  final Lesson? lesson;
  final Curriculum curriculum;
  final String courseTitle;
  final String unitTitle;
  const ExplainLessonView(
      {super.key, required this.curriculum, required this.lesson, required this.courseTitle, required this.unitTitle});

  @override
  State<ExplainLessonView> createState() => _ExplainLessonViewState();
}

class _ExplainLessonViewState extends State<ExplainLessonView> {
  List<LessonPart>? lessonParts = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lessonParts = widget.lesson?.lessonParts.values
        .map(
          (lessonPart) => lessonPart,
        )
        .toList();
    lessonParts?.sort((a, b) => a.id.compareTo(b.id));

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
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .65),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: mediaQueryWidth(context) * .9,
                          height: mediaQueryHeight(context) * .2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(24.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorScheme(context).surface.withOpacity(.5),
                                Colors.white.withOpacity(.5)
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [Stack(
                                children: [

                                  ExplainView(lessonParts: lessonParts),
                                  Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: mediaQueryWidth(context) * .25,
                              child: MyButton(
                                  color: colorScheme(context)
                                      .error
                                      .withOpacity(.5),
                                  edgeInsets:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  widget: Icon(
                                    Icons.arrow_back,
                                    size: 36,
                                  ),
                                  fun: () {
                                    
                                    context.read<CurrentViewBloc>().add(LaunchCurriculumView(curriculum: widget.curriculum,));
                                  },
                                  text: ""),
                            ),
                          ),
                                ],
                              )],
                            ),
                          )),
                      SizedBox(
                        height: mediaQueryHeight(context) * .025,
                      ),
                      MyButton(
                        widget: MovingBot(),
                          fun: () {
                            ttsState = TtsState.paused;
                            context
                                .read<CurrentViewBloc>()
                                .add(LaunchAskQuestionView(curriculum: widget.curriculum, lesson: widget.lesson, courseTitle: '', unitTitle: ''));
                          },
                          text: "Ask a Qestion")
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
