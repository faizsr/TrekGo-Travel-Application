import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/model/saved.dart';
import 'package:trekgo_project/changer/provider/saved_provider.dart';

class SavedIcon extends StatefulWidget {
  final bool biggerIcon;
  final String? id;
  final String? userId;
  final String? image;
  final String? name;
  final double? rating;
  final String? description;
  final String? location;
  final bool disableOnPressed;
  const SavedIcon({
    super.key,
    this.biggerIcon = false,
    this.id,
    this.userId,
    this.image,
    this.name,
    this.rating,
    this.description,
    this.location,
    this.disableOnPressed = false,
  });

  @override
  State<SavedIcon> createState() => _SavedIconState();
}

class _SavedIconState extends State<SavedIcon> {
  late Box<Saved> savedBox;
  late List<String> savedid;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    debugPrint('id on saving from home: ${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    var savedProvider = Provider.of<SavedProvider>(context);
    return GestureDetector(
      onTap: widget.disableOnPressed == false
          ? () async {
              if (!savedProvider.savedIds.contains(widget.id)) {
                // ============ Adding the data to the Saved ============
                String uniqueKey = widget.id ?? '';
                DateTime dateTime = DateTime.now();
                await savedBox.put(
                    uniqueKey,
                    Saved(
                      userId: widget.userId,
                      firebaseid: widget.id,
                      image: widget.image,
                      name: widget.name,
                      rating: widget.rating,
                      description: widget.description,
                      location: widget.location,
                      dateTime: dateTime,
                    ));
                savedProvider.updateSavedIds(
                    savedProvider.savedIds..add(widget.id ?? ''));
                debugPrint('Added successfully at placeId = ${widget.id}');
                // debugPrint('user id on saving ${widget.userId}');
              } else {
                int index = savedProvider.savedIds.indexOf(widget.id ?? '');
                savedBox.deleteAt(index);
                savedProvider
                    .updateSavedIds(savedProvider.savedIds..remove(widget.id));
                debugPrint('Deleted successfully at placeId = ${widget.id}');
                savedBox.compact();
              }
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.090,
        height: MediaQuery.of(context).size.height * 0.045,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0x0D000000),
            )
          ],
        ),
        child: savedProvider.isExist(widget.id ?? '')
            ? Icon(
                Icons.bookmark_rounded,
                size: widget.biggerIcon
                    ? MediaQuery.of(context).size.width / 10
                    : MediaQuery.of(context).size.width / 14,
                color: const Color(0xFF1285b9),
              )
            : Icon(
                Icons.bookmark_outline,
                size: widget.biggerIcon
                    ? MediaQuery.of(context).size.width / 10
                    : MediaQuery.of(context).size.width / 14,
                color: const Color(0xFF1285b9),
              ),
      ),
    );
  }
}
