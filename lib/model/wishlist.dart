import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'wishlist.g.dart';

@HiveType(typeId: 0)
class Wishlist extends ChangeNotifier with HiveObjectMixin {
  @HiveField(1)
  final String? hiveKey;

  @HiveField(2)
  final String? userId;

  @HiveField(3)
  final String? state;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final String? location;

  @HiveField(7)
  final String? image;

  Wishlist({
    this.hiveKey,
    this.userId,
    this.state,
    this.name,
    this.description,
    this.location,
    this.image,
  });
}
