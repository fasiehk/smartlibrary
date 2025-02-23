import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart';
import 'auth_screen.dart'; // Import your login screen

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalUsers = 0;
  int totalBooks = 0;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    int? userCount = await SupabaseService.getTotalUsers();
    int? bookCount = await SupabaseService.getTotalBooks(); // Fetch books dynamically

    setState(() {
      if (userCount != null) totalUsers = userCount;
      if (bookCount != null) totalBooks = bookCount;
    });
  }

  Future<void> _logout() async {
    await SupabaseService.signOut(); // Call the signOut function
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()), // Navigate to login
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;
        return Scaffold(
          appBar: AppBar(
            title: Text("Admin Dashboard"),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _logout, // Logout button
                tooltip: "Logout",
              ),
            ],
          ),
          body: Row(
            children: [
              if (isLargeScreen) AdminSidebar(), // ✅ Sidebar for large screens
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: isLargeScreen ? 3 : 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      _buildDashboardCard("Total Users", "$totalUsers", Icons.people),
                      _buildDashboardCard("Total Books", "$totalBooks", Icons.book),
                      _buildDashboardCard("Most Popular Genre", "Fiction", Icons.category),
                      _buildDashboardCard("Pending Requests", "15", Icons.pending),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: isLargeScreen ? null : Drawer(child: AdminSidebar()), // ✅ Drawer for small screens
        );
      },
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
