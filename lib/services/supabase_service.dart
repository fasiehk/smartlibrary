import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

  // Fetch total users
  static Future<int?> getTotalUsers() async {
    final response = await client.from('users_table').select();
    return response.length;
  }

  // Fetch all users
  static Future<List<Map<String, dynamic>>?> getUsers() async {
    final response = await client.from('users_table').select();
    return response;
  }

  // Delete a user
  static Future<void> deleteUser(String userId) async {
    await client.from('users_table').delete().match({'id': userId});
  }
  // ✅ Fetch all books
  static Future<List<Map<String, dynamic>>?> getBooks() async {
    final response = await client.from('Books').select();
    return response; // No need for `.execute()`
  }

  // ✅ Add a new book
  static Future<void> addBook(String title, String author) async {

    await client.from('Books').insert({'title': title, 'author': author});
  }

  // ✅ Delete a book by ID
  static Future<void> deleteBook(String bookId) async {
    await client.from('Books').delete().match({'id': bookId});

  }


  // ✅ Fetch book count
  static Future<int> getBookCount() async {
    final response = await client.from('Books').select();
    return response.length; // Get the length of the returned list
  }
  static Future<int> getPendingRequestsCount() async {
    final response = await client
        .from('requests')
        .select()
        .eq('status', 'pending'); // Fetch only rows where status = 'pending'
    return response.length;
  }


  static Future<void> updateBook(String bookId, String title, String author) async {
    await client.from('books').update({'title': title, 'author': author}).eq('id', bookId);
  }



  }





