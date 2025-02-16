import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart';

class ManageBooksScreen extends StatefulWidget {
  @override
  _ManageBooksScreenState createState() => _ManageBooksScreenState();
}

class _ManageBooksScreenState extends State<ManageBooksScreen> {
  List<Map<String, dynamic>> books = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await SupabaseService.getBooks();
    if (response != null) {
      setState(() {
        books = response;
      });
    }
  }

  Future<void> addBook() async {
    if (titleController.text.isNotEmpty && authorController.text.isNotEmpty) {
      await SupabaseService.addBook(titleController.text, authorController.text);
      titleController.clear();
      authorController.clear();
      fetchBooks(); // Refresh book list
    }
  }

  Future<void> deleteBook(String bookId) async {
    await SupabaseService.deleteBook(bookId);
    fetchBooks(); // Refresh book list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Books")),
      drawer: AdminSidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Book Title"),
            ),
            TextField(
              controller: authorController,
              decoration: InputDecoration(labelText: "Author"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addBook,
              child: Text("Add Book"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: books.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index];
                  return ListTile(
                    leading: Icon(Icons.book, color: Colors.blue),
                    title: Text(book["title"] ?? "No Title"),
                    subtitle: Text(book["author"] ?? "No Author"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteBook(book["id"]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
