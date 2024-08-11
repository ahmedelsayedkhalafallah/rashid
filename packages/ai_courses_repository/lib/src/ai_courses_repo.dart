import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:user_repository/user_repository.dart';

import 'models/models.dart';

abstract class AiCoursesRepo{
  Future<Curriculum> getSingleLevelCurriculum(String learningTopic, String learningPurpose,String learningType);
  Future<Curriculum> getMultiLevelCurriculum(String learningTopic, String learningPurpose);
  Future<bool> validateTopicAndPurpose(String learningTopic, String learningPurpose);
  Future<Curriculum> generateSyllable(String learningTopic, String learningPurpose,String learningType);
  Future<Map<String, dynamic>> validateSyllableJSON(String syllableJSON);
  Future<Curriculum> makeSyllableContent(Curriculum curriculum);
  String getLessonPrompt(Curriculum curriculum, String courseId, String unitId, String lessonId);
  Future<Map<String, LessonPart>> getLessonContent(String prompt);
  Future saveCurriculum(Curriculum curriculum, MyUser? myUser);
  Future<Map<String, LessonPart>> generateLessonContent(Curriculum curriculum, String courseTitle, String unitTitle,String lessonTitle);
  Future<Map<String, Curriculum>> getUserCurriculums(MyUser? myUser);
  Future deleteCurriculum(Curriculum curriculum, MyUser myUser);
  Future<Curriculum> generateContent(Lesson lesson ,Curriculum curriculum,
      String courseTitle, String unitTitle, String lessonTitle);
  Future<String> getChatResponse(List<Content> chatContent);
}