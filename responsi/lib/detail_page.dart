import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_service.dart';
import 'library_controller.dart';
import 'game_local_model.dart';

class DetailPage extends StatelessWidget {
  final int gameId;
  final LibraryController libCtrl = Get.find();

  DetailPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.fetchGameDetail(gameId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Data'));
          }

          final game = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: game['id'],
                  child: Image.network(game['thumbnail'], width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${game['genre']} • ${game['platform']}', style: const TextStyle(color: Colors.grey)),
                      Text(game['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('${game['release_date']} • ${game['publisher']} • ${game['developer']}'),
                      const SizedBox(height: 16),
                      Obx(() {
                        final isOwned = libCtrl.isGameOwned(gameId);
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isOwned ? Colors.grey : Colors.blue,
                            ),
                            onPressed: () {
                              if (!isOwned) {
                                libCtrl.addGame(GameLocal(
                                  id: game['id'],
                                  title: game['title'],
                                  thumbnail: game['thumbnail'],
                                  genre: game['genre'],
                                  platform: game['platform'],
                                ));
                              }
                            },
                            child: Text(isOwned ? '✓ In Library' : '+ Get'),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      const Text('Screenshots', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: game['screenshots']?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.network(game['screenshots'][index]['image']),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(game['description']),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}