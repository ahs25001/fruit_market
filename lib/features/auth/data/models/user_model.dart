class UserModel {
  final String? name;
  final String? phone;
  final String? address;
   final String? id;

  UserModel(
      {required this.name,
      required this.phone,
     required this.id,
      required this.address});
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        phone = json['phone'],
        address = json['address'];
  Map<String, dynamic> toJson() =>
      {'name': name, 'phone': phone, 'address': address, "id": id};
}
