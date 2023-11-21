import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorites extends ChangeNotifier with HiveObjectMixin{
  @HiveField(0)
  final String? state;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? location;

  @HiveField(4)
  final String? image;

  Favorites({
    this.state,
    this.name,
    this.description,
    this.location,
    this.image,
  });
}
