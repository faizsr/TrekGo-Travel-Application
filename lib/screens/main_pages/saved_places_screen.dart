import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/widgets/reusable_widgets/place_cards.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({
    super.key,
  });

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  late Box<Saved> savedBox;
  List<Saved>? savedList;
  String? hiveId;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    savedList = savedBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final savedPlaces = savedList!.toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.3),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFFe5e6f6),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  child: Text(
                    'Saved Places',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1285b9),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: SizedBox(
                    width: 60,
                    height: 65,
                    child: SavedIcon(biggerIcon: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: savedPlaces.isEmpty
          ? GestureDetector(
              onTap: () {
                debugPrint('saved places is empty: ${savedPlaces.isEmpty}');
              },
              child: const Center(
                child: Text('No Saved Places'),
              ),
            )
          : ListView.builder(
              itemCount: savedPlaces.length,
              itemBuilder: (context, index) {
                final saved = savedPlaces[index];

                return PopularCard(
                  popularCardImage: saved.image,
                  placeName: saved.name,
                  ratingCount: saved.rating,
                  placeDescripton: saved.description,
                  placeLocation: saved.location,
                );
              },
            ),
    );
  }
}
