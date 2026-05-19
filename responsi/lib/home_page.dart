import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_service.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Game')),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.fetchGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final games = snapshot.data!;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                leading: Image.network(game['thumbnail'], width: 80, fit: BoxFit.cover),
                title: Text(game['title']),
                subtitle: Text('${game['genre']} • ${game['platform']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Get.to(() => DetailPage(gameId: game['id'])),
              );
            },
          );
        },
      ),
    );
  }
}