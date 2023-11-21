import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/reusable_widgets/recent_search_card.dart';

class SearchScreen extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  const SearchScreen({
    super.key,
    this.isAdmin,
    this.isUser,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.25,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.235,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            color: Color(0xFFe5e6f6),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.098,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1285b9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.person_2_outlined,
                        size: 25,
                        color: Colors.white,
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
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                DocumentSnapshot destinationSnapshot =
                    snapshot.data!.docs[index];

                // ========== When no filtering ==========
                if (name.isEmpty) {
                  debugPrint('No Sorting');
                  return RecentSearchCard(
                    isAdmin: widget.isAdmin,
                    isUser: widget.isAdmin,
                    placeId: destinationSnapshot.id,
                    cardImage: data['place_image'],
                    cardTitle: data['place_name'],
                    ratingCount: data['place_rating'],
                  );
                }

                // ========== Search field sorting ==========
                if (data['place_name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase()) ||
                    data['place_state']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                  debugPrint('Search Sorting');
                  return RecentSearchCard(
                    isAdmin: widget.isAdmin,
                    isUser: widget.isAdmin,
                    placeId: destinationSnapshot.id,
                    cardImage: data['place_image'],
                    cardTitle: data['place_name'],
                    ratingCount: data['place_rating'],
                  );
                }

                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
