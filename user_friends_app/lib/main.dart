import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/user_provider.dart';
import './screens/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User & Friends App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 18)),
      ),
      home: const ProfileScreen(),
    );
  }
}
