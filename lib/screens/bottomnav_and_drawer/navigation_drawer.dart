import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/bottomnav_and_drawer/drawer_item.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/settings_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/custom_alert.dart';

class NavigationDrawerr extends StatefulWidget {
  final String userId;
  final void Function(int)? updateIndex;
  final String? username;
  final String? useremail;
  final String? usermobile;
  final String? usergender;
  final String? userprofile;
  const NavigationDrawerr({
    super.key,
    required this.userId,
    required this.updateIndex,
    required this.username,
    required this.useremail,
    required this.usermobile,
    required this.usergender,
    required this.userprofile,
  });

  @override
  State<NavigationDrawerr> createState() => _NavigationDrawerrState();
}

class _NavigationDrawerrState extends State<NavigationDrawerr> {
  final AuthService authService = AuthService();
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = DatabaseService().getUserDetails(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFFe5e6f6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: userDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final userDataSnapshot =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String username = userDataSnapshot['fullname'];
                      String useremail = userDataSnapshot['email'];
                      String userProfile = userDataSnapshot['profilePic'];
                      return InkWell(
                        onTap: () {
                          widget.updateIndex?.call(4);
                          debugPrint('Profile Pressed');
                          Navigator.of(context).pop();
                        },
                        child: headerWidget(
                          username: username,
                          useremail: useremail,
                          userprofile: userProfile,
                        ),
                      );
                    }
                    return Container();
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color(0x331486b9),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              DrawerItem(
                name: 'Home',
                icon: FeatherIcons.home,
                onPressed: () {
                  widget.updateIndex?.call(0);
                  debugPrint('Home Pressed');
                  Navigator.of(context).pop();
                },
              ),
              DrawerItem(
                name: 'Explore',
                icon: FeatherIcons.search,
                onPressed: () {
                  widget.updateIndex?.call(1);
                  debugPrint('Explore Pressed');
                  Navigator.of(context).pop();
                },
              ),
              DrawerItem(
                name: 'Saved',
                icon: FeatherIcons.bookmark,
                onPressed: () {
                  nextScreen(
                    context,
                    WishlistScreen(
                      currentUserId: widget.userId,
                    ),
                  );
                },
              ),
              DrawerItem(
                name: 'Wishlists',
                icon: FeatherIcons.heart,
                onPressed: () {
                  widget.updateIndex?.call(3);
                  debugPrint('Home Pressed');
                  Navigator.of(context).pop();
                },
              ),
              DrawerItem(
                name: 'Settings',
                icon: FeatherIcons.settings,
                onPressed: () {
                  nextScreen(
                    context,
                    SettingsScreen(
                      userFullName: widget.username,
                      userEmail: widget.useremail,
                      userId: widget.userId,
                      userGender: widget.usergender,
                      userImage: widget.userprofile,
                      userMobileNumber: widget.usermobile,
                    ),
                  );
                },
              ),
              DrawerItem(
                name: 'Logout',
                icon: FeatherIcons.power,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        actionBtnTxt: 'Yes',
                        title: 'Confirm Logout',
                        description: 'Are you sure?',
                        onTap: () {
                          authService.signOut();
                          nextScreenRemoveUntil(
                              context, const UserLoginScreen());
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color(0x331486b9),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 150,
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.asset(appName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget(
      {String? username, String? useremail, String? userprofile}) {
    String image = defaultImage;
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: userprofile == '' ? const Color(0xFF1485b9) : Colors.black,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: Image(
            //   image: NetworkImage(userprofile ?? ''),
            //   fit: BoxFit.cover,
            // ),
            child: FadeInImage(
              image: userprofile == ''
                  ? Image.asset(image).image
                  : Image.network(userprofile ?? '').image,
              fit: BoxFit.cover,
              placeholder: AssetImage(image),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username ?? '',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              useremail ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            )
          ],
        )
      ],
    );
  }
}
