import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;

  @override
  void initState() {
    super.initState();
    final currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    name = currentUser.name;
    email = currentUser.email;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final currentUser = provider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: currentUser.name,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                initialValue: currentUser.email,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  provider.editProfile(name, email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile updated")),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
