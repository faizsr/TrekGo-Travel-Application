import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/saved.dart';

class SavedIcon extends StatefulWidget {
  final bool biggerIcon;
  final String? id;
  final String? image;
  final String? name;
  final double? rating;
  final String? description;
  final String? location;
  const SavedIcon({
    super.key,
    this.biggerIcon = false,
    this.id,
    this.image,
    this.name,
    this.rating,
    this.description,
    this.location,
  });

  @override
  State<SavedIcon> createState() => _SavedIconState();
}

class _SavedIconState extends State<SavedIcon> {
  late Box<Saved> savedBox;
  late List<Saved> savedFidList;
  late List<String> savedid;
  bool iconFill = false;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    savedFidList = savedBox.values.toList();
    updateSavedIdList();
    debugPrint('id: ${widget.id}');
  }

  int getIndex(String? id) {
    return savedFidList.indexWhere((savedItem) => savedItem.firebaseid == id);
  }

  // ============ Update List ============
  void updateSavedIdList() {
    savedid = savedFidList
        .where((savedItem) => savedItem.firebaseid != null)
        .map((savedItem) => savedItem.firebaseid!)
        .toList();
    // debugPrint('saved id list : $savedid');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool newIconFill = !iconFill;

        // debugPrint('firebase id list: $savedid');

        if (newIconFill) {
          if (!savedid.contains(widget.id)) {
            // ============ Adding the data to the Saved ============

            int indexAdd = await savedBox.add(Saved(
              firebaseid: widget.id,
              image: widget.image,
              name: widget.name,
              rating: widget.rating,
              description: widget.description,
              location: widget.location,
            ));
            debugPrint('index add: $indexAdd');
            debugPrint('Added successfully');
          } else {
            int indexDel = getIndex(widget.id);
            debugPrint('index del: $indexDel');
            // ============ Delete the data in the Saved ============
            int index = savedid.indexOf(widget.id ?? '');
            if (index > -1) {
              savedBox.deleteAt(index);
              debugPrint('Deleted successfully');
              savedBox.compact();
            } else {
              debugPrint('No element to delete');
            }
          }
        }

        // ============ Setting the icon back to normal ============
        setState(() {
          iconFill = newIconFill;
        });
        debugPrint('fill state = $iconFill');
      },
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
        child: savedid.contains(widget.id)
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
