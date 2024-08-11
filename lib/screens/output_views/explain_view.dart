import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rashid/constants/global.dart';

class ExplainView extends StatefulWidget {
  final List<LessonPart>? lessonParts;
  const ExplainView({super.key, required this.lessonParts});

  @override
  State<ExplainView> createState() => _ExplainViewState();
}

class _ExplainViewState extends State<ExplainView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> paragraph = [];
    for (var part in widget.lessonParts!) {
      paragraph.add(part.content);
    }

    sayLessonParts(paragraph, 1000);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: explainLessonIndex,
        builder: (BuildContext context, int value, Widget? child) {
          
          return Container(
            height: mediaQueryHeight(context) * .175,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.lessonParts!.length,
              itemBuilder: (context, index) => Container(
                child: Markdown(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                 data: widget.lessonParts![index].content,
                 styleSheet: MarkdownStyleSheet(a: TextStyle(
                      color: value == index
                          ? colorScheme(context).error
                          : colorScheme(context).primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                
                 
                ),
              ),
            )
          );
        });
  }
}
