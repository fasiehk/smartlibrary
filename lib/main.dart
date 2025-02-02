import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Admin Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Manage Books"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Manage Users"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("Analytics"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildDashboardCard("Total Books", "1200", Icons.book),
            _buildDashboardCard("Active Users", "500", Icons.people),
            _buildDashboardCard("Most Popular Genre", "Fiction", Icons.category),
            _buildDashboardCard("Pending Requests", "15", Icons.pending),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminDashboard(),
  ));
}
