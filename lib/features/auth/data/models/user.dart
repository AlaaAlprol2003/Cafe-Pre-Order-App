class UserModel {
  String id;
  String name;
  String email;
  String password;
  String phone;
  List<String> favoriteItems;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.favoriteItems,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "favoriteItems": favoriteItems,
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
      );
}
