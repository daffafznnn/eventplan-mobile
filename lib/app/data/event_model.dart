class Events {
  int? id;
  int? userId;
  String? uuid;
  String? title;
  String? organizer;
  String? category;
  int? price;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? typeLocation;
  String? technical;
  String? description;
  String? language;
  int? views;
  String? adminValidation;
  String? image;
  String? url;
  String? tags;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<EventLocations>? eventLocations;
  int? followersCount;
  int? eventCount;

  Events(
      {this.id,
      this.userId,
      this.uuid,
      this.title,
      this.organizer,
      this.category,
      this.price,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.typeLocation,
      this.technical,
      this.description,
      this.language,
      this.views,
      this.adminValidation,
      this.image,
      this.url,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.eventLocations,
      this.followersCount,
      this.eventCount});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    uuid = json['uuid'];
    title = json['title'];
    organizer = json['organizer'];
    category = json['category'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    typeLocation = json['type_location'];
    technical = json['technical'];
    description = json['description'];
    language = json['language'];
    views = json['views'];
    adminValidation = json['admin_validation'];
    image = json['image'];
    url = json['url'];
    tags = json['tags'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['event_locations'] != null) {
      eventLocations = <EventLocations>[];
      json['event_locations'].forEach((v) {
        eventLocations!.add(new EventLocations.fromJson(v));
      });
    }
    followersCount = json['followersCount'];
    eventCount = json['eventCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['organizer'] = this.organizer;
    data['category'] = this.category;
    data['price'] = this.price;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['type_location'] = this.typeLocation;
    data['technical'] = this.technical;
    data['description'] = this.description;
    data['language'] = this.language;
    data['views'] = this.views;
    data['admin_validation'] = this.adminValidation;
    data['image'] = this.image;
    data['url'] = this.url;
    data['tags'] = this.tags;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.eventLocations != null) {
      data['event_locations'] =
          this.eventLocations!.map((v) => v.toJson()).toList();
    }
    data['followersCount'] = this.followersCount;
    data['eventCount'] = this.eventCount;
    return data;
  }
}

class User {
  int? id;
  String? uuid;
  String? username;
  String? email;
  String? role;
  Profiles? profiles;

  User(
      {this.id,
      this.uuid,
      this.username,
      this.email,
      this.role,
      this.profiles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
    profiles = json['Profiles'] != null
        ? new Profiles.fromJson(json['Profiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;
    if (this.profiles != null) {
      data['Profiles'] = this.profiles!.toJson();
    }
    return data;
  }
}

class Profiles {
  int? id;
  int? userId;
  String? uuid;
  String? firstName;
  String? lastName;
  String? phone;
  String? organize;
  String? address;
  String? city;
  String? state;
  String? country;
  String? image;
  String? url;
  String? createdAt;
  String? updatedAt;

  Profiles(
      {this.id,
      this.userId,
      this.uuid,
      this.firstName,
      this.lastName,
      this.phone,
      this.organize,
      this.address,
      this.city,
      this.state,
      this.country,
      this.image,
      this.url,
      this.createdAt,
      this.updatedAt});

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    organize = json['organize'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    image = json['image'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['organize'] = this.organize;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['image'] = this.image;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class EventLocations {
  int? id;
  int? eventId;
  String? city;
  String? state;
  String? country;
  String? address;
  double? lat;
  double? long;
  String? createdAt;
  String? updatedAt;

  EventLocations(
      {this.id,
      this.eventId,
      this.city,
      this.state,
      this.country,
      this.address,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt});

  EventLocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventId'] = this.eventId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
