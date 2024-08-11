import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rashid/blocs/current_view_bloc/current_view_bloc.dart';
import 'package:rashid/components/my_button.dart';

import '../../components/my_text_field.dart';
import '../../constants/global.dart';
import '../../generated/l10n.dart';
import '../home/components/speaking_prompt.dart';

class LearnToGetJobInputView extends StatefulWidget {
  const LearnToGetJobInputView({super.key});

  @override
  State<LearnToGetJobInputView> createState() => _LearnToGetJobInputViewState();
}

class _LearnToGetJobInputViewState extends State<LearnToGetJobInputView> {
  TextEditingController learningTopicController = TextEditingController();
  TextEditingController learningPurposeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = "";

  @override
  void initState() {
    List<String> paragraph = [];
    paragraph.add("Now tell me the topic you would like to learn...");
    paragraph.add(
        "And what is the job title you want to get by learning this topic");

    sayParagraph(paragraph,0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          
          Align(
                alignment: Alignment.center,
                  child:ValueListenableBuilder<bool>(
            valueListenable: myBoolean,
            builder: (BuildContext context, bool value, Widget? child) {
              return  Padding(
                padding: EdgeInsets.only(top: mediaQueryHeight(context) * .08),
                child: SpeakingPrompt(),
              );
            },
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
               // padding: EdgeInsets.only(bottom: mediaQueryHeight(context) * .1 ),
                width: mediaQueryWidth(context)*.9,
            height: mediaQueryHeight(context)*.3,
                child: Form(
                                  key: _formKey,
                                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: MyTextField(
                          controller: learningTopicController,
                          hintText: "what do you want to learn",
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.menu_book),
                          errorMsg: _errorMsg,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: MyTextField(
                          controller: learningPurposeController,
                          hintText: "What the job title you want to have",
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.work),
                          errorMsg: _errorMsg,
                        ),
                      ),
                    ),
                    MyButton(fun: (){
                      if(_formKey.currentState!.validate()){
                        learningTopic = learningTopicController.text;
                      learningPurpose = learningPurposeController.text;
                      learningType = "job";
                      context.read<CurrentViewBloc>().add(LaunchSelectCourseTypeInputView());
                      }

                    }, text: "Generate Syllable")
                  ],
                ),)
              ))
        ],
      ),
    );
  }
}
