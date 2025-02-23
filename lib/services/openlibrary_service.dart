import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class OpenLibraryService {
  static Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse('https://openlibrary.org/search.json?title=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> docs = data['docs'];
      return docs.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch books');
    }
  }
}