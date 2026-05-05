import 'package:dash_cup/core/models/graduation_project_model.dart';

class UserModel {
  static UserModel? currentUser;
  String id;
  String name;
  String email;
  String password;
  String phone;
  int points;
  String? image;
  List<String> favoriteItems;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.favoriteItems,
    required this.points,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "favoriteItems": favoriteItems,
        "points":points,
        "image": image,
      };

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          name: json["name"],
          email: json["email"],
          password: json["password"],
          phone: json["phone"],
          favoriteItems: (json["favoriteItems"] as List<dynamic>)
              .map((item) => item.toString())
              .toList(),
              points: json["points"] ?? 0,
              image: json["image"],
        );
}
