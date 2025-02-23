import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class SupabaseService {
  static final client = Supabase.instance.client;
  static Future<List<Book>> fetchBooksFromAPI(String query) async {
    final url = Uri.parse('https://openlibrary.org/search.json?title=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List books = data['docs'];

      return books.map<Book>((book) {
        return Book(
          title: book['title'] ?? 'Unknown Title',
          author: (book['author_name'] != null) ? book['author_name'][0] : 'Unknown Author',
          coverUrl: book['cover_i'] != null ? 'https://covers.openlibrary.org/b/id/${book['cover_i']}-M.jpg' : '', id: '',
        );
      }).toList();
    } else {
      throw Exception('Failed to load books from OpenLibrary API');
    }
  }

  // ✅ Fetch total users
  static Future<int> getTotalUsers() async {
    final response = await client.from('users_table').select();
    return response.length;
  }

  // ✅ Fetch total books
  static Future<int> getBookCount() async {
    final response = await client.from('books').select();
    return response.length;
  }

  // ✅ Fetch pending requests count
  static Future<int> getPendingRequestsCount() async {
    final response = await client.from('requests').select().eq('status', 'pending');
    return response.length;
  }

  // ✅ Fetch all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await client.from('users_table').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // ✅ Delete a user
  static Future<void> deleteUser(String userId) async {
    await client.from('users_table').delete().eq('id', userId);
  }

  // ✅ Fetch all books
  static Future<List<Book>> getBooks() async {
    final response = await client.from('books').select();
    return response.map<Book>((json) => Book.fromJson(json)).toList();
  }

  // ✅ Add a new book
  static Future<void> addBookToSupabase(Book book) async {
    final response = await Supabase.instance.client.from('books').insert({
      'id': book.id,
      'title': book.title,
      'author': book.author,
      'cover_url': book.coverUrl,
    });

    if (response.error != null) {
      print('Error adding book: ${response.error!.message}');
    } else {
      print('Book added successfully!');
    }
  }


  // ✅ Delete a book by ID
  static Future<void> deleteBook(String bookId) async {
    await Supabase.instance.client
        .from('books')
        .delete()
        .eq('id', bookId);
  }

  static Future<List<Book>> getStoredBooks() async {
    final response = await client.from('books').select();
    return response.map<Book>((json) => Book.fromJson(json)).toList();
  }

  static Future<int?> getTotalBooks() async {
    final response = await client
        .from('books')
        .select('id') // Select only 'id' column
        .count(CountOption.exact); // Get exact count
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }


}

