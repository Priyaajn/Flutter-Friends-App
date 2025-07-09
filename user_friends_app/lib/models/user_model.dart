class AppUser {
  final String id;
  String name;
  String email;
  List<String> friends;
  List<String> friendRequests;
  List<String> acceptedRequests;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    List<String>? friends,
    List<String>? friendRequests,
    List<String>? acceptedRequests,
  }) : friends = friends ?? [],
       friendRequests = friendRequests ?? [],
       acceptedRequests = acceptedRequests ?? [];
}
