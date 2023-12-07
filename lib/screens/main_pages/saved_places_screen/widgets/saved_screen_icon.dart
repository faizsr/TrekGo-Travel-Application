import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/provider/saved_provider.dart';
// import 'package:trekmate_project/widgets/saved_provider.dart';

class SavedScreenIcon extends StatefulWidget {
  final int? index;
  final bool biggerIcon;
  final String? id;
  final String? image;
  final String? name;
  final double? rating;
  final String? description;
  final String? location;
  const SavedScreenIcon({
    super.key,
    this.index,
    this.biggerIcon = false,
    this.id,
    this.image,
    this.name,
    this.rating,
    this.description,
    this.location,
  });

  @override
  State<SavedScreenIcon> createState() => _SavedScreenIconState();
}

class _SavedScreenIconState extends State<SavedScreenIcon> {
  late Box<Saved> savedBox;
  late List<String> savedid;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    debugPrint('id: ${widget.id}');
    debugPrint('name: ${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    var savedProvider = Provider.of<SavedProvider>(context);
    return GestureDetector(
      onTap: () async {
        if (savedProvider.savedIds.contains(widget.id)) {
          debugPrint('Contains firebase id in hive');
          savedBox.delete(widget.id ?? '');
          savedProvider.updateSavedIds(
            savedProvider.savedIds..remove(widget.id),
          );
          debugPrint('Deleted successfully ${widget.id}');
          savedBox.compact();
        }
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
          child: Icon(
            Icons.bookmark_rounded,
            size: widget.biggerIcon
                ? MediaQuery.of(context).size.width / 10
                : MediaQuery.of(context).size.width / 14,
            color: const Color(0xFF1285b9),
          )),
    );
  }
}
