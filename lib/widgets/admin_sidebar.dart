import 'package:flutter/material.dart';
import '../screens/admin_dashboard.dart';
import '../screens/manage_users.dart';
import '../screens/manage_books.dart';
import '../screens/analytics_screen.dart';

class AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.admin_panel_settings, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text("Admin Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.dashboard, "Dashboard", AdminDashboard()),
          _buildDrawerItem(context, Icons.book, "Manage Books", ManageBooksScreen()),
          _buildDrawerItem(context, Icons.people, "Manage Users", ManageUsersScreen()),
          _buildDrawerItem(context, Icons.analytics, "Analytics", AnalyticsScreen()),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Use push to navigate and keep sidebar visible
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
