import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/approve_syllable_bloc/approve_syllable_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/components/my_button.dart';
import 'package:user_repository/user_repository.dart';

import '../../blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';
import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class SuggestedCurriculumInputView extends StatefulWidget {
  final MyUser? myUser;
  final Curriculum curriculum;
  const SuggestedCurriculumInputView(
      {super.key, required this.curriculum, required this.myUser});

  @override
  State<SuggestedCurriculumInputView> createState() =>
      _SuggestedCurriculumInputViewState();
}

class _SuggestedCurriculumInputViewState
    extends State<SuggestedCurriculumInputView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> paragraph = [];
    paragraph.add("Great...!, your syllable have been generated...");
    paragraph.add("Now check it, and if you found it sufficient, save it");

    sayParagraph(paragraph, 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApproveSyllableBloc, ApproveSyllableState>(
      listener: (context, state) {
        if(state is SyllableSavingSuccess){
          context.read<CurrentViewBloc>().add(LaunchInitialView());
          showToast(msg: "Syllable saved", toastState: ToastState.SUCCESS);
        }else if(state is ApproveSyllableFailure){
          showToast(msg: state.message, toastState: ToastState.FAILURE);
        }
      },
      builder: (context, state) {
        if (state is ApproveSyllableLoading || state is SavingSyllable) {
          return Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
              child: loadingCard());
        } else {
          return Container(
            child: Stack(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: myBoolean,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Align(
                        child: Padding(
                      padding:
                          EdgeInsets.only(top: mediaQueryHeight(context) * .1),
                      child: SpeakingPrompt(),
                    ));
                  },
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryHeight(context) * .575),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //height: mediaQueryHeight(context) * .5,
                              width: mediaQueryWidth(context) * .85,
                              decoration: BoxDecoration(
                                  color: colorScheme(context)
                                      .surface
                                      .withOpacity(.5),
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24)),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: widget
                                        .curriculum.levels['1']?.courses.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String coursesKey = widget
                                          .curriculum.levels['1']!.courses.keys
                                          .elementAt(index);
                                      return Column(
                                        children: <Widget>[
                                          ExpansionTile(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide.none,
                                            ),
                                            title: Text(widget
                                                .curriculum
                                                .levels['1']!
                                                .courses[coursesKey]!
                                                .title),
                                            children: [
                                              Container(
                                                // height: mediaQueryHeight(context) * .4,
                                                width:
                                                    mediaQueryWidth(context) *
                                                        .7,
                                                decoration: BoxDecoration(
                                                    color: colorScheme(context)
                                                        .surface
                                                        .withOpacity(.5),
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24)),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  itemCount: widget
                                                      .curriculum
                                                      .levels['1']!
                                                      .courses[coursesKey]!
                                                      .units
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    String unitsKey = widget
                                                        .curriculum
                                                        .levels['1']!
                                                        .courses[coursesKey]!
                                                        .units
                                                        .keys
                                                        .elementAt(index);
                                                    return Column(
                                                      children: <Widget>[
                                                        ExpansionTile(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                BorderSide.none,
                                                          ),
                                                          title: Text(widget
                                                              .curriculum
                                                              .levels['1']!
                                                              .courses[
                                                                  coursesKey]!
                                                              .units[unitsKey]!
                                                              .title),
                                                          children: [
                                                            Container(
                                                              // height: mediaQueryHeight(
                                                              //         context) *
                                                              //     .3,
                                                              width: mediaQueryWidth(
                                                                      context) *
                                                                  .5,
                                                              decoration: BoxDecoration(
                                                                  color: colorScheme(
                                                                          context)
                                                                      .surface
                                                                      .withOpacity(
                                                                          .5),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .transparent),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24)),
                                                              child: ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    ClampingScrollPhysics(),
                                                                itemCount: widget
                                                                    .curriculum
                                                                    .levels[
                                                                        '1']!
                                                                    .courses[
                                                                        coursesKey]!
                                                                    .units[
                                                                        unitsKey]!
                                                                    .lessons
                                                                    .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  String lessonssKey = widget
                                                                      .curriculum
                                                                      .levels[
                                                                          '1']!
                                                                      .courses[
                                                                          coursesKey]!
                                                                      .units[
                                                                          unitsKey]!
                                                                      .lessons
                                                                      .keys
                                                                      .elementAt(
                                                                          index);
                                                                  return Column(
                                                                    children: <Widget>[
                                                                      ListTile(
                                                                        title: Text(widget.curriculum.levels['1']?.courses[coursesKey]?.units[unitsKey]?.lessons[lessonssKey]?.title ??
                                                                            ""),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Divider(
                                                                          height:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyButton(
                                        fun: () {
                                          curriculums ={};
                                          context
                                              .read<ApproveSyllableBloc>()
                                              .add(ApproveSyllable(
                                                  curriculum: widget.curriculum,
                                                  myUser: widget.myUser));
                                        },
                                        text: "Save my Courses"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyButton(
                                      color: colorScheme(context).surface,
                                      edgeInsets: EdgeInsets.symmetric(horizontal: 56),
                                      fun: () {
                                        context
                                            .read<CurrentViewBloc>()
                                            .add(LaunchInitialView());
                                      },
                                      text: "Try an other topic",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
