import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/place_cards.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/list/list_page_appbar.dart';

class PlaceListPage extends StatelessWidget {
  final String title;

  const PlaceListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    List<DestinationEntity> destinations = [];

    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.105,
        child: CustomAppbar(
          sortName: 'India',
          title: '$title Destinations',
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<DestinationController>(
          builder: (context, value, child) {
            destinations = title == 'Popular'
                ? destinations = value.popular
                : value.recommended;

            if (destinations.isNotEmpty) {
              return Column(
                children: destinations.map<Widget>((desination) {
                  return PlaceCardLg(
                    destination: desination,
                    isDetail: true,
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
