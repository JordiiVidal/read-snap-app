import 'dart:convert';

import 'package:read_snap/features/category/domain/domain.dart';

class CategoryMapper {
  static const String table = 'categories';

  static const String id = 'id';
  static const String name = 'name';
  static const String selectedByUser = 'selected_by_user';
  static const String iconEmoji = 'icon_emoji';
  static const String aliases = 'aliases';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  static Map<String, dynamic> toMap(CategoryEntity entity) {
    return {
      id: entity.id,
      name: entity.name,
      selectedByUser: entity.selectedByUser ? 1 : 0,
      iconEmoji: entity.iconEmoji,
      aliases: jsonEncode(entity.aliases),
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    };
  }

  static CategoryEntity fromMap(Map<String, dynamic> map) {
    List<String> parsedAliases = [];
    if (map[aliases] != null && map[aliases] != '') {
      try {
        final decoded = jsonDecode(map[aliases]);
        parsedAliases = List<String>.from(decoded);
      } catch (e) {
        parsedAliases = [];
      }
    }
    return CategoryEntity(
      id: map[id],
      name: map[name],
      selectedByUser: map[selectedByUser] == 1,
      iconEmoji: map[iconEmoji],
      aliases: parsedAliases,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt]),
    );
  }
}
