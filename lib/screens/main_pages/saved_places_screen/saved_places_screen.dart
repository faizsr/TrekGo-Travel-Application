import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/cards/saved_screen_card.dart';
import 'package:trekmate_project/screens/main_pages/saved_places_screen/widgets/saved_icon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SavedPlacesScreen extends StatefulWidget {
  final String userId;
  final bool? isAdmin;
  final bool? isUser;
  final void Function(int)? updateIndex;
  const SavedPlacesScreen({
    super.key,
    required this.userId,
    required this.isAdmin,
    required this.isUser,
    required this.updateIndex,
  });

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  late Box<Saved> savedBox;
  // List<Saved>? savedList;
  String? hiveId;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    // savedList = savedBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFe5e6f6));

    // final savedPlaces = savedList!.toList();
    return ValueListenableBuilder(
      valueListenable: savedBox.listenable(),
      builder: (context, Box<Saved> savedBox, child) {
        var savedPlaces = savedBox.values
            // .where((saved) => saved.userId == widget.userId)
            .toList();

        savedPlaces.sort(
          (a, b) => b.dateTime!.compareTo(a.dateTime!),
        );

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.11),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFe5e6f6),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: const Stack(
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
                        child: SavedIcon(
                          biggerIcon: true,
                          disableOnPressed: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: savedPlaces.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.28,
                      ),
                      Image.asset('assets/images/Empty_saved_icon.png'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0x73000000),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Add To Save?',
                              speed: const Duration(milliseconds: 100),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            ),
                          ],
                          onTap: () {
                            widget.updateIndex!.call(0);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: savedPlaces.length,
                  itemBuilder: (context, index) {
                    final saved = savedPlaces[index];
                    debugPrint('id on saved screennnn: ${saved.firebaseid}');
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SavedScreenCard(
                        index: index,
                        userId: widget.userId,
                        isAdmin: widget.isAdmin,
                        isUser: widget.isUser,
                        placeid: saved.firebaseid,
                        popularCardImage: saved.image,
                        placeName: saved.name,
                        ratingCount: saved.rating,
                        placeDescripton: saved.description,
                        placeLocation: saved.location,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
