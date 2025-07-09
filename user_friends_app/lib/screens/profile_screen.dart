import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import './edit_profile_screen.dart';
import './friends_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(user.name[0], style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 10),
            Text(
              "Name: ${user.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Email: ${user.email}"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              ),
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FriendsScreen()),
              ),
              icon: const Icon(Icons.people),
              label: const Text("Manage Friends"),
            ),
          ],
        ),
      ),
    );
  }
}
