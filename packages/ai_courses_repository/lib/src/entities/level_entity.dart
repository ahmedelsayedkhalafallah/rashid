import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';

class LevelEntity{
  int id;
  String accessId;
  String title;
    Map<String,Course> courses;


  LevelEntity({required this.id, required this.accessId, required this.courses, required this.title});

    static final empty = LevelEntity(id: 0 , accessId: "", courses:  {}, title: '');

    Map<String, Object?> toDocument(){
      Map<String,dynamic>coursesMap ={};
      courses.forEach((key, value){
        coursesMap.putIfAbsent(key, ()=>value.toEntity().toDocument());
      });
      return {
        'id': id,
        'accessId': accessId,
        'title':title,
        'courses':coursesMap
      };
    }

    static LevelEntity fromDocument(Map<String, dynamic> document){
      Map<String,Course>coursesMap ={};
      for(var course in document['levels']){
                

        coursesMap.putIfAbsent(course['id'].toString(), ()=>Course.fromEntity(CourseEntity.fromDocument(course)));
      };
      return LevelEntity(id: document['id'], accessId: document['accessId'], courses: coursesMap, title:document['title']);
    }
}