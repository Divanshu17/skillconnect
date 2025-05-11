class Product {
  final String id;
  final String sellerId;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final bool isAvailable;

  Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    this.isAvailable = true,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sellerId: json['sellerId'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      images: List<String>.from(json['images']),
      category: json['category'],
      isAvailable: json['isAvailable'],
    );
  }
}
