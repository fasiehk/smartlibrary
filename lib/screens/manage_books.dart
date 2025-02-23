import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart';
import '../models/book.dart';

class ManageBooksScreen extends StatefulWidget {
  @override
  _ManageBooksScreenState createState() => _ManageBooksScreenState();
}

class _ManageBooksScreenState extends State<ManageBooksScreen> {
  List<Book> searchResults = [];
  List<Book> storedBooks = [];
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStoredBooks();
  }

  // ✅ Fetch stored books from Supabase
  Future<void> fetchStoredBooks() async {
    final books = await SupabaseService.getStoredBooks();
    setState(() {
      storedBooks = books;
    });
  }

  // ✅ Fetch books from OpenLibrary API
  Future<void> searchBooks() async {
    setState(() {
      isLoading = true;
    });

    try {
      final books = await SupabaseService.fetchBooksFromAPI(searchController.text);
      setState(() {
        searchResults = books;
      });
    } catch (e) {
      print('Error fetching books: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  // ✅ Add book to Supabase
  Future<void> addBookToSupabase(Book book) async {
    await SupabaseService.addBookToSupabase(book);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${book.title} added!')));
    fetchStoredBooks(); // Refresh stored books list
  }

  // ✅ Delete book from Supabase
  Future<void> deleteBookFromSupabase(String bookId) async {
    await SupabaseService.deleteBook(bookId);
    fetchStoredBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Books")),
      drawer: AdminSidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search books by title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text("Search"),
                  onPressed: searchBooks,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Search Results Section
            Text("Search Results", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : searchResults.isNotEmpty
                  ? ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var book = searchResults[index];
                  return Card(
                    child: ListTile(
                      leading: book.coverUrl.isNotEmpty
                          ? Image.network(book.coverUrl, width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.book),
                      title: Text(book.title),
                      subtitle: Text("Author: ${book.author}"),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () => addBookToSupabase(book),
                      ),
                    ),
                  );
                },
              )
                  : Center(child: Text("No results found")),
            ),

            Divider(),

            // Stored Books Section
            Text("Stored Books", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: storedBooks.isEmpty
                  ? Center(child: Text("No stored books"))
                  : ListView.builder(
                itemCount: storedBooks.length,
                itemBuilder: (context, index) {
                  var book = storedBooks[index];
                  return Card(
                    child: ListTile(
                      leading: book.coverUrl.isNotEmpty
                          ? Image.network(book.coverUrl, width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.book),
                      title: Text(book.title),
                      subtitle: Text("Author: ${book.author}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await SupabaseService.deleteBook(book.id); // Ensure book.id is correct
                          fetchStoredBooks(); // Refresh the list after deletion
                        },
                      ),

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
