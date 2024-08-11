import 'dart:developer';

import 'package:ai_courses_repository/src/models/models.dart';

class LessonEntity{
  int id;
  String accessId;
  String title;
  Map<String, LessonPart> lessonParts;

  LessonEntity({required this.id, required this.accessId, required this.lessonParts, required this.title});

    static final empty = LessonEntity(id: 0 , accessId: "", lessonParts: {},title:'');

    Map<String, Object?> toDocument(){
      Map<String,dynamic>lessonPartsMap ={};
      lessonParts.forEach((key, value){
        lessonPartsMap.putIfAbsent(key, ()=>value.toEntity().toDocument());
      });
      return {
        'id': id,
        'accessId': accessId,
        'title':title,
        'lessonParts':lessonPartsMap
      };
    }

    static LessonEntity fromDocument(Map<String, dynamic> document){
      Map<String,LessonPart>lessonPartsMap ={};
      if(document['lessonParts'] != null){
        for( var lessonPart in document['lessonParts'].values){
               

        lessonPartsMap.putIfAbsent(lessonPart['id'].toString(), ()=>LessonPart.fromEntity(lessonPart));
      };
      }
      
      return LessonEntity(id: document['id'], accessId: document['accessId'], lessonParts: lessonPartsMap,title:document['title']);
    }
}