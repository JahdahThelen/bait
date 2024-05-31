import 'package:flutter/material.dart';
import 'package:meticulo/api/imdb_api_client.dart';
import 'package:meticulo/provider/imdb_provider.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:meticulo/storage/abstract_storage.dart';
import 'package:meticulo/storage/local_file_storage.dart';
import 'package:meticulo/ui/page/search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<AbstractStorage>(
          future: LocalFileStorage.setup("imdb"),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const SizedBox.shrink();
              case ConnectionState.done:
                return ChangeNotifierProvider<ResultProvider>(
                    create: (_) => ImdbProvider(snapshot.data, ImdbApiClient()),
                    builder: (context, _) {
                      return const SearchPage();
                    });
            }
          }),
    );
  }
}
