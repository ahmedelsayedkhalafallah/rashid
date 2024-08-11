import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/approve_syllable_bloc/approve_syllable_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/delete_curriculum_bloc/delete_curriculum_bloc.dart';
import 'package:rashid/components/my_button.dart';
import 'package:user_repository/user_repository.dart';

import '../../blocs/get_lesson_contentbloc/get_lesson_content_bloc.dart';
import '../../blocs/get_user_curriculum_bloc/get_user_curriculum_bloc.dart';
import '../../blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';
import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class CurriculumView extends StatefulWidget {
  final Curriculum curriculum;
  final MyUser? myUser;
  const CurriculumView(
      {super.key, required this.curriculum, required this.myUser});

  @override
  State<CurriculumView> createState() => _CurriculumViewState();
}

class _CurriculumViewState extends State<CurriculumView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> paragraph = [];
    paragraph.add("Here is your curriculum, Download lessons content to start studying...");
    

    sayParagraph(paragraph, 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCurriculumBloc, DeleteCurriculumState>(
      listener: (context, state) {
        if (state is DeleteCurriculumSuccess) {
          context.read<CurrentViewBloc>().add(LaunchInitialView());
          showToast(msg: "Curriculum deleted", toastState: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        if (state is DeleteCurriculumLoading) {
          return Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
              child: loadingCard());
        } else {
          return BlocConsumer<GetLessonContentBloc, GetLessonContentState>(
            listener: (context, getLessonState) {
              if(getLessonState is GetLessonContentSuccess){
                setState(() {
                  widget.curriculum.copyWith(
                    accessId: getLessonState.curriculum.accessId,
                    levels: getLessonState.curriculum.levels,
                    curriculumPurpose: getLessonState.curriculum.curriculumPurpose,
                    curriculumTopic: getLessonState.curriculum.curriculumTopic,
                    curriculumType: getLessonState.curriculum.curriculumType
                  );
                });
              }
            },
            builder: (context, getLessonState) {
              if (getLessonState is GetLessonContentLoading) {
          return Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
              child: loadingCard());
        } else {
              return Container(
                child: Stack(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: myBoolean,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return Align(
                            child: Padding(
                          padding: EdgeInsets.only(
                              top: mediaQueryHeight(context) * .1),
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
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: widget.curriculum.levels['1']
                                            ?.courses.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String coursesKey = widget.curriculum
                                              .levels['1']!.courses.keys
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
                                                    width: mediaQueryWidth(
                                                            context) *
                                                        .7,
                                                    decoration: BoxDecoration(
                                                        color: colorScheme(
                                                                context)
                                                            .surface
                                                            .withOpacity(.5),
                                                        border: Border.all(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24)),
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
                                                            .courses[
                                                                coursesKey]!
                                                            .units
                                                            .keys
                                                            .elementAt(index);
                                                            Course? course  = widget
                                                            .curriculum
                                                            .levels['1']!
                                                            .courses[
                                                                coursesKey];
                                                            Unit? unit =widget
                                                                  .curriculum
                                                                  .levels['1']!
                                                                  .courses[
                                                                      coursesKey]!
                                                                  .units[
                                                                      unitsKey];
                                                        return Column(
                                                          children: <Widget>[
                                                            ExpansionTile(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                              ),
                                                              title: Text(widget
                                                                  .curriculum
                                                                  .levels['1']!
                                                                  .courses[
                                                                      coursesKey]!
                                                                  .units[
                                                                      unitsKey]!
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
                                                                          BorderRadius.circular(
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
                                                                      Lesson? lesson = widget
                                                                          .curriculum
                                                                          .levels[
                                                                              '1']
                                                                          ?.courses[
                                                                              coursesKey]
                                                                          ?.units[
                                                                              unitsKey]
                                                                          ?.lessons[lessonssKey];
                                                                      bool isCreated = (lesson?.lessonParts == {} ||
                                                                              lesson!.lessonParts.isEmpty)
                                                                          ? false
                                                                          : true;
                                                                      return Column(
                                                                        children: <Widget>[
                                                                          ListTile(
                                                                            title:
                                                                                Row(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    if(isCreated){
                                                                                      context.read<CurrentViewBloc>().add(LaunchExplainLessonView(curriculum: widget.curriculum, lesson: lesson, courseTitle: course!.title, unitTitle: unit!.title));
                                                                                    }else{
                                                                                      showToast(msg: "Download Lesson Content first", toastState: ToastState.FAILURE);
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    width: mediaQueryWidth(context) * .25,
                                                                                    child: Text(lesson?.title ?? ""),
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    if(isCreated){

                                                                                    }else{
                                                                                      curriculums = {};
                                                                                    context.read<GetLessonContentBloc>().add(GetLessonContent(lesson: lesson, curriculum: widget.curriculum, courseTitle: course?.title??"", unitTitle: unit?.title??"", lessonTitle: lesson?.title??""));

                                                                                    }
                                                                                  },
                                                                                  icon: Icon((isCreated ? Icons.circle : Icons.download)),
                                                                                  color: isCreated ? colorScheme(context).secondary : colorScheme(context).error,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Divider(
                                                                              height: 2.0,
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
                                            curriculums = {};
                                            context
                                                .read<DeleteCurriculumBloc>()
                                                .add(DeleteCurriculum(
                                                    curriculum:
                                                        widget.curriculum,
                                                    myUser: widget.myUser!));
                                          },
                                          text: "Delete this curriculum",
                                          color: colorScheme(context)
                                              .error
                                              .withOpacity(.75),
                                          edgeInsets: EdgeInsets.symmetric(
                                              horizontal: 56),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              );}
            },
          );
        }
      },
    );
  }
}
