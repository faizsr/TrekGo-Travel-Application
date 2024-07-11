import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class PlaceImageSection extends StatelessWidget {
  const PlaceImageSection({
    super.key,
    required this.destination,
  });

  final DestinationEntity destination;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: kBoxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          placeholder: (context, url) => Image.asset(
            lazyLoading,
            fit: BoxFit.cover,
          ),
          imageUrl: destination.image,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            lazyLoading,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
