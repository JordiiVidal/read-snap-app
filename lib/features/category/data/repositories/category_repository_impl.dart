import 'package:read_snap/features/category/data/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:read_snap/features/category/domain/domain.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Database _db;

  CategoryRepositoryImpl(this._db);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      CategoryMapper.table,
      orderBy: '${CategoryMapper.name} ASC',
    );
    return maps.map(CategoryMapper.fromMap).toList();
  }

  @override
  Future<CategoryEntity?> getCategoryByName(String name) async {
    final category = await _db.query(
      CategoryMapper.table,
      where: '${CategoryMapper.name} = ?',
      limit: 1,
      whereArgs: [name],
    );

    if (category.isEmpty) {
      return null;
    }

    return CategoryMapper.fromMap(category.first);
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    await _db.insert(
      CategoryMapper.table,
      CategoryMapper.toMap(category),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _db.delete(
      CategoryMapper.table,
      where: '${CategoryMapper.id} = ?',
      whereArgs: [id],
    );
  }
}
