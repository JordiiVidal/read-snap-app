import 'package:read_snap/features/language/domain/domain.dart';

class LanguageMapper {
  static const String table = 'languages';

  static const String id = 'id';
  static const String code = 'code';
  static const String name = 'name';
  static const String nativeName = 'native_name';
  static const String flag = 'flag';
  static const String selectedByUser = 'selected_by_user';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  static Map<String, dynamic> toMap(LanguageEntity entity) {
    return {
      id: entity.id,
      code: entity.code,
      name: entity.name,
      nativeName: entity.nativeName,
      flag: entity.flag,
      selectedByUser: entity.selectedByUser ? 1 : 0,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    };
  }

  static LanguageEntity fromMap(Map<String, dynamic> map) {
    return LanguageEntity(
      id: map[id],
      code: map[code],
      name: map[name],
      nativeName: map[nativeName],
      flag: map[flag],
      selectedByUser: map[selectedByUser] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt]),
    );
  }
}
