import 'package:ai_courses_repository/src/entities/entities.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class Unit{
  int id;
  String accessId;
  String title;
  Map<String,Lesson> lessons;

  Unit({required this.id, required this.accessId, required this.lessons, required this.title});

  static final empty = Unit(id: 0 , accessId: "", lessons: {}, title: '');

  UnitEntity toEntity(){
    return UnitEntity(id: id, accessId: accessId, lessons: lessons, title:title);
  }

  static Unit fromEntity(UnitEntity unitEntity){
    return Unit(id: unitEntity.id, accessId: unitEntity.accessId, lessons: unitEntity.lessons, title: unitEntity.title);
  }
}