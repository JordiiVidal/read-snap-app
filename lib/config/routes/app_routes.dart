import 'package:flutter/material.dart';
import 'package:read_snap/features/book/presentation/pages/book_create_page.dart';
import 'package:read_snap/features/book/presentation/pages/book_detail_page.dart';
import 'package:read_snap/features/book/presentation/pages/book_list_page.dart';
import 'package:read_snap/features/session/presentation/pages/session_create_page.dart';

class AppRoutes {
  AppRoutes._();

  // ========== Book Routes ==========

  static void toBookList(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BookListPage()),
      (route) => false,
    );
  }

  static void toBookDetail(BuildContext context, String bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailPage(bookId)),
    );
  }

  static void toBookCreate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookCreatePage()),
    );
  }

  // ========== Session Routes ==========

  static void toSessionCreate(BuildContext context, String bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SessionCreatePage(bookId)),
    );
  }

  // ========== Navigation Helpers ==========

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void backWithResult<T>(BuildContext context, T result) {
    Navigator.pop(context, result);
  }
}
