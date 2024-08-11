import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class CourseEntity{
  int id;
  String accessId;
  String title;
  Map<String,Unit> units;

  CourseEntity({required this.id, required this.accessId, required this.units, required this.title});

    static final empty = CourseEntity(id: 0 , accessId: "",units:  {},title:'');
    
    Map<String, Object?> toDocument(){
      Map<String,dynamic>unitsMap ={};
      units.forEach((key, value){
        unitsMap.putIfAbsent(key, ()=>value.toEntity().toDocument());
      });
      return {
        'id': id,
        'accessId': accessId,
        'title':title,
        'units': unitsMap
      };
    }

    static CourseEntity fromDocument(Map<String, dynamic> document){
      Map<String,Unit>unitsMap ={};
      for(var unit in document['units']){
                

        unitsMap.putIfAbsent(unit['id'].toString(), ()=>Unit.fromEntity(UnitEntity.fromDocument(unit)));
      };
      return CourseEntity(id: document['id'], accessId: document['accessId'], units: unitsMap, title:document['title']);
    }
}