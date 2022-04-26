class User {
  String? uid;
  String? name;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? gender;
  String? avatar;
  String? fcmToken;
  String? fcmTopic;
  bool? isStaff;

  User(
      {this.uid,
      this.name,
      this.firstName,
      this.middleName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.gender,
      this.avatar,
      this.fcmToken,
      this.fcmTopic,
      this.isStaff});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        name: json['name'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        gender: json['gender'],
        avatar: json['avatar'],
        fcmToken: json['fcm_token'],
        fcmTopic: json['fcm_topic']);
  }
}
