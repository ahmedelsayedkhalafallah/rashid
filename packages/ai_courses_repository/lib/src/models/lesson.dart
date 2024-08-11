import 'package:ai_courses_repository/src/entities/entities.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class Lesson{
  int id;
  String accessId;
  String title;
  Map<String, LessonPart> lessonParts;

  Lesson({required this.id, required this.accessId, required this.lessonParts, required this.title});

  static final empty = Lesson(id: 0 , accessId: "", lessonParts: {}, title:'');

  LessonEntity toEntity(){
    return LessonEntity(id: id, accessId: accessId, lessonParts: lessonParts, title:title);
  }

  static Lesson fromEntity(LessonEntity lessonEntity){
    return Lesson(id: lessonEntity.id, accessId: lessonEntity.accessId, lessonParts: lessonEntity.lessonParts, title:lessonEntity.title);
  }
}