class User {
  final String name;
  final String lastName;
  final String birthdate;
  final List<String> address;
  String? avatarUrl;

  User({
    required this.name,
    required this.lastName,
    required this.birthdate,
    required this.address,
    this.avatarUrl,
  });
}
