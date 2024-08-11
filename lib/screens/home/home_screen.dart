import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rashid/blocs/approve_syllable_bloc/approve_syllable_bloc.dart';
import 'package:rashid/blocs/ask_question_bloc/ask_question_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/blocs/delete_curriculum_bloc/delete_curriculum_bloc.dart';
import 'package:rashid/blocs/get_user_curriculum_bloc/get_user_curriculum_bloc.dart';
import 'package:rashid/blocs/make_single_syllable_bloc/make_single_syllable_bloc.dart';
import 'package:rashid/components/moving_card.dart';
import 'package:rashid/components/typewriter_text.dart';
import 'package:rashid/constants/global.dart';
import 'package:rashid/screens/home/components/moving_bot.dart';
import 'package:rashid/screens/home/components/speaking_prompt.dart';
import 'package:rashid/screens/input_views/initial_view.dart';
import 'package:rashid/screens/home/components/open_drawer_icon.dart';
import 'package:rashid/screens/input_views/learn_to_do_input_view.dart';
import 'package:rashid/screens/input_views/learn_to_get_job_input_view.dart';
import 'package:rashid/screens/input_views/learn_to_research_input_view.dart';
import 'package:rashid/screens/input_views/select_type_view.dart';
import 'package:rashid/screens/input_views/suggested_curriculum_input_view.dart';
import 'package:rashid/screens/input_views/topic_not_valid_view.dart';
import 'package:rashid/screens/output_views/ask_question_view.dart';
import 'package:rashid/screens/output_views/curriculum_view.dart';
import 'package:rashid/screens/output_views/explain_lesson_view.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/get_lesson_contentbloc/get_lesson_content_bloc.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/social_authentication_bloc/social_authentication_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:provider/provider.dart';
import '../auth/welcome_screen.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController? _animationController;

  int count = 9;

  @override
  void initState() {
    List<String> paragraph = [];
    paragraph.add(
        "Hello, This is Rashidh..., your learning assistant.., How can i help you?");
    paragraph
        .add("Choose the learning purpose to start a new learning journey");
    paragraph.add(
        "do you want to learn to get a job..., do something, or to research");
        log('home');
    sayParagraph(paragraph, 0);
    super.initState();
    voiceLaunch = 0;
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, myUserState) {
        if (myUserState.status == MyUserStatus.success) {
          return BlocConsumer<UpdateUserInfoBloc, UpdateUserInfoState>(
            listener: (context, state) {
              if (state is UploadPictureSuccess) {
                setState(() {
                  context.read<MyUserBloc>().state.myUser!.profilePictureUrl =
                      state.userImageDownloadUrl;
                });
              }
            },
            builder: (context, state) {
              return BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignOut) {
                    // Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<SignInBloc>(
                                      create: (context) => SignInBloc(
                                          userRepository: context
                                              .read<AuthenticationBloc>()
                                              .userRepository),
                                    ),
                                    BlocProvider<SocialAuthenticationBloc>(
                                      create: (context) =>
                                          SocialAuthenticationBloc(context
                                              .read<AuthenticationBloc>()
                                              .userRepository),
                                    )
                                  ],
                                  child: WelcomeScreen(),
                                )));
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Container(
                      width: mediaQueryWidth(context),
                      height: mediaQueryHeight(context),
                      child: Scaffold(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          key: _scaffoldKey,
                          drawer: DrawerScreen(
                            myUser: myUserState.myUser,
                          ),
                          body: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/background.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ActionIcon(
                                              iconData: Icons.menu,
                                              onTap: () {
                                                _scaffoldKey.currentState!
                                                    .openDrawer();
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: ActionIcon(
                                                iconData: Icons.home,
                                                onTap: () {
                                                  context
                                                      .read<CurrentViewBloc>()
                                                      .add(LaunchInitialView());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: mediaQueryHeight(context) *
                                                    .1),
                                            child: MovingBot(),
                                          )),
                                      BlocConsumer<CurrentViewBloc,
                                          CurrentViewState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          if (state
                                              is CurrentViewLearnToGetJobInput) {
                                            return LearnToGetJobInputView();
                                          } else if (state
                                              is CurrentViewLearnToDoInput) {
                                            return LearnToDoInputView();
                                          } else if (state
                                              is CurrentViewLearnToResearchInput) {
                                            return LearnToResearchInputView();
                                          } else if (state
                                              is CurrentViewSelectType) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      MakeSingleSyllableBloc(
                                                          FirebaseAiCoursesRepo()),
                                                ),
                                              ],
                                              child: SelectTypeView(),
                                            );
                                          } else if (state
                                              is CurrentViewLoadingCard) {
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    top: mediaQueryHeight(
                                                            context) *
                                                        .1),
                                                child: loadingCard());
                                          } else if (state
                                              is CurrentViewCurriculumLoaded) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  ApproveSyllableBloc(
                                                      FirebaseAiCoursesRepo()),
                                              child:
                                                  SuggestedCurriculumInputView(
                                                curriculum: state.curriculum,
                                                myUser: myUserState.myUser,
                                              ),
                                            );
                                          } else if (state
                                              is CurrentViewTopicNotValid) {
                                            return TopicNotValidView();
                                          } else if (state
                                              is CurrentViewCurriculumView) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      DeleteCurriculumBloc(
                                                          FirebaseAiCoursesRepo()),
                                                ),
                                                BlocProvider(
                                                  create: (context) =>
                                                      GetLessonContentBloc(
                                                          FirebaseAiCoursesRepo()),
                                                )
                                              ],
                                              child: CurriculumView(
                                                curriculum: state.curriculum,
                                                myUser: myUserState.myUser,
                                              ),
                                            );
                                          } else if (state
                                              is CurrentViewExplainLessonView) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(create:(context) => AskQuestionBloc(FirebaseAiCoursesRepo()),)
                                              ],
                                              child: ExplainLessonView(
                                                curriculum: state.curriculum,
                                                lesson: state.lesson,
                                                courseTitle: state.courseTitle,
                                                unitTitle: state.unitTitle,
                                              ),
                                            );
                                          } else if (state
                                              is CurrentViewAskQuestionView) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      AskQuestionBloc(
                                                          FirebaseAiCoursesRepo()),
                                                )
                                              ],
                                              child: AskQuestionView(
                                                curriculum: state.curriculum,
                                                lesson: state.lesson,
                                                courseTitle: state.courseTitle,
                                                unitTitle: state.unitTitle,
                                              ),
                                            );
                                          } else {
                                            if(voiceLaunch !=0){
                                              
                                            }
                                            if(voiceLaunch !=0){
                                              sayParagraph(["What would you like to learn...?"], 0);
                                            }
                                            
                                            
                                            return BlocProvider(
                                              create: (context) =>
                                                  GetUserCurriculumBloc(
                                                      FirebaseAiCoursesRepo())
                                                    ..add(GetUserCurriculum(
                                                        myUser:
                                                            myUserState.myUser,
                                                        refresh:
                                                            curriculumsRefresh)),
                                              child: InitialView(
                                                myUser: myUserState.myUser,
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  )))),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight(context) * .1),
              child: loadingCard());
        }
      },
    );
  }
}
