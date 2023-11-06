import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/rating_star.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class PopularCard extends StatelessWidget {
  final String popularCardImage;
  const PopularCard({
    super.key,
    required this.popularCardImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
              bottom: MediaQuery.of(context).size.height / 60.8,
              left: 15,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Munnar View Point',
                    style: TextStyle(
                      color: Color(0xFF1285b9),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  RatingStar(),
                  Padding(
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
                  child: Image.asset(
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
    );
  }
}
