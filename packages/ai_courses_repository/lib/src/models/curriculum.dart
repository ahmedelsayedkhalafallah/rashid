import 'package:ai_courses_repository/src/entities/entities.dart';
import 'package:ai_courses_repository/src/models/models.dart';

class Curriculum {
  final String accessId;
  final Map<String, Level> levels;
  final String? curriculumTopic;
  final String? curriculumPurpose;
  final String? curriculumType;

  const Curriculum({required this.accessId, required this.levels, this.curriculumTopic, this.curriculumPurpose, this.curriculumType});

  static final empty = const Curriculum(accessId: "", levels: {});

  Curriculum copyWith({
    String? accessId,
    Map<String, Level>? levels,
     String? curriculumTopic,
   String? curriculumPurpose,
   String? curriculumType
  }) {
    return Curriculum(
      accessId: accessId ?? this.accessId,
      levels: levels ?? this.levels,
      curriculumTopic: curriculumTopic ?? this.curriculumTopic,
      curriculumPurpose: curriculumPurpose ?? this.curriculumPurpose,
      curriculumType: curriculumType ?? this.curriculumType,
    );
  }

  CurriculumEntity toEntity() {
    return CurriculumEntity(accessId: accessId, levels: levels);
  }

  static Curriculum fromEntity(CurriculumEntity curriculumEntity) {
    return Curriculum(accessId: curriculumEntity.accessId, levels: curriculumEntity.levels);
  }
}