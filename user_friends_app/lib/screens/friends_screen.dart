import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        final user = provider.currentUser;
        final others = provider.allUsers;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Friends Management"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Friends: ${provider.friendCount}", style: const TextStyle(fontWeight: FontWeight.bold)),
                if (provider.statusMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      provider.statusMessage,
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                Expanded(
                  child: ListView(
                    children: [
                      const Text("Your Friends:", style: TextStyle(fontWeight: FontWeight.bold)),
                      if (user.friends.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("You have no friends yet."),
                        ),
                      ...user.friends.map((id) {
                        final friend = provider.allUsers.firstWhere((u) => u.id == id);
                        return Card(
                          color: Colors.lightGreen.shade100,
                          child: ListTile(
                            title: Text(friend.name),
                            subtitle: Text(friend.email),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => provider.removeFriend(friend.id),
                            ),
                          ),
                        );
                      }),
                      const Divider(),
                      const Text("Other Users:", style: TextStyle(fontWeight: FontWeight.bold)),
                      ...others.map((u) {
                        final isFriend = user.friends.contains(u.id);
                        return Card(
                          color: Colors.blue.shade50,
                          child: ListTile(
                            title: Text(u.name),
                            subtitle: Text(u.email),
                            trailing: ElevatedButton(
                              onPressed: isFriend ? null : () => provider.sendFriendRequest(u.id),
                              child: Text(isFriend ? "Friend" : "Send Request"),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
