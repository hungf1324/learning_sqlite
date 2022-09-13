class StudentModel {
  final int? id;
  String name;
  String address;
  String phone;

  StudentModel({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
      };
}
