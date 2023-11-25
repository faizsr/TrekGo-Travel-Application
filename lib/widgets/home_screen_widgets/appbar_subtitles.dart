import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/service/database_service.dart';

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

extension MyExtension on String {
  String capitalise() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
