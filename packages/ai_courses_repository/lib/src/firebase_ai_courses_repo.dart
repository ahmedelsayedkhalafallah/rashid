import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseAiCoursesRepo extends AiCoursesRepo {
  @override
  Future<Curriculum> getMultiLevelCurriculum(
      String learningTopic, String learningPurpose) {
    // TODO: implement getMultiLevelCurriculum
    throw UnimplementedError();
  }

  @override
  Future<Curriculum> getSingleLevelCurriculum(
      String learningTopic, String learningPurpose, String learningType) async {
    try {
      String topicAndPurposeValidation = "";
      final gemini = Gemini.instance;
      if (await validateTopicAndPurpose(learningTopic, learningPurpose)) {
        Curriculum singleCurriculum = await generateSyllable(
            learningTopic, learningPurpose, learningType);

        return singleCurriculum;
      } else {
        return Curriculum.empty;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Curriculum> generateSyllable(
      String learningTopic, String learningPurpose, String learningType) async {
    try {
      String syllableJSON = "";
      String purposePhrase = "learn how to make $learningPurpose";
      switch (learningType) {
        case 'do':
          purposePhrase = "learn how to make $learningPurpose";
          break;
        case 'job':
          purposePhrase = "be $learningPurpose";
          break;
        case 'research':
          purposePhrase = "research $learningPurpose";
          break;
        default:
          purposePhrase = "learn how to make $learningPurpose";
          break;
      }
      final gemini = Gemini.instance;
      await gemini
          .text(
              "Answer only in DataSnapshot format without any additional notes. You are a skilled expert. Create a complete detailed systematic syllable aimed at teaching $learningTopic to someone wants to $purposePhrase. Perform a normal performance in the body of the DataSnapshot file and in the following order: Course - Unit - Lesson, under the key syllableList list the courses under the field called courses where every course has the following fields: title: string, id: incremental integer starts from 1, accessId: random string, units: list of units and every unit has the following fields: title: string, id: incremental integer, accessId: random string converted to string, lessons: list of lessons and every lesson has the following fields: title: string, id: incremental integer, accessId: random string, lessonParts: empty map the syllable contains only one level, list in details the complete syllable without any cuts, the whole courses, units and lessons of every level do not make abstraction produce the syllable within gemini answer length limit to prevent cuts do not use comments or quotes within the snapshot make it a valid json, make all your answer in a single line, use meaningful titles")
          .then((value) => syllableJSON = value?.output ?? "")
          .catchError((e) => print(e));

      Map validatedSyllableJSON = await validateSyllableJSON(syllableJSON);

      if (validatedSyllableJSON.isNotEmpty) {
        Curriculum generatedCurriculum = Curriculum.empty;
        Map<String, Level> levels = {};
        levels.putIfAbsent(
            '1', () => Level(id: 1, accessId: "", courses: {}, title: ''));

        List<dynamic> courses = [];
        for (var course in validatedSyllableJSON['syllableList']['courses']) {
          int courseId = course['id']; // Assuming 'id' is an integer property
          levels['1']!.courses.putIfAbsent(courseId.toString(),
              () => Course.fromEntity(CourseEntity.fromDocument(course)));
        }

        for(var courseMap in courses) {
          levels['1']!.courses.putIfAbsent(courseMap['id'].toString(),
              () => Course.fromEntity(CourseEntity.fromDocument(courseMap)));
        };

        generatedCurriculum = generatedCurriculum.copyWith(levels: levels);
        return generatedCurriculum;
      } else {
        log("it is empty");
        return Curriculum.empty;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> validateSyllableJSON(String syllableJSON) async {
    try {
      log("validating json");

      Map<String, dynamic> decodedSyllable = {};
      var decodeSucceeded = false;
      try {
        var decodedJSON = jsonDecode(syllableJSON) as Map<String, dynamic>;
        decodeSucceeded = true;
      } on FormatException catch (e) {
        decodeSucceeded = false;
      }
      if (!decodeSucceeded) {
        log("in validating");
        String newSyllableJSON = "";
        final gemini = Gemini.instance;
        await gemini
            .text(
                "Answer in JSON only without any additional notes ,you are an expert developer rewrite and repair the following json, make it valid and sent it back in single line: $syllableJSON")
            .then((value) => newSyllableJSON = value?.output ?? syllableJSON)
            .catchError((e) => print(e));

        try {
          var decodedJSON = jsonDecode(syllableJSON) as Map<String, dynamic>;
          decodeSucceeded = true;
        } on FormatException catch (e) {
          decodeSucceeded = false;
        }
        if (decodeSucceeded) {
          decodedSyllable = jsonDecode(newSyllableJSON) as Map<String, dynamic>;
        }
      } else {
        decodedSyllable = jsonDecode(syllableJSON) as Map<String, dynamic>;
      }

      return decodedSyllable;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> validateTopicAndPurpose(
      String learningTopic, String learningPurpose) async {
    try {
      String topicAndPurposeValidation = "";
      final gemini = Gemini.instance;
      await gemini
          .text(
              "Answer only with yes or no, is teaching $learningTopic for making $learningPurpose a valid topic?")
          .then((value) => topicAndPurposeValidation = value?.output ?? "no")
          .catchError((e) => print(e));
      if (topicAndPurposeValidation == 'yes' ||
          topicAndPurposeValidation == 'Yes') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Curriculum> makeSyllableContent(Curriculum curriculum) async {
    Map<String, Level> levels = {};
    Map<String, Course> courses = {};
    
    
    for (var course in curriculum.levels['1']!.courses.values) {
      Map<String, Unit> units = {};
      for (var unit in course.units.values) {
        Map<String, Lesson> lessons = {};
        for (var lesson in unit.lessons.values) {
          log("done");
          lessons.putIfAbsent(
              lesson.id.toString(),
              () => Lesson(
                  id: lesson.id,
                  accessId: Uuid().v4(),
                  lessonParts: {} /*lessonParts*/,
                  title: lesson.title));
        }
        ;
        units.putIfAbsent(
            unit.id.toString(),
            () => Unit(
                id: unit.id,
                accessId: Uuid().v4(),
                lessons: lessons,
                title: unit.title));
      }
      ;
      courses.putIfAbsent(
          course.id.toString(),
          () => Course(
              id: course.id,
              accessId: Uuid().v4(),
              units: units,
              title: course.title));
    }
    levels['1'] =
        Level(id: 1, accessId: Uuid().v1(), courses: courses, title: "Level 1");
    curriculum = curriculum.copyWith(levels: levels, accessId: Uuid().v1());
    log("hello");

    return curriculum;
  }

  @override
  String getLessonPrompt(Curriculum curriculum, String courseTitle,
      String unitTitle, String lessonTitle) {
    String coursesListing = "";
    curriculum.levels['1']!.courses.forEach((id, course) {
      String unitsListing = "";
      course.units.forEach((id, unit) {
        unitsListing = "$unitsListing ${unit.title} unit contains :,";
        String lessonsListing = "";
        unit.lessons.forEach((id, lesson) {
          lessonsListing = "$lessonsListing ${lesson.title} lesson,";
        });
      });
      coursesListing =
          "$coursesListing ${course.title} course contains : $coursesListing,";
    });
    String prompt =
        "Answer only in DataSnapshot format without any additional notes, Make your answer in a single line. You are best teaching expert and you have been asked to explain a curriculum about ${curriculum.curriculumTopic} to ${curriculum.curriculumType == 'do' ? 'to make ' : curriculum.curriculumType == 'job' ? 'to be ' : 'to research '}${curriculum.curriculumPurpose} and you have been asked to only explaing the lesson $lessonTitle within the this curriculum in a great way helps to good understaning then put it in the form of lessonParts and under the field lessonParts return the explaination in form of list of lessonParts where every lessonPart consists of: id: increamental integer starts from 1, accessId: random string, content: string that contains part of lesson explaination, , list in details the complete lesson without any cuts, do not make abstraction produce the lesson parts within gemini answer length limit to prevent cuts do not use comments or quotes within the snapshot make it a valid json, make all your answer in a single line, use meaningful titles";
    return prompt;
  }

  @override
  Future<Map<String, LessonPart>> getLessonContent(String prompt) async {
    final gemini = Gemini.instance;
    String partsJSON = "";
    Map<String, LessonPart> lessonParts = {};
    await gemini
        .text(prompt)
        .then((value) => partsJSON = value?.output ?? "")
        .catchError((e) => print(e));

    Map validatedSyllableJSON = await validateSyllableJSON(partsJSON);

    if (validatedSyllableJSON.isNotEmpty) {
      for (var lessonPart in validatedSyllableJSON["lessonParts"]) {
        int lessonPartId =
            lessonPart['id']; // Assuming 'id' is an integer property
        lessonParts.putIfAbsent(
            lessonPartId.toString(),
            () => LessonPart.fromEntity(
                LessonPartEntity.fromDocument(lessonPart)));
      }
    }
    return lessonParts;
  }

  @override
  Future saveCurriculum(Curriculum curriculum, MyUser? myUser) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      Map<String, dynamic> userSyllables = myUser!.mySyllables;
      userSyllables[curriculum.accessId] = curriculum.accessId;

      myUser = myUser.copyWith(mySyllables: userSyllables);
      await firebaseFirestore
          .collection("users")
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
      Map<String, String> levels = {};
      for (var level in curriculum.levels.values) {
        levels.putIfAbsent(level.accessId, () => level.accessId);
      }
      await firebaseFirestore
          .collection("curriculums")
          .doc(curriculum.accessId)
          .set({
        'accessId': curriculum.accessId,
        'curriculumTopic': curriculum.curriculumTopic,
        'curriculumPurpose': curriculum.curriculumPurpose,
        'curriculumType': curriculum.curriculumType,
        'levels': levels
      });
      await setLevels(curriculum);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future setLevels(Curriculum curriculum) async{
    for (var level in curriculum.levels.values) {
        Map<String, String> courses = {};
        for (var course in level.courses.values) {
          courses.putIfAbsent(course.accessId, () => course.accessId);
        }
        await FirebaseFirestore.instance.collection("levels").doc(level.accessId).set({
          'id': level.id,
          'title': level.title,
          'accessId': level.accessId,
          'courses': courses,
        });
        await setCourses(level);
      }
  }

  Future setCourses(Level level)async{
    for (var course in level.courses.values) {
          Map<String, String> units = {};
          for (var unit in course.units.values) {
            units.putIfAbsent(unit.accessId, () => unit.accessId);
          }
          await FirebaseFirestore.instance
              .collection("courses")
              .doc(course.accessId)
              .set({
            'id': course.id,
            'title': course.title,
            'accessId': course.accessId,
            'units': units,
          });
          await setUnits(course);
        }
  }

  Future setUnits(Course course)async{
    for (var unit in course.units.values) {
            Map<String, String> lessons = {};
            for (var lesson in unit.lessons.values) {
              lessons.putIfAbsent(lesson.accessId, () => lesson.accessId);
            }
            await FirebaseFirestore.instance.collection("units").doc(unit.accessId).set({
              'id': unit.id,
              'title': unit.title,
              'accessId': unit.accessId,
              'lessons': lessons,
            });
            await setLessons(unit);
          }
  }

  Future setLessons(Unit unit)async{
    for (var lesson in unit.lessons.values) {
              Map<String, String> lessonParts = {};
              for (var lessonPart in lesson.lessonParts.values) {
                lessonParts.putIfAbsent(
                    lessonPart.accessId, () => lessonPart.accessId);
              }
              await FirebaseFirestore.instance
                  .collection("lessons")
                  .doc(lesson.accessId)
                  .set({
                'id': lesson.id,
                'title': lesson.title,
                'accessId': lesson.accessId,
                'lessonParts': lessonParts,
              });
              await setLessonParts(lesson);
            }
  }

  Future setLessonParts(Lesson lesson)async{
    for (var lessonPart in lesson.lessonParts.values) {
                await FirebaseFirestore.instance
                    .collection("lessonParts")
                    .doc(lessonPart.accessId)
                    .set({
                  'id': lessonPart.id,
                  'accessId': lessonPart.accessId,
                  'content': lessonPart.content,
                });
              }
  }

  @override
  Future<Map<String, LessonPart>> generateLessonContent(Curriculum curriculum,
      String courseTitle, String unitTitle, String lessonTitle) async {
    String prompt =
        getLessonPrompt(curriculum, courseTitle, unitTitle, lessonTitle);
    Map<String, LessonPart> lessonParts = {};
    while (lessonParts.isEmpty) {
      try {
        lessonParts = await getLessonContent(prompt);
      } catch (e) {}
    }
    return lessonParts;
  }

  @override
  Future<Map<String, Curriculum>> getUserCurriculums(MyUser? myUser) async {
    Map<String, Curriculum> curriculums = {};
    try {
      Map<String, dynamic> curriculumList = myUser!.mySyllables;
      for (var curriculum in curriculumList.values) {
        String curriculumAccessId = curriculum.toString();
        DocumentSnapshot curriculumSnapshot = await FirebaseFirestore.instance
            .collection("curriculums")
            .doc(curriculumAccessId)
            .get();
        if (curriculumSnapshot.exists) {
          Map<String, dynamic> curriculumMap =
              curriculumSnapshot.data() as Map<String, dynamic>;

          Map<String, Level> levels = {};
          levels = await getLevels(curriculumMap);
          curriculums.putIfAbsent(
              curriculumSnapshot['accessId'],
              () => Curriculum(
                  accessId: curriculumSnapshot['accessId'],
                  levels: levels,
                  curriculumPurpose: curriculumSnapshot['curriculumPurpose'],
                  curriculumTopic: curriculumSnapshot['curriculumTopic'],
                  curriculumType: curriculumSnapshot['curriculumType']));
        }
      }
    } catch (e) {
      log("curriculum");
    }

    return curriculums;
  }

  Future<Curriculum> getCurriculum(String curriculumAccessId)async{
     
        DocumentSnapshot curriculumSnapshot = await FirebaseFirestore.instance
            .collection("curriculums")
            .doc(curriculumAccessId)
            .get();
        if (curriculumSnapshot.exists) {
          Map<String, dynamic> curriculumMap =
              curriculumSnapshot.data() as Map<String, dynamic>;

          Map<String, Level> levels = {};
          levels = await getLevels(curriculumMap);
          return Curriculum(
                  accessId: curriculumSnapshot['accessId'],
                  levels: levels,
                  curriculumPurpose: curriculumSnapshot['curriculumPurpose'],
                  curriculumTopic: curriculumSnapshot['curriculumTopic'],
                  curriculumType: curriculumSnapshot['curriculumType']);
        }else{
          return Curriculum.empty;
        }
  }

  Future<Map<String, Level>> getLevels(
      Map<String, dynamic> curriculumMap) async {
    Map<String, Level> levels = {};
    try {
      Map<String, dynamic> levelsList = curriculumMap['levels'];
      for (var level in levelsList.values) {
        String levelAccessId = level.toString();
        DocumentSnapshot levelSnapshot = await FirebaseFirestore.instance
            .collection("levels")
            .doc(levelAccessId)
            .get();
        if (levelSnapshot.exists) {
          Map<String, dynamic> levelMap =
              levelSnapshot.data() as Map<String, dynamic>;

          Map<String, Course> courses = {};
          courses = await getCourses(levelMap);

          levels.putIfAbsent(
              levelSnapshot['id'].toString(),
              () => Level(
                  accessId: levelSnapshot['accessId'],
                  courses: courses,
                  id: levelSnapshot['id'],
                  title: levelSnapshot['title']));
        }
      }
    } catch (e) {
      log("levels");
    }
    return levels;
  }

  Future<Map<String, Course>> getCourses(Map<String, dynamic> levelMap) async {
    Map<String, Course> courses = {};

    try {
      Map<String, dynamic> coursesList = levelMap['courses'];
      for (var course in coursesList.values) {
        String courseAccessId = course.toString();
        DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
            .collection("courses")
            .doc(courseAccessId)
            .get();

        if (courseSnapshot.exists) {
          Map<String, dynamic> courseMap =
              courseSnapshot.data() as Map<String, dynamic>;
          Map<String, Unit> units = {};
          units = await getUnits(courseMap);

          courses.putIfAbsent(
              courseSnapshot['id'].toString(),
              () => Course(
                  accessId: courseSnapshot['accessId'],
                  units: units,
                  id: courseSnapshot['id'],
                  title: courseSnapshot['title']));
        }
      }
    } catch (e) {
      log("courses");
    }
    var sortedCourses = Map.fromEntries(
    courses.entries.toList()..sort((e1, e2) => e1.value.id.compareTo(e2.value.id)));
    return sortedCourses;
  }

  Future<Map<String, Unit>> getUnits(Map<String, dynamic> courseMap) async {
    Map<String, Unit> units = {};
    try {
      Map<String, dynamic> unitsList = courseMap['units'];
      for (var unit in unitsList.values) {
        String unitAccessId = unit.toString();
        DocumentSnapshot unitSnapshot = await FirebaseFirestore.instance
            .collection("units")
            .doc(unitAccessId)
            .get();
        if (unitSnapshot.exists) {
          Map<String, dynamic> unitMap =
              unitSnapshot.data() as Map<String, dynamic>;

          Map<String, Lesson> lessons = {};
          lessons = await getLessons(unitMap);
          units.putIfAbsent(
              unitSnapshot['id'].toString(),
              () => Unit(
                  accessId: unitSnapshot['accessId'],
                  lessons: lessons,
                  id: unitSnapshot['id'],
                  title: unitSnapshot['title']));
        }
      }
    } catch (e) {
      log('units');
    }
    var sortedUnits = Map.fromEntries(
    units.entries.toList()..sort((e1, e2) => e1.value.id.compareTo(e2.value.id)));
    return sortedUnits;
  }

  Future<Map<String, Lesson>> getLessons(Map<String, dynamic> unitMap) async {
    Map<String, Lesson> lessons = {};
    try {
      Map<String, dynamic> lessonsList = unitMap['lessons'];
      for (var lesson in lessonsList.values) {
        String lessonAccessId = lesson.toString();
        DocumentSnapshot lessonSnapshot = await FirebaseFirestore.instance
            .collection("lessons")
            .doc(lessonAccessId)
            .get();
        if (lessonSnapshot.exists) {
          Map<String, dynamic> lessonMap =
              lessonSnapshot.data() as Map<String, dynamic>;
          Map<String, LessonPart> lessonParts = {};
          lessonParts = await getLessonParts(lessonMap);
          lessons.putIfAbsent(
              lessonSnapshot['id'].toString(),
              () => Lesson(
                  accessId: lessonSnapshot['accessId'],
                  lessonParts: lessonParts,
                  id: lessonSnapshot['id'],
                  title: lessonSnapshot['title']));
        }
      }
    } catch (e) {
      log("lessons");
    }
    var sortedLessons = Map.fromEntries(
    lessons.entries.toList()..sort((e1, e2) => e1.value.id.compareTo(e2.value.id)));
    return sortedLessons;
  }

  Future<Map<String, LessonPart>> getLessonParts(
      Map<String, dynamic> lessonMap) async {
    Map<String, LessonPart> lessonParts = {};
    try {
      
      Map<String, dynamic> lessonPartsList = lessonMap['lessonParts'] ?? {};
      
      for (var lessonPart in lessonPartsList.values) {
        
        String lessonPartAccessId = lessonPart.toString();
        
        DocumentSnapshot lessonPartSnapshot = await FirebaseFirestore.instance
            .collection("lessonParts")
            .doc(lessonPartAccessId)
            .get();
        if (lessonPartSnapshot.exists) {
          
          Map<String, dynamic> lessonPartMap =
              lessonPartSnapshot.data() as Map<String, dynamic>;
          
          lessonParts.putIfAbsent(
              lessonPartSnapshot['id'].toString(),
              () => LessonPart.fromEntity(
                  LessonPartEntity.fromDocument(lessonPartMap)));
          
        }
      }
    } catch (e) {
      log(e.toString());
      
    }
    var sortedLessonParts = Map.fromEntries(
    lessonParts.entries.toList()..sort((e1, e2) => e1.value.id.compareTo(e2.value.id)));
    return sortedLessonParts;
  }

  @override
  Future deleteCurriculum(Curriculum curriculum, MyUser myUser)async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      Map<String, dynamic> userSyllables = myUser.mySyllables;
      userSyllables.remove(curriculum.accessId);

      myUser = myUser.copyWith(mySyllables: userSyllables);
      await firebaseFirestore
          .collection("users")
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
      await firebaseFirestore
          .collection("curriculums")
          .doc(curriculum.accessId)
          .delete();
      await deleteLevels(curriculum);
  }

  Future deleteLevels(Curriculum curriculum)async{
    for (var level in curriculum.levels.values) {
        Map<String, String> courses = {};
        for (var course in level.courses.values) {
          courses.putIfAbsent(course.accessId, () => course.accessId);
        }
        await FirebaseFirestore.instance.collection("levels").doc(level.accessId).delete();
        await deleteCourses(level);
      }
  }

  Future deleteCourses(Level level)async{
    for (var course in level.courses.values) {
          Map<String, String> units = {};
          for (var unit in course.units.values) {
            units.putIfAbsent(unit.accessId, () => unit.accessId);
          }
          await FirebaseFirestore.instance
              .collection("courses")
              .doc(course.accessId)
              .delete();
          await deleteUnits(course);
        }
  }

  Future deleteUnits(Course course)async{
    for (var unit in course.units.values) {
            Map<String, String> lessons = {};
            for (var lesson in unit.lessons.values) {
              lessons.putIfAbsent(lesson.accessId, () => lesson.accessId);
            }
            await FirebaseFirestore.instance.collection("units").doc(unit.accessId).delete();
            await deleteLessons(unit);
          }
  }
  Future deleteLessons(Unit unit)async{
    for (var lesson in unit.lessons.values) {
              Map<String, String> lessonParts = {};
              for (var lessonPart in lesson.lessonParts.values) {
                lessonParts.putIfAbsent(
                    lessonPart.accessId, () => lessonPart.accessId);
              }
              await FirebaseFirestore.instance
                  .collection("lessons")
                  .doc(lesson.accessId)
                  .delete();
              await deleteLessonParts(lesson);
            }
  }
  Future deleteLessonParts(Lesson lesson)async{
    for (var lessonPart in lesson.lessonParts.values) {
                await FirebaseFirestore.instance
                    .collection("lessonParts")
                    .doc(lessonPart.accessId)
                    .delete();
              }
  }

  @override
  Future<Curriculum> generateContent(Lesson lesson ,Curriculum curriculum,
      String courseTitle, String unitTitle, String lessonTitle)async{
        
    lesson.lessonParts = await generateLessonContent(curriculum, courseTitle, unitTitle, lessonTitle);
    await setLessons(Unit(id: 1, accessId: '', lessons: {lesson.id.toString():lesson}, title: ''));
    Curriculum updatedCurriculum = await getCurriculum(curriculum.accessId);
    return updatedCurriculum;
  }
  
  @override
  Future<String> getChatResponse(List<Content> chatContent) async{
    try {
      
      String response = "";
      final gemini = Gemini.instance;
    await gemini.chat(chatContent).then((value){
      response = value?.output??"";
    });
    
    return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
