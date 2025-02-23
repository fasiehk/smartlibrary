// import 'package:flutter/material.dart';
// import '../services/supabase_service.dart';
// import '../models/book.dart';
//
// class ManageBooksScreen extends StatefulWidget {
//   @override
//   _ManageBooksScreenState createState() => _ManageBooksScreenState();
// }
//
// class _ManageBooksScreenState extends State<ManageBooksScreen> {
//   List<Book> books = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBooks();
//   }
//
//   Future<void> fetchBooks() async {
//     books = await SupabaseService.getBooks();
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Manage Books")),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: books.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Image.network(books[index].coverUrl, width: 50),
//             title: Text(books[index].title),
//             subtitle: Text(books[index].author),
//             trailing: IconButton(
//               icon: Icon(Icons.delete, color: Colors.red),
//               onPressed: () async {
//                 await SupabaseService.deleteBook(index);
//                 fetchBooks();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
