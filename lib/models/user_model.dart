class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String userType; // 'provider' or 'customer'
  final String? address;
  final List<String>? skills;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.address,
    this.skills,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userType: json['userType'],
      address: json['address'],
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'userType': userType,
    'address': address,
    'skills': skills,
  };
}
