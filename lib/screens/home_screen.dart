// import 'package:flutter/material.dart';
// import 'package:trekmate_project/widgets/Home%20screen%20widgets/main_subtitle.dart';
// import 'package:trekmate_project/widgets/Home%20screen%20widgets/top_bar_items.dart';
// import 'package:trekmate_project/widgets/Main%20screens%20widgets/appbar_subtitles.dart';
// import 'package:trekmate_project/widgets/Reusable%20widgets/place_cards.dart';
// import 'package:trekmate_project/widgets/scroll_button.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.26,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFe5e6f6),
//                     borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(60),
//                     ),
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         top: MediaQuery.of(context).size.width * 0.06,
//                         right: 25,
//                         left: 25,
//                         child: const TopBarItems(),
//                       ),
//                       Positioned(
//                         top: MediaQuery.of(context).size.width * 0.24,
//                         left: 25,
//                         child: const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AppbarSubtitles(
//                               subtitleText: 'Hello Adam',
//                               subtitleSize: 14,
//                             ),
//                             AppbarSubtitles(
//                               subtitleText: 'Find Your Dream \nDestination',
//                               subtitleSize: 23,
//                               subtitleColor: Color(0xFF1285b9),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: MediaQuery.of(context).size.height * 0.225,
//                   child: SizedBox(
//                     // color: Colors.black,
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 0.07,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: 10,
//                           right: 20,
//                           top: MediaQuery.of(context).size.width * 0.037,
//                           bottom: MediaQuery.of(context).size.width * 0.037,
//                         ),
//                         child: const Row(
//                           children: [
//                             ScrollButtons(
//                               buttonText: 'Kerala',
//                               buttonTextColor: Colors.white,
//                               buttonBgColor: Color(0xFF1285b9),
//                               buttonBrColor: Colors.white,
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Mumbai',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Karnataka',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Goa',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Kashmir',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Kolkata',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Hyderbad',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                             ScrollButtons(
//                               buttonText: 'Sikkim',
//                               buttonTextColor: Color(0xFF1285b9),
//                               buttonBgColor: Colors.white,
//                               buttonBrColor: Color(0xFF1285b9),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       MainSubtitles(subtitleText: 'Popular'),
//                       PopularCard(),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       MainSubtitles(subtitleText: 'Recommended'),
//                       PopularCard()
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       MainSubtitles(subtitleText: 'Recommended'),
//                       PopularCard()
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: BottomNavigationBar(items: items),
//     );
//   }
// }
