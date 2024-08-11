import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rashid/blocs/ask_question_bloc/ask_question_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/components/my_text_field.dart';

import '../../components/my_button.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class AskQuestionView extends StatefulWidget {
  final Curriculum curriculum;
  final Lesson? lesson;
  final String courseTitle;
  final String unitTitle;
  AskQuestionView(
      {super.key,
      required this.curriculum,
      required this.lesson,
      required this.courseTitle,
      required this.unitTitle});

  @override
  State<AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends State<AskQuestionView> {
  List<Content> chatMessages = [];
  TextEditingController questionController = TextEditingController();
  @override
  void initState() {
    sayParagraph(["How can i help you...?"], 0);
    super.initState();
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
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .625),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              width: mediaQueryWidth(context) * .9,
                              height: mediaQueryHeight(context) * .185,
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.transparent),
                              //   borderRadius: BorderRadius.circular(24.0),
                              //   gradient: LinearGradient(
                              //     begin: Alignment.topLeft,
                              //     end: Alignment.bottomRight,
                              //     colors: [
                              //       colorScheme(context)
                              //           .surface
                              //           .withOpacity(.5),
                              //       Colors.white.withOpacity(.5)
                              //     ],
                              //   ),
                              // ),
                              child: BlocConsumer<AskQuestionBloc,
                                  AskQuestionState>(
                                listener: (context, state) {
                                  if (state is AskQuestionSuccess) {
                                    sayParagraph(["${state.response}"], 0);
                                    chatMessages.add(Content(
                                        role: "model",
                                        parts: [Parts(text: state.response)]));
                                  }
                                },
                                builder: (context, state) {
                                  log(state.toString());
                                  if (state is AskQuestionLoading) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                mediaQueryHeight(context) * .1),
                                        child: loadingCard());
                                  } else {
                                    return Container();
                                    // return Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Column(
                                    //     children: [
                                    //       Container(
                                    //           height:
                                    //               mediaQueryHeight(context) *
                                    //                   .155,
                                    //           child: ListView.builder(
                                    //             shrinkWrap: true,
                                    //             physics:
                                    //                 ClampingScrollPhysics(),
                                    //             itemCount: chatMessages.length,
                                    //             itemBuilder: (context, index) =>
                                    //                 Container(
                                    //               child: Markdown(
                                    //                 shrinkWrap: true,
                                    //                 physics:
                                    //                     NeverScrollableScrollPhysics(),
                                    //                 data: chatMessages[index]
                                    //                     .parts![0]
                                    //                     .text
                                    //                     .toString(),
                                    //                 styleSheet:
                                    //                     MarkdownStyleSheet(
                                    //                   a: TextStyle(
                                    //                       color: colorScheme(
                                    //                               context)
                                    //                           .primary,
                                    //                       fontWeight:
                                    //                           FontWeight.w700,
                                    //                       fontSize: 16),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ))
                                    //     ],
                                    //   ),
                                    // );
                                  }
                                },
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: mediaQueryWidth(context) * .25,
                              child: MyButton(
                                  color: colorScheme(context)
                                      .error
                                      .withOpacity(.5),
                                  edgeInsets:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  widget: Icon(
                                    Icons.close,
                                    size: 36,
                                  ),
                                  fun: () {
                                    
                                    context.read<CurrentViewBloc>().add(LaunchExplainLessonView(curriculum: widget.curriculum, lesson: widget.lesson, courseTitle: widget.courseTitle, unitTitle: widget.unitTitle));
                                  },
                                  text: "Done"),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: mediaQueryHeight(context) * .085,
                            child: MyTextField(
                                controller: questionController,
                                hintText: "Your Question",
                                obscureText: false,
                                keyboardType: TextInputType.name),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.only(top: 8),
                              width: mediaQueryWidth(context) * .25,
                              child: MyButton(
                                  edgeInsets:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  widget: Icon(
                                    Icons.send,
                                    size: 36,
                                  ),
                                  fun: () {
                                    if (questionController.text.isNotEmpty) {
                                      if (chatMessages.isEmpty) {
                                        chatMessages
                                            .add(Content(role: "user", parts: [
                                          Parts(
                                              text:
                                                  "You are an Expert teacher explaining a lesson called ${widget.lesson!.title} within a curriculum about learning ${widget.curriculum.curriculumTopic} to ${widget.curriculum.curriculumType == 'do' ? 'to make ' : widget.curriculum.curriculumType == 'job' ? 'to be ' : 'to research '}${widget.curriculum.curriculumPurpose} and this lesson is in ${widget.unitTitle} and the course ${widget.courseTitle} and while you are explaining the lesson your student asked you: ${questionController.text}")
                                        ]));
                                      } else {
                                        chatMessages.add(
                                            Content(role: "user", parts: [
                                          Parts(text: questionController.text)
                                        ]));
                                      }
                                      context.read<AskQuestionBloc>().add(
                                          AskQuestion(
                                              chatMessages: chatMessages));
                                      questionController.text = "";
                                    } else {
                                      showToast(
                                          msg: "Please type your question",
                                          toastState: ToastState.FAILURE);
                                    }
                                  },
                                  text: ""),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
