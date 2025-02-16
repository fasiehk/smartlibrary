import 'package:flutter/material.dart';
import 'screens/admin_dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      title: 'Admin Panel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AdminDashboard(),  // ✅ Start on the Admin Dashboard
    );
  }
}
