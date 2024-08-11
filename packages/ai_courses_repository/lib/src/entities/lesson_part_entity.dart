import 'dart:developer';

class LessonPartEntity{
  int id;
  String accessId;
  String content;

  LessonPartEntity({required this.id, required this.accessId, required this.content});

    static final empty = LessonPartEntity(id: 0 , accessId: "", content: '');

    Map<String, Object?> toDocument(){
      return {
        'id': id,
        'accessId': accessId,
        'content': content
      };
    }

    static LessonPartEntity fromDocument(Map<String, dynamic> document){
               

      return LessonPartEntity(id: document['id'], accessId: document['accessId'], content: document['content']);
    }
  
}