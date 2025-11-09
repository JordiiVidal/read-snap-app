import 'package:read_snap/features/language/data/data.dart';
import 'package:read_snap/features/language/domain/domain.dart';
import 'package:sqflite/sqflite.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final Database _db;

  LanguageRepositoryImpl(this._db);

  @override
  Future<List<LanguageEntity>> getLanguages() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      LanguageMapper.table,
      orderBy: '${LanguageMapper.name} ASC',
    );
    return maps.map(LanguageMapper.fromMap).toList();
  }

  @override
  Future<void> addLanguage(LanguageEntity language) async {
    await _db.insert(
      LanguageMapper.table,
      LanguageMapper.toMap(language),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
