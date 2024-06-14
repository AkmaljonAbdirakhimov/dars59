class Contact {
  final String id;
  String name;
  String phone;
  bool isFavorite;
  String? address;
  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.isFavorite,
    this.address,
  });
}
