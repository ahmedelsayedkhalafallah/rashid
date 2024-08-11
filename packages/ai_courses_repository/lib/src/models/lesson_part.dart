import 'package:ai_courses_repository/src/entities/entities.dart';

class LessonPart{
  int id;
  String accessId;
  String content;

  LessonPart({required this.id, required this.accessId, required this.content});

  static final empty = LessonPart(id: 0 , accessId: "", content: '');

  LessonPartEntity toEntity(){
    return LessonPartEntity(id: id, accessId: accessId, content:content);
  }

  static LessonPart fromEntity(LessonPartEntity lessonPartEntity){
    return LessonPart(id: lessonPartEntity.id, accessId: lessonPartEntity.accessId,content:  lessonPartEntity.content);
  }
}