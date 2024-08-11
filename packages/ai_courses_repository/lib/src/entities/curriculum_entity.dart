import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:flutter/material.dart';

class CurriculumEntity{
  Map<String,Level> levels;
  String accessId;
   String? curriculumTopic;
   String? curriculumPurpose;
   String? curriculumType;

   CurriculumEntity({required this.accessId, required this.levels, this.curriculumTopic, this.curriculumPurpose, this.curriculumType});

    static final empty = CurriculumEntity( accessId: "", levels: {});

    Map<String, Object?> toDocument(){
      Map<String,dynamic>levelsMap ={};
      levels.forEach((key, value){
        levelsMap.putIfAbsent(key, ()=>value.toEntity().toDocument());
      });
      return {
        'levels': levelsMap,
        'accessId': accessId
      };
    }

    static CurriculumEntity fromDocument(Map<String, dynamic> document){
      Map<String,Level>levelsMap ={};
      document['levels'].forEach((key, value){
        levelsMap.putIfAbsent(key, ()=>Level.fromEntity(value));
      });
      return CurriculumEntity( accessId: document['accessId'], levels: levelsMap);
    }
}