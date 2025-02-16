import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart';

class ManageBooksScreen extends StatefulWidget {
  @override
  _ManageBooksScreenState createState() => _ManageBooksScreenState();
}

class _ManageBooksScreenState extends State<ManageBooksScreen> {
  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final fetchedBooks = await SupabaseService.getBooks();
    setState(() {
      books = fetchedBooks!;
      isLoading = false;
    });
  }

  void _showBookDialog({Map<String, dynamic>? book}) {
    TextEditingController titleController =
    TextEditingController(text: book?['title'] ?? '');
    TextEditingController authorController =
    TextEditingController(text: book?['author'] ?? '');
    String? bookId = book?['id'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(bookId == null ? "Add Book" : "Edit Book"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: authorController, decoration: InputDecoration(labelText: "Author")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty && authorController.text.isNotEmpty) {
                if (bookId == null) {
                  await SupabaseService.addBook(titleController.text, authorController.text);
                } else {
                  await SupabaseService.updateBook(bookId, titleController.text, authorController.text);
                }
                fetchBooks();
                Navigator.pop(context);
              }
            },
            child: Text(bookId == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  void _deleteBook(String bookId) async {
    await SupabaseService.deleteBook(bookId);
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Books")),
      body: Row(
        children: [
          AdminSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showBookDialog(),
                    icon: Icon(Icons.add),
                    label: Text("Add Book"),
                  ),
                  SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        var book = books[index];
                        return ListTile(
                          leading: Icon(Icons.book, color: Colors.blue),
                          title: Text(book["title"] ?? "No Title"),
                          subtitle: Text("Author: ${book["author"] ?? "Unknown"}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _showBookDialog(book: book),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBook(book['id']),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
