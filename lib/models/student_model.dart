class StudentModel {
  final int? id;
  final String name;
  final String address;
  final int phone;

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
