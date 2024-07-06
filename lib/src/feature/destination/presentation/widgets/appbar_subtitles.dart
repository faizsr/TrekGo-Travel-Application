import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

// =============== Appbar subtitle with stream ===============

class AppbarSubtitlesStream extends StatefulWidget {
  final String? userId;
  final String? subtitleText;
  final double? subtitleSize;
  final Color? subtitleColor;
  const AppbarSubtitlesStream({
    super.key,
    this.userId,
    this.subtitleText,
    this.subtitleSize,
    this.subtitleColor,
  });

  @override
  State<AppbarSubtitlesStream> createState() => _AppbarSubtitlesStreamState();
}

class _AppbarSubtitlesStreamState extends State<AppbarSubtitlesStream> {
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final userDataSnapshot =
              snapshot.data!.data() as Map<String, dynamic>;
          String fullname =
              (userDataSnapshot['fullname'] as String).capitalise();
          return Row(
            children: [
              Text(
                'Hello $fullname',
                style: TextStyle(
                  fontSize: widget.subtitleSize,
                  fontWeight: FontWeight.w600,
                  color: widget.subtitleColor,
                ),
              ),
              Icon(
                MdiIcons.humanGreeting,
                size: 18,
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}

// =============== Appbar subtitle without stream ===============

class AppbarSubtitles extends StatefulWidget {
  final String? subtitleText;
  final double? subtitleSize;
  final Color? subtitleColor;
  const AppbarSubtitles({
    super.key,
    this.subtitleText,
    this.subtitleSize,
    this.subtitleColor,
  });

  @override
  State<AppbarSubtitles> createState() => _AppbarSubtitlesState();
}

class _AppbarSubtitlesState extends State<AppbarSubtitles> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.subtitleText ?? '',
      style: TextStyle(
        fontSize: widget.subtitleSize,
        fontWeight: FontWeight.w600,
        color: widget.subtitleColor,
      ),
    );
  }
}



// =============== Appbar Subtitle ===============

class MainSubtitles extends StatelessWidget {
  final String subtitleText;
  final Function()? viewAllPlaces;
  const MainSubtitles({
    super.key,
    required this.subtitleText,
    this.viewAllPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        top: MediaQuery.of(context).size.height * 0.015,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtitleText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF1285b9),
            ),
          ),
          GestureDetector(
            onTap: viewAllPlaces,
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 11,
                color: Color(0x66000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
