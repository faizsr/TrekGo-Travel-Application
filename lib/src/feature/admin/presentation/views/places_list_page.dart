import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_appbar.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_place_card.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinationController>(context, listen: false)
        ..getPopular()
        ..getRecommended();
    });

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AdminAppbar(title: 'All Places'),
      ),
      body: Consumer<DestinationController>(
        builder: (context, value, child) {
          List<DestinationEntity> destinations =
              value.popular + value.recommended;
          log('Destinations Length: ${destinations.length}');
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            separatorBuilder: (context, index) => const Gap(height: 15),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              DestinationEntity destination = destinations[index];
              return AdminPlaceCard(destination: destination);
            },
          );
        },
      ),
    );
  }
}
