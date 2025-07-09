import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class UserProvider with ChangeNotifier {
  List<AppUser> _allUsers = [];
  late AppUser _currentUser;
  String _statusMessage = "";

  UserProvider() {
    final uuid = const Uuid();

    final priya = AppUser(
      id: uuid.v4(),
      name: "Priya",
      email: "priya@example.com",
      friends: [],
      friendRequests: [],
      acceptedRequests: [],
    );

    _currentUser = priya;

    _allUsers = [
      _currentUser,
      AppUser(id: uuid.v4(), name: "Alisa", email: "alisa@mail.com"),
      AppUser(id: uuid.v4(), name: "Navya", email: "navya@mail.com"),
      AppUser(id: uuid.v4(), name: "Kavya", email: "kavya@mail.com"),
      AppUser(id: uuid.v4(), name: "Bhavya", email: "bhavya@mail.com"),
    ];
  }

  /// Getters
  AppUser get currentUser => _currentUser;
  List<AppUser> get allUsers =>
      _allUsers.where((u) => u.id != _currentUser.id).toList();
  String get statusMessage => _statusMessage;
  int get friendCount => _currentUser.friends.length;

  /// Edit Profile
  void editProfile(String name, String email) {
    _currentUser.name = name;
    _currentUser.email = email;
    notifyListeners();
  }

  /// Send friend request (auto-accept after 1 sec)
  void sendFriendRequest(String userId) {
    final user = _allUsers.firstWhere((u) => u.id == userId);

    if (!_currentUser.friends.contains(user.id)) {
      _currentUser.friends.add(user.id);
      _currentUser.acceptedRequests.add(user.id);
      user.friends.add(_currentUser.id);

      _statusMessage = "${user.name} accepted your friend request!";
      _allUsers = [..._allUsers]; // trigger UI update
      notifyListeners();

      // Clear message after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        _statusMessage = "";
        notifyListeners();
      });
    }
  }

  /// Remove friend
  void removeFriend(String friendId) {
    _currentUser.friends.remove(friendId);
    _currentUser.acceptedRequests.remove(friendId);

    final friend = _allUsers.firstWhere((u) => u.id == friendId);
    friend.friends.remove(_currentUser.id);

    _allUsers = [..._allUsers]; // trigger UI update
    notifyListeners();
  }
}
