import 'package:read_snap/features/category/domain/domain.dart';
import 'package:uuid/uuid.dart';

class CategorySeed {
  static const _uuid = Uuid();

  static final List<CategoryEntity> defaultCategories = [
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Fiction',
      selectedByUser: true,
      iconEmoji: '📖',
      aliases: [
        'Fiction',
        'Literary Fiction',
        'General Fiction',
        'Contemporary Fiction',
        'Juvenile Fiction',
        'Young Adult Fiction',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Non-Fiction',
      selectedByUser: true,
      iconEmoji: '📚',
      aliases: ['Non-fiction', 'Nonfiction', 'General Nonfiction'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Mystery',
      selectedByUser: true,
      iconEmoji: '🔍',
      aliases: [
        'Mystery',
        'Detective',
        'Thriller',
        'Crime Fiction',
        'Mystery & Thrillers',
        'Juvenile Fiction / Mysteries & Detective Stories',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Romance',
      selectedByUser: true,
      iconEmoji: '💕',
      aliases: [
        'Romance',
        'Love Stories',
        'Romantic Fiction',
        'Juvenile Fiction / Love & Romance',
        'Young Adult Fiction / Romance',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Science Fiction',
      selectedByUser: true,
      iconEmoji: '🚀',
      aliases: [
        'Science Fiction',
        'Sci-Fi',
        'SF',
        'Science Fiction & Fantasy',
        'Juvenile Fiction / Science Fiction',
        'Young Adult Fiction / Science Fiction',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Fantasy',
      selectedByUser: true,
      iconEmoji: '🐉',
      aliases: [
        'Fantasy',
        'Fantasy Fiction',
        'Science Fiction & Fantasy',
        'Juvenile Fiction / Fantasy & Magic',
        'Young Adult Fiction / Fantasy',
        'Young Adult Fiction / Fantasy / Epic',
        'Mythology',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Biography',
      selectedByUser: true,
      iconEmoji: '👤',
      aliases: [
        'Biography',
        'Autobiography',
        'Biography & Autobiography',
        'Memoirs',
        'Life Stories',
        'Juvenile Nonfiction / Biography & Autobiography',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'History',
      selectedByUser: true,
      iconEmoji: '🏛️',
      aliases: [
        'History',
        'Historical',
        'World History',
        'Military History',
        'Juvenile Nonfiction / History',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Self-Help',
      selectedByUser: true,
      iconEmoji: '🌟',
      aliases: [
        'Self-Help',
        'Self Help',
        'Personal Development',
        'Self-Improvement',
        'Motivation',
        'Inspirational',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryEntity(
      id: _uuid.v4(),
      name: 'Business',
      selectedByUser: true,
      iconEmoji: '💼',
      aliases: [
        'Business',
        'Business & Economics',
        'Economics',
        'Management',
        'Entrepreneurship',
        'Marketing',
        'Finance',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static Future<void> seedCategories(CategoryRepository repository) async {
    final existingCategories = await repository.getCategories();

    if (existingCategories.isEmpty) {
      for (final category in defaultCategories) {
        await repository.addCategory(category);
      }
    }
  }
}
