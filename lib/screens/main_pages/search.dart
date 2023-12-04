import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/place_detail_screen.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';
import 'package:trekmate_project/widgets/reusable_widgets/cards/recent_search_card.dart';

class SearchScreen extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  final void Function(int)? updateIndex;

  const SearchScreen({
    super.key,
    this.isAdmin,
    this.isUser,
    required this.userId,
    this.updateIndex,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? recentSearch;

  String name = '';

  @override
  void initState() {
    debugPrint('recentSearch : $recentSearch');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.215,
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            color: Color(0xFFe5e6f6),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.07,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                // ===== Appbar heading and icons =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Where do you \nwanna go?',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1285b9),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.updateIndex?.call(4);
                        debugPrint('Search Profile icon tapped');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF1285b9),
                        child: Icon(
                          Icons.person_2_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                // ===== Appbar search area =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(
                      controller: searchController,
                      colorIsWhite: true,
                      noPaddingNeeded: true,
                      fieldHintText: 'Search here...',
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    Container(
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
                      child: const Icon(FeatherIcons.search),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().destinationCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            List<QueryDocumentSnapshot> recentSearchResult = documents
                .where((search) =>
                    recentSearch != null &&
                    recentSearch!['place_id'] == search.id)
                .toList();

            List<QueryDocumentSnapshot> searchResults = documents
                .where((search) =>
                    recentSearch == null &&
                    (search['place_name']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase()) ||
                        search['place_state']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())))
                .toList();

            if (recentSearchResult.isEmpty) {
              return const Center(
                child: Text('No recent search'),
              );
            }

            if (recentSearchResult.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 100),
                // itemCount: snapshot.data!.docs.length,
                itemCount: recentSearchResult.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint('On recent searches');
                      nextScreen(
                        context,
                        PlaceDetailScreen(
                          userId: widget.userId,
                          isAdmin: widget.isAdmin,
                          isUser: widget.isUser,
                          placeid: recentSearchResult[index].id,
                        ),
                      );
                    },
                    child: RecentSearchCard(
                      userId: widget.userId,
                      isAdmin: widget.isAdmin,
                      isUser: widget.isAdmin,
                      placeId: recentSearchResult[index].id,
                      cardImage: recentSearch!['place_image'],
                      cardTitle: recentSearch!['place_name'],
                      ratingCount: recentSearch!['place_rating'],
                    ),
                  );
                },
              );
            } else

            // ========== Search field sorting ==========
            if (searchResults.isNotEmpty) {
              debugPrint('Search Sorting');
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 100),
                // itemCount: snapshot.data!.docs.length,
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var data =
                      searchResults[index].data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      debugPrint('On recent searches');
                      nextScreen(
                        context,
                        PlaceDetailScreen(
                          userId: widget.userId,
                          isAdmin: widget.isAdmin,
                          isUser: widget.isUser,
                          placeid: searchResults[index].id,
                        ),
                      );
                    },
                    child: RecentSearchCard(
                      userId: widget.userId,
                      isAdmin: widget.isAdmin,
                      isUser: widget.isAdmin,
                      placeId: searchResults[index].id,
                      cardImage: data['place_image'],
                      cardTitle: data['place_name'],
                      ratingCount: data['place_rating'],
                    ),
                  );
                },
              );
            } else {
              debugPrint('No search');
              return const Center(
                child: Text('No recent searches or results'),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:feather_icons/feather_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:trekmate_project/service/database_service.dart';
// import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';
// import 'package:trekmate_project/widgets/reusable_widgets/cards/recent_search_card.dart';

// class SearchScreen extends StatefulWidget {
//   final bool? isAdmin;
//   final bool? isUser;
//   final String? userId;
//   final void Function(int)? updateIndex;

//   const SearchScreen({
//     super.key,
//     this.isAdmin,
//     this.isUser,
//     required this.userId,
//     this.updateIndex,
//   });

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();

//   String name = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(
//           MediaQuery.of(context).size.width,
//           MediaQuery.of(context).size.height * 0.215,
//         ),
//         child: Container(
//           // height: MediaQuery.of(context).size.height * 0.2,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(30),
//               bottomLeft: Radius.circular(30),
//             ),
//             color: Color(0xFFe5e6f6),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.width * 0.07,
//               left: 20,
//               right: 20,
//             ),
//             child: Column(
//               children: [
//                 // ===== Appbar heading and icons =====
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Where do you \nwanna go?',
//                       style: TextStyle(
//                         fontSize: 23,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1285b9),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         widget.updateIndex?.call(4);
//                         debugPrint('Search Profile icon tapped');
//                       },
//                       child: const CircleAvatar(
//                         backgroundColor: Color(0xFF1285b9),
//                         child: Icon(
//                           Icons.person_2_outlined,
//                           size: 25,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),

//                 // ===== Appbar search area =====
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextFieldWidget(
//                       controller: searchController,
//                       colorIsWhite: true,
//                       noPaddingNeeded: true,
//                       fieldHintText: 'Search here...',
//                       onChanged: (val) {
//                         setState(() {
//                           name = val;
//                         });
//                       },
//                     ),
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 10,
//                             offset: Offset(0, 2),
//                             color: Color(0x0D000000),
//                           )
//                         ],
//                       ),
//                       width: MediaQuery.of(context).size.width * 0.14,
//                       height: MediaQuery.of(context).size.height * 0.0625,
//                       child: const Icon(FeatherIcons.search),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: DatabaseService().destinationCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               padding: const EdgeInsets.only(top: 20, bottom: 100),
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var data =
//                     snapshot.data!.docs[index].data() as Map<String, dynamic>;

//                 DocumentSnapshot destinationSnapshot =
//                     snapshot.data!.docs[index];

//                 // ========== When no filtering ==========
//                 if (name.isEmpty) {
//                   debugPrint('No Sorting');
//                   return RecentSearchCard(
//                     userId: widget.userId,
//                     isAdmin: widget.isAdmin,
//                     isUser: widget.isAdmin,
//                     placeId: destinationSnapshot.id,
//                     cardImage: data['place_image'],
//                     cardTitle: data['place_name'],
//                     ratingCount: data['place_rating'],
//                   );
//                 }

//                 // ========== Search field sorting ==========
//                 if (data['place_name']
//                         .toString()
//                         .toLowerCase()
//                         .startsWith(name.toLowerCase()) ||
//                     data['place_state']
//                         .toString()
//                         .toLowerCase()
//                         .startsWith(name.toLowerCase())) {
//                   debugPrint('Search Sorting');
//                   return RecentSearchCard(
//                     userId: widget.userId,
//                     isAdmin: widget.isAdmin,
//                     isUser: widget.isAdmin,
//                     placeId: destinationSnapshot.id,
//                     cardImage: data['place_image'],
//                     cardTitle: data['place_name'],
//                     ratingCount: data['place_rating'],
//                   );
//                 }

//                 return Container();
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }



