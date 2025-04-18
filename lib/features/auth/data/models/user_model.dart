class UserModel {
  final String? name;
  final String? phone;
  final String? address;
  final String? id;
  final String? image;
  final String email;

  UserModel(
      {required this.name,
      required this.phone,
      required this.email,
      this.image,
      required this.id,
      required this.address});
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        phone = json['phone'],
        email = json['email'],
        image = json['image'],
        address = json['address'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'address': address,
        "id": id
      };
}
