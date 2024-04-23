class User {
  UserClass user;
  Profile profile;
  int followersCount;
  int followingCount;
  int eventCount;

  User({
    required this.user,
    required this.profile,
    required this.followersCount,
    required this.followingCount,
    required this.eventCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user: UserClass.fromJson(json['user']),
      profile: Profile.fromJson(json['profile']),
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      eventCount: json['eventCount'],
    );
  }
}

class Profile {
  int id;
  int userId;
  String uuid;
  String firstName;
  String lastName;
  String phone;
  String organize;
  String address;
  String city;
  String state;
  String country;
  String image;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.organize,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.image,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['userId'],
      uuid: json['uuid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      organize: json['organize'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      image: json['image'],
      url: json['url'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class UserClass {
  int id;
  String uuid;
  String username;
  String email;
  String role;
  DateTime createdAt;

  UserClass({
    required this.id,
    required this.uuid,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      id: json['id'],
      uuid: json['uuid'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  get firstName => null;

  get lastName => null;
}
