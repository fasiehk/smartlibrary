import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/admin_dashboard.dart'; // Ensure correct path
import 'screens/auth_screen.dart' as auth_screen; // Alias to avoid conflicts


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url: 'https://fkxpzsvspzkmfcuahzqa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZreHB6c3ZzcHprbWZjdWFoenFhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxMDM5MjQsImV4cCI6MjA1NDY3OTkyNH0.3DY-n_-UvezAYGRC9vXxGBO3-RzvzPe7rqCvodEkemE',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Library Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(), // ✅ New widget to handle login state
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return user != null ? AdminDashboard() : auth_screen.AuthScreen(); // ✅ Redirect logic
  }
}
