class DestinationEntity {
  final String id;
  final String name;
  final String image;
  final String category;
  final String state;
  final double rating;
  final String description;
  final String location;
  final String mapUrl;

  DestinationEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.state,
    required this.rating,
    required this.description,
    required this.location,
    required this.mapUrl,
  });
}




//  placeid: destinationSnapshot.id,
//                 popularCardImage: destinationSnapshot['place_image'],
//                 placeCategory: destinationSnapshot['place_category'],
//                 placeState: destinationSnapshot['place_state'],
//                 placeName: destinationSnapshot['place_name'],
//                 ratingCount: double.tryParse(
//                     destinationSnapshot['place_rating'].toString()),
//                 placeDescripton: destinationSnapshot['place_description'],
//                 placeLocation: destinationSnapshot['place_location'],
//                 placeMap: destinationSnapshot['place_map'],