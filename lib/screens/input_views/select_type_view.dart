import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';

import '../../components/moving_card.dart';
import '../../constants/global.dart';
import '../home/components/speaking_prompt.dart';

class SelectTypeView extends StatefulWidget {
  const SelectTypeView({super.key});

  @override
  State<SelectTypeView> createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeSingleSyllableBloc, MakeSingleSyllableState>(
      listener: (context, state) {
        if (state is MakeSingleSyllableTopicNotValid) {
          context.read<CurrentViewBloc>().add(LaunchTopicNotValid());
        } else if (state is MakeSingleSyllableloading) {
          List<String> paragraph = [];
          paragraph
              .add("Okay, i am working on generating the syllable for you");
          paragraph.add(
              "Using Google Gemini i am building you the best syllable from the available data on the web");
          paragraph
              .add("It takes a time to get the best available form of data");
          paragraph.add("Please wait, it is loading");
          paragraph.add("Your syllable is about to be produced");
          paragraph
              .add("Some times it is late, but it comes with a better results");
          paragraph.add("We are about to make it, are you ready?");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");
          paragraph.add("Loading");

          sayParagraph(paragraph, 15000);
        }
      },
      builder: (context, state) {
        if (state is MakeSingleSyllableloading) {
          return Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
              child: loadingCard());
        } else if (state is MakeSingleSyllableSuccess) {
          context
              .read<CurrentViewBloc>()
              .add(LaunchCurriculumLoaded(curriculum: state.curriculum));
          return Container();
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
                      padding:
                          EdgeInsets.only(top: mediaQueryHeight(context) * .35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MovingCard(
                              cardText: "One Course",
                              height: mediaQueryHeight(context) * .15,
                              width: mediaQueryHeight(context) * .12,
                              imagePath: "assets/images/courses.png",
                              movingUp: true,
                              onTap: () {
                                
                                context
                                    .read<MakeSingleSyllableBloc>()
                                    .add(CreateSingleSyllable());
                              }),
                          // SizedBox(
                          //   width: mediaQueryWidth(context) * .02,
                          // ),
                          // MovingCard(
                          //     cardText: "Complete Specialization",
                          //     height: mediaQueryHeight(context) * .15,
                          //     width: mediaQueryHeight(context) * .12,
                          //     imagePath: "assets/images/library.png",
                          //     movingUp: false,
                          //     onTap: () {
                          //       learningType = "multi";
                          //       context.read<CurrentViewBloc>().add(LaunchLoadingCard());
                          //     }),
                        ],
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
