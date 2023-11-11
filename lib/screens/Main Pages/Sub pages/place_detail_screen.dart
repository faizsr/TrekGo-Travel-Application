import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/screens/Admin/update_place_screen.dart';
import 'package:trekmate_project/widgets/Place%20detail%20widget/bottom_buttons.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/Firebase/card_rating_bar.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String? placeid;
  final String? placeCategory;
  final String? placeState;
  final String? placeImage;
  final String? placeName;
  final double? ratingCount;
  final String? description;
  final String? location;
  final bool? isAdmin;
  final bool? isUser;
  const PlaceDetailScreen({
    super.key,
    this.placeid,
    this.placeCategory,
    this.placeState,
    this.placeImage,
    this.placeName,
    this.ratingCount,
    this.description,
    this.location,
    this.isAdmin,
    this.isUser,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      extendBodyBehindAppBar: true,

      // ============ Appbar ============
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
        child: Container(
          margin: const EdgeInsets.only(
            top: 45,
            left: 45,
            right: 45,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 4.0,
              ),
              child: AppBar(
                title: const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.keyboard_backspace_rounded,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      MdiIcons.dotsVertical,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
                backgroundColor: Colors.white24,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

      // ============ Body ============
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ============ Place Image ============
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 25,
                    right: 25,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.placeImage ?? ''),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 7.0,
                              sigmaY: 4.0,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white12,
                              child: Icon(
                                MdiIcons.directions,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ============ Place Title ============
                Text(
                  widget.placeName ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CardRatingBar(
                  itemSize: 20,
                  isMainAlignCenter: true,
                  ratingCount: widget.ratingCount,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0x0D000000),
                ),

                // ============ Tab Bar Heading ============
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.035,
                  child: TabBar(
                    physics: const BouncingScrollPhysics(),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.all(0),
                    indicatorColor: const Color(0xFF1285b9),
                    labelColor: const Color(0xFF1285b9),
                    unselectedLabelColor: Colors.grey,
                    controller: tabController,
                    tabs: const [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  color: Color(0x0D000000),
                ),

                // ============ Tab Bar Views ============
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.355,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                widget.description!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            const Divider(
                              height: 30,
                              thickness: 1,
                              color: Color(0x0D000000),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 30,
                                    color: Color(0xFF1285b9),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      widget.location!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text('Rating section'),
                      ),
                      const Center(
                        child: Text('Review section'),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0x0D000000),
                ),

                // ============ Bottom buttons ============
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: widget.isAdmin == true
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [

                      // ===== Checking if its admin =====
                      widget.isAdmin == true
                          ? const BottomButtons(
                              widthValue: 3.6,
                              buttonText: 'Get Direction',
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: const BottomButtons(
                                widthValue: 2.3,
                                buttonText: 'Get Direction',
                              ),
                            ),

                      // ===== Checking if its admin =====
                      widget.isAdmin == true
                          ? BottomButtons(
                              onPressed: () async {
                                onUpdateDetails();
                              },
                              widthValue: 3.4,
                              buttonText: 'Update Place',
                            )
                          : const BottomButtons(
                              widthValue: 2.3,
                              buttonText: 'Save Place',
                            ),

                      // ===== Checking if its admin =====
                      widget.isAdmin == true
                          ? const BottomButtons(
                              widthValue: 3.3,
                              buttonText: 'Remove Place',
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onUpdateDetails() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UpdatePlaceScreen(
        placeid: widget.placeid,
        placeImage: widget.placeImage,
        placeCategory: widget.placeCategory,
        placeState: widget.placeState,
        placeTitle: widget.placeName,
        placeDescription: widget.description,
        placeLocation: widget.location,
        placeRating: widget.ratingCount,
      ),
    ));
  }
}
