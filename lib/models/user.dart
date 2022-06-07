class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? avatar;
  String? password;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
  toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'avatar': avatar,
    };
  }
}
