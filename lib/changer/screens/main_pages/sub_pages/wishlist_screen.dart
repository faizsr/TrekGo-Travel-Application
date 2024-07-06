import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trekgo_project/changer/model/wishlist.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/wishlist_place_detail.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/chips_and_drop_downs/filter_chip.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/cards/wishlist_card_all.dart';

class WishlistScreen extends StatefulWidget {
  final String? currentUserId;
  const WishlistScreen({super.key, this.currentUserId});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final TextEditingController searchController = TextEditingController();
  late Box<Wishlist> wishlistBox;
  late int indexValue = 0;
  List<Wishlist>? filteredList;
  List<String> selectedState = [];
  late String searchValue;
  String? refresh;

  final List<String> states = [
    'Kerala',
    'Karnataka',
    'Rajasthan',
    'Goa',
    'Himachal Pradesh',
    'Tamil Nadu',
    'Meghalaya',
    'Gujarat',
    'Andhra pradesh',
    'Madhya Pradesh',
    'Maharashtra',
  ];

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlists');
    filteredList = wishlistBox.values.toList();
    searchValue = '';
    debugPrint('user id on wishlist screen: ${widget.currentUserId}');
  }

  updateData() {
    setState(() {
      filteredList = wishlistBox.values.toList();
      selectedState;
    });
  }

  searchFilter(String value) {
    if (value.isEmpty) {
      setState(() {
        filteredList = wishlistBox.values.toList();
      });
    } else {
      setState(() {
        filteredList = wishlistBox.values
            .where((place) =>
                (place.state ?? '')
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()) ||
                (place.name ?? '')
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()))
            .toList();
        // debugPrint('filter: $filteredList');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFe5e6f6));
    final filterPlaces = filteredList
        ?.where((place) {
          return selectedState.isEmpty ||
              selectedState.contains(place.state?.toLowerCase());
        })
        .where((wishlist) => wishlist.userId == widget.currentUserId)
        .toList();
    return Scaffold(
      // ===== Appbar =====
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            Navigator.of(context).pop();
            await updateData();
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Your Wishlist',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
        // centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      // ===== Body =====
      body: Column(
        children: [
          Container(
            color: const Color(0xFFe5e6f6),
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: searchController,
                  // colorIsWhite: true,
                  // noPaddingNeeded: true,
                  hintText: 'Search here...',
                  onChanged: (value) {
                    searchValue = value;
                    searchFilter(value);
                    debugPrint('searchValue: $searchValue');
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Wrap(
                              spacing: 8.0,
                              children: states
                                  .map((category) => FilterChipWidget(
                                        selectedState: selectedState,
                                        category: category,
                                        onUpdateData: updateData,
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      );
                      // debugPrint('$selectedState');
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(0, 2),
                            color: Color(0x0D000000),
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.height * 0.0625,
                      child: const Icon(FeatherIcons.filter),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: filterPlaces!.length,
              itemBuilder: (context, index) {
                final wishlists = filterPlaces[index];

                return GestureDetector(
                  onTap: () async {
                    debugPrint('index on wishlist screen: $index');
                    setState(() {
                      indexValue = index;
                    });
                    refresh = await Navigator.of(context).push(
                      PageTransition(
                          child: WishlistPlaceDetail(
                            hiveKey: wishlists.hiveKey,
                            userId: wishlists.userId,
                          ),
                          type: PageTransitionType.fade),
                    );
                    if (refresh == 'refresh') {
                      debugPrint('updating $refresh');
                      updateData();
                    }
                  },
                  child: WishlistCardAll(
                    backgroundImage: wishlists.image.toString(),
                    placeName: wishlists.name.toString(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(const Color(0xFFc0f8fe));
  }
}
