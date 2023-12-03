import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/helper/hive_db_function.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/update_wishlist_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

class WishlistPlaceDetail extends StatefulWidget {
  final String? hiveKey;
  final String? userId;
  final double? snackBarBottomPadding;
  const WishlistPlaceDetail({
    super.key,
    this.hiveKey,
    this.userId,
    this.snackBarBottomPadding,
  });

  @override
  State<WishlistPlaceDetail> createState() => _WishlistPlaceDetailState();
}

class _WishlistPlaceDetailState extends State<WishlistPlaceDetail> {
  late Box<Wishlist> wishlistBox;
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    wishlistBox = Hive.box('wishlists');
    debugPrint('Key on wishlist detail screen : ${widget.hiveKey}');
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFc0f8fe));
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
                    Navigator.of(context).pop('refresh');
                  },
                  child: const Icon(
                    Icons.keyboard_backspace_rounded,
                    color: Colors.black,
                  ),
                ),
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
      body: ValueListenableBuilder(
          valueListenable: wishlistBox.listenable(),
          builder: (context, Box<Wishlist> wishlistBox, child) {
            var wishlistList = wishlistBox.get(widget.hiveKey);

            String? wishlistImage = wishlistList?.image;
            return Container(
              height: MediaQuery.of(context).size.height,
              // margin: const EdgeInsets.only(top: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF0F3F7),
                    Color(0xFFC0F8FE),
                  ],
                  stops: [0.35, 0.77],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ============ Place Image ============
                    Container(
                      margin: const EdgeInsets.only(
                        top: 25,
                        bottom: 20,
                        left: 25,
                        right: 25,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: wishlistImage != null && wishlistImage.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(wishlistImage)),
                                )
                              : null),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 15,
                            child: GestureDetector(
                              onTap: () {
                                nextScreen(
                                  context,
                                  UpdateWishlistScreen(
                                    hiveKey: widget.hiveKey,
                                    userId: widget.userId,
                                    image: wishlistList?.image ?? '',
                                    name: wishlistList?.name ?? '',
                                    state: wishlistList?.state ?? '',
                                    description: wishlistList?.description ?? '',
                                    location: wishlistList?.location ?? '',
                                  ),
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color(0xFFe5e6f6),
                                radius: 18,
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 15,
                            child: GestureDetector(
                              onTap: () async {
                                await deleteWishlist(
                                  context,
                                  wishlistBox,
                                  widget.hiveKey ?? '',
                                  widget.snackBarBottomPadding ?? 0,
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color(0xFFe5e6f6),
                                radius: 18,
                                child: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    // ============ Place Title ============
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.67,
                      child: Text(
                        wishlistList?.name ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
              
                    // ============ Tab Bar Heading ============
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Divider(
                            height: 10,
                            thickness: 1,
                            color: Color(0x0D000000),
                          ),
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1285b9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 5),
                            width: 40,
                            child: const Divider(
                              thickness: 1.6,
                              height: 1,
                              color: Color(0xFF1285b9),
                            ),
                          ),
                          const Divider(
                            height: 10,
                            thickness: 1,
                            color: Color(0x0D000000),
                          ),
                        ],
                      ),
                    ),
              
                    // ============ Tab Bar Views ============
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                wishlistList?.description ?? '',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            const Divider(
                              height: 30,
                              thickness: 1,
                              color: Color(0x0D000000),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
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
                                      wishlistList?.location ?? '',
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
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    resetStatusBarColor();
  }
}
