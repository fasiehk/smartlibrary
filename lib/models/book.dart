class Book {
  final String id; // Ensure this exists
  final String title;
  final String author;
  final String coverUrl;

  Book({
    required this.id, // Ensure 'id' is required
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '', // Ensure 'id' is assigned from JSON
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
    );
  }
}
