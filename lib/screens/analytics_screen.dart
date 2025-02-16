import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      drawer: AdminSidebar(),  // Sidebar navigation
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Library Analytics",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Books Borrowed Per Month"),
                    // Add a chart here
                    Placeholder(fallbackHeight: 200),  // Replace with a chart widget later
                  ],
                ),
              ),
            ),
            // Add more cards for different types of data (e.g., active users, popular genres)
          ],
        ),
      ),
    );
  }
}
