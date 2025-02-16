import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart'; // Import Supabase service file

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalUsers = 0;
  int totalBooks = 0;
  int pendingRequests = 0;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    // Fetch all data in parallel
    final usersFuture = SupabaseService.getTotalUsers();
    final booksFuture = SupabaseService.getBookCount();
    final requestsFuture = SupabaseService.getPendingRequestsCount();

    final results = await Future.wait([usersFuture, booksFuture, requestsFuture]);

    setState(() {
      totalUsers = results[0] ?? 0;
      totalBooks = results[1] ?? 0;
      pendingRequests = results[2] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;
        return Scaffold(
          appBar: AppBar(title: Text("Admin Dashboard")),
          body: Row(
            children: [
              if (isLargeScreen) AdminSidebar(), // ✅ Keep sidebar visible on large screens
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: isLargeScreen ? 3 : 2, // Adjust based on screen size
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      _buildDashboardCard("Total Users", "$totalUsers", Icons.people),
                      _buildDashboardCard("Total Books", "$totalBooks", Icons.book),
                      _buildDashboardCard("Pending Requests", "$pendingRequests", Icons.pending), // ✅ Dynamic
                      _buildDashboardCard("Most Popular Genre", "Fiction", Icons.category),
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
