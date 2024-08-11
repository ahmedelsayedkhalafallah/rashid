import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:ai_courses_repository/src/entities/entities.dart';

class Course{
  int id;
  String accessId;
  String title;
  Map<String,Unit> units;


  Course({required this.id, required this.accessId, required this.units, required this.title});

  static final empty = Course(id: 0 , accessId: "", units: {}, title:'');

  CourseEntity toEntity(){
    return CourseEntity(id: id, accessId: accessId, units:units, title:title);
  }

  static Course fromEntity(CourseEntity courseEntity){
    return Course(id: courseEntity.id, accessId: courseEntity.accessId,units:  courseEntity.units, title:courseEntity.title);
  }
}