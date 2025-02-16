import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../services/supabase_service.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await SupabaseService.getUsers();
    if (response != null) {
      setState(() {
        users = response;
      });
    }
  }

  Future<void> deleteUser(String userId) async {
    await SupabaseService.deleteUser(userId);
    fetchUsers(); // Refresh list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;
        return Scaffold(
          appBar: AppBar(title: Text("Manage Users")),
          body: Row(
            children: [
              if (isLargeScreen) AdminSidebar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: users.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      return ListTile(
                        leading: Icon(Icons.person, color: Colors.blue),
                        title: Text(user["name"] ?? "No Name"),
                        subtitle: Text(user["email"] ?? "No Email"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(user["id"]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          drawer: isLargeScreen ? null : Drawer(child: AdminSidebar()),
        );
      },
    );
  }
}
