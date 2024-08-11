import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class UnitEntity{
  int id;
  String accessId;
  String title;
  Map<String,Lesson> lessons;


  UnitEntity({required this.id, required this.accessId, required this.lessons, required this.title});

    static final empty = UnitEntity(id: 0 , accessId: "" , lessons: {}, title: '');

    Map<String, Object?> toDocument(){
      Map<String,dynamic>lessonsMap ={};
      lessons.forEach((key, value){
        lessonsMap.putIfAbsent(key, ()=>value.toEntity().toDocument());
      });
      return {
        'id': id,
        'title':title,
        'accessId': accessId,
        'lessons': lessonsMap
      };
    }

    static UnitEntity fromDocument(Map<String, dynamic> document){
      Map<String,Lesson>lessonsMap ={};
      for(var lesson in document['lessons']){
        
        lessonsMap.putIfAbsent(lesson['id'].toString(), ()=>Lesson.fromEntity(LessonEntity.fromDocument(lesson)));
      };
      return UnitEntity(id: document['id'], accessId: document['accessId'], lessons: lessonsMap, title:document['title']);
    }
}