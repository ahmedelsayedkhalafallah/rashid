import 'package:ai_courses_repository/src/entities/entities.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class Level{
  int id;
  String title;
  String accessId;
  Map<String,Course> courses;


  Level({required this.id, required this.accessId, required this.courses, required this.title});

  static final empty = Level(id: 0 , accessId: "", courses: {},title: '');

  LevelEntity toEntity(){
    return LevelEntity(id: id, accessId: accessId, courses: courses, title: title);
  }

  static Level fromEntity(LevelEntity levelEntity){
    return Level(id: levelEntity.id, accessId: levelEntity.accessId, courses: levelEntity.courses, title: levelEntity.title);
  }
}