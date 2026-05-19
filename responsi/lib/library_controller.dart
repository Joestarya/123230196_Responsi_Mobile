import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'game_local_model.dart';

class LibraryController extends GetxController {
  late Box<GameLocal> libraryBox;
  var savedGames = <GameLocal>[].obs;

  @override
  void onInit() {
    super.onInit();
    libraryBox = Hive.box<GameLocal>('libraryBox');
    loadLibrary();
  }

  void loadLibrary() {
    savedGames.value = libraryBox.values.toList();
  }

  bool isGameOwned(int id) {
    return libraryBox.values.any((game) => game.id == id);
  }

  void addGame(GameLocal game) {
    libraryBox.add(game);
    loadLibrary();
  }

  void removeGame(int id) {
    final gameToRemove = libraryBox.values.firstWhere((game) => game.id == id);
    gameToRemove.delete(); 
    loadLibrary();
  }
}