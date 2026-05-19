import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'library_controller.dart';
import 'detail_page.dart';

class LibraryPage extends StatelessWidget {
  final LibraryController libCtrl = Get.find();

  LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Anda')),
      body: Obx(() {
        if (libCtrl.savedGames.isEmpty) {
          return const Center(child: Text('Belum ada game di Library'));
        }
        return ListView.builder(
          itemCount: libCtrl.savedGames.length,
          itemBuilder: (context, index) {
            final game = libCtrl.savedGames[index];
            return ListTile(
              leading: Image.network(game.thumbnail, width: 80, fit: BoxFit.cover),
              title: Text(game.title),
              subtitle: Text('${game.genre} • ${game.platform}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => libCtrl.removeGame(game.id),
              ),
              onTap: () => Get.to(() => DetailPage(gameId: game.id)),
            );
          },
        );
      }),
    );
  }
}