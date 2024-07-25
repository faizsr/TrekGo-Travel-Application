class DestinationEntity {
  final String id;
  final String name;
  final String image;
  final String category;
  final String state;
  final num rating;
  final String description;
  final String location;
  final String mapUrl;

  DestinationEntity({
    this.id = '',
    required this.name,
    required this.image,
    required this.category,
    required this.state,
    this.rating = 0,
    required this.description,
    required this.location,
    required this.mapUrl,
  });
}
