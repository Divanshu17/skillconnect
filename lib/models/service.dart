class Service {
  final String id;
  final String title;
  final String provider;
  final String imageUrl;
  final String price;
  final double rating;
  final String location;
  final String phone;
  final String experience;
  final String availability;
  final String description;
  final List<String> gallery;
  final String category;
  final bool isFavorite;

  Service({
    required this.id,
    required this.title,
    required this.provider,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.location,
    required this.phone,
    required this.experience,
    required this.availability,
    this.description = '',
    this.gallery = const [],
    this.category = '',
    this.isFavorite = false,
  });

  Service copyWith({
    String? id,
    String? title,
    String? provider,
    String? imageUrl,
    String? price,
    double? rating,
    String? location,
    String? phone,
    String? experience,
    String? availability,
    String? description,
    List<String>? gallery,
    String? category,
    bool? isFavorite,
  }) {
    return Service(
      id: id ?? this.id,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      experience: experience ?? this.experience,
      availability: availability ?? this.availability,
      description: description ?? this.description,
      gallery: gallery ?? this.gallery,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
