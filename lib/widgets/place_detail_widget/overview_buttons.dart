import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/admin/update_place_screen.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/custom_alert.dart';
import 'package:trekmate_project/widgets/place_detail_widget/bottom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class OverviewBottomButtons extends StatelessWidget {
  final bool? isAdmin;
  final String? mapLink;
  final String? image;
  final String? category;
  final String? state;
  final String? title;
  final String? description;
  final String? location;
  final double? rating;
  final String? placeId;
  final BuildContext? ctx;
  const OverviewBottomButtons({
    super.key,
    this.isAdmin,
    this.mapLink,
    this.image,
    this.category,
    this.state,
    this.title,
    this.description,
    this.location,
    this.rating,
    this.placeId,
    this.ctx,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(255, 255, 255, 0),
          Color(0xF2f0f3f7),
          Color(0xFFf0f3f7),
          Color(0xFFf0f3f7),
          Color(0xFFf0f3f7),
          Color(0xFFf0f3f7),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: isAdmin == true
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          // ===== Checking if its admin =====
          isAdmin == true
              ? BottomButtons(
                  onPressed: () {
                    openGoogleMap(mapLink: mapLink);
                  },
                  widthValue: 0.3,
                  buttonText: 'Get Direction',
                )
              : Container(
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: BottomButtons(
                    onPressed: () {
                      openGoogleMap(mapLink: mapLink);
                    },
                    widthValue: 0.45,
                    buttonText: 'Get Direction',
                  ),
                ),

          // ===== Checking if its admin =====
          isAdmin == true
              ? BottomButtons(
                  onPressed: () async {
                    await onUpdateDetails(
                      image: image,
                      category: category,
                      state: state,
                      title: title,
                      description: description,
                      location: location,
                      rating: rating,
                      context: ctx,
                    );
                  },
                  widthValue: 0.3,
                  buttonText: 'Update Place',
                )
              : const BottomButtons(
                  widthValue: 0.45,
                  buttonText: 'Save Place',
                ),

          // ===== Checking if its admin =====
          isAdmin == true
              ? BottomButtons(
                  onPressed: () async {
                    await deleteDialog(ctx!, placeId);
                  },
                  widthValue: 0.3,
                  buttonText: 'Remove Place',
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  openGoogleMap({String? mapLink}) {
    String link = mapLink ?? '';
    Uri uri = Uri.parse(link);
    launchgoogleMap(uri);
  }

  launchgoogleMap(Uri googleMapsUrl) async {
    if (await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  deleteDialog(BuildContext context, String? placeId) async {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Delete Place?',
          description: 'This place will be permanently deleted from this list',
          onTap: () async {
            await deleteData(placeId ?? '');
            debugPrint('Deleted successfully');
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> deleteData(String placeid) async {
    await DatabaseService().destinationCollection.doc(placeid).delete();
  }

  onUpdateDetails({
    String? image,
    String? category,
    String? state,
    String? title,
    String? description,
    String? location,
    double? rating,
    BuildContext? context,
  }) async {
    nextScreen(
      context,
      UpdatePlaceScreen(
        placeid: placeId,
        placeImage: image,
        placeCategory: category,
        placeState: state,
        placeTitle: title,
        placeDescription: description,
        placeLocation: location,
        placeRating: rating,
      ),
    );
  }
}
