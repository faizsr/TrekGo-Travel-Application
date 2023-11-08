import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/place_detail_screen.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/Firebase/card_rating_bar.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class PopularCard extends StatelessWidget {
  final String? placeName;
  final String popularCardImage;
  final double? ratingCount;
  final String? placeDescripton;
  final String? placeLocation;
  const PopularCard({
    super.key,
    required this.popularCardImage,
    this.placeName,
    this.ratingCount,
    this.placeDescripton,
    this.placeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              placeImage: popularCardImage,
              placeName: placeName,
              ratingCount: ratingCount,
              description: placeDescripton,
              location: placeLocation,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 2,
                color: Color(0x0D000000),
              )
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.88,
          height: MediaQuery.of(context).size.height / 2.95,
          child: Stack(
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        placeName ?? '',
                        style: const TextStyle(
                            color: Color(0xFF1285b9),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    CardRatingBar(
                      ratingCount: ratingCount ?? 0,
                      itemSize: 20,
                      isRatingTextNeeded: true,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 2,
                        top: 2,
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      color: Color(0x0D000000),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Image.network(
                      popularCardImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 30,
                bottom: MediaQuery.of(context).size.width * 0.16,
                child: const SavedIcon(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
