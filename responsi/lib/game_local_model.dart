import 'package:hive/hive.dart';

part 'game_local_model.g.dart'; 

@HiveType(typeId: 0)
class GameLocal extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String thumbnail;

  @HiveField(3)
  String genre;

  @HiveField(4)
  String platform;

  GameLocal({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
  });
}