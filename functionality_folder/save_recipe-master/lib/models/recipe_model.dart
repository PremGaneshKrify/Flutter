import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

// TODO: Poll said remove g files from Git Repo

@HiveType(typeId: 1)
class RecipeModel extends HiveObject {
  RecipeModel(this.name, this.image, {required this.id, this.isFavorite = false});
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  Uint8List image;

  @HiveField(3)
  bool isFavorite;
}
