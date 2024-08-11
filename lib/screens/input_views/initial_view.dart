import 'dart:math';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/get_user_curriculum_bloc/get_user_curriculum_bloc.dart';
import 'package:rashid/components/curriculum_card.dart';
import 'package:user_repository/user_repository.dart';

import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class InitialView extends StatefulWidget {
  final MyUser? myUser;
  InitialView({super.key, required this.myUser});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  void initState() {
    if(curriculumsRefresh){
      curriculumsRefresh = false;
    }
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
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .35),
                child: Row(
                  children: [
                    MovingCard(
                        cardText: "Learn to get a Job",
                        height: mediaQueryHeight(context) * .15,
                        width: mediaQueryHeight(context) * .12,
                        imagePath: "assets/images/job.png",
                        movingUp: true,
                        onTap: () {
                          context
                              .read<CurrentViewBloc>()
                              .add(LaunchLearnToGetJobInputView());
                        }),
                    SizedBox(
                      width: mediaQueryWidth(context) * .009,
                    ),
                    MovingCard(
                        cardText: "Learn to do something",
                        height: mediaQueryHeight(context) * .15,
                        width: mediaQueryHeight(context) * .12,
                        imagePath: "assets/images/do.png",
                        movingUp: false,
                        onTap: () {
                          context
                              .read<CurrentViewBloc>()
                              .add(LaunchLearnToDoInputView());
                        }),
                    SizedBox(
                      width: mediaQueryWidth(context) * .009,
                    ),
                    MovingCard(
                        cardText: "Learn to do Research",
                        height: mediaQueryHeight(context) * .15,
                        width: mediaQueryHeight(context) * .12,
                        imagePath: "assets/images/research.png",
                        movingUp: true,
                        onTap: () {
                          context
                              .read<CurrentViewBloc>()
                              .add(LaunchLearnToReseachInputView());
                        }),
                  ],
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding:
                      EdgeInsets.only(top: mediaQueryHeight(context) * .0),
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
                            child: BlocConsumer<GetUserCurriculumBloc,
                                GetUserCurriculumState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is GetUserCurriculumSuccess) {
                                  Map<String, Curriculum> userCurriculums =
                                      state.userCurriculums;

                                  return Stack(
                                    
                                    children: [
                                      
                                      Container(
                                        width: mediaQueryWidth(context),
                                        height: mediaQueryHeight(context)*.19,
                                        child: GridView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisExtent: mediaQueryHeight(context)*.18,
                                                  
                                                  ),
                                                  
                                          children: userCurriculums.entries
                                              .map<Padding>(
                                                (entry) => Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                  child: CurriculumCard(
                                                    
                                                      curriculum: entry.value,
                                                      height:
                                                          mediaQueryHeight(context) *
                                                              .18,
                                                      width: mediaQueryHeight(context) *
                                                          .12,
                                                      imagePath:
                                                          "assets/images/courses.png",
                                                      movingUp: Random().nextDouble() <= 0.7,
                                                      onTap: () {
                                                        context.read<CurrentViewBloc>().add(
                                                            LaunchCurriculumView(curriculum: entry.value));
                                                      }),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      Align(alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colorScheme(context).surface.withOpacity(.75),
                                            border: Border.all(
                                              color: Colors.transparent
                                            ),
                                            borderRadius: BorderRadius.circular(24)
                                          ),
                                          child: Row(
                                            children: [
                                              Text("Your Curriculums", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                                              IconButton(
                                                onPressed: () {
                                                  
                                                  context.read<GetUserCurriculumBloc>().add(GetUserCurriculum(myUser: widget.myUser, refresh: true));
                                                },
                                                icon: Icon(Icons.refresh))
                                            ],
                                          ),
                                        )),
                                    ],
                                  );
                                } else {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: mediaQueryHeight(context) * .1),
                                      child: loadingCard());
                                }
                              },
                            ))
                      ]))))
        ],
      ),
    );
  }
}
