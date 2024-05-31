import 'dart:convert';
import 'dart:io';

import 'package:meticulo/model/rated_results.dart';
import 'package:path_provider/path_provider.dart';

import '../model/result.dart';
import 'abstract_storage.dart';

class LocalFileStorage extends AbstractStorage {
  final Directory _directory;

  LocalFileStorage(this._directory);

  static Future<LocalFileStorage> setup(String folder) async {
    Directory dir = await getApplicationDocumentsDirectory();
    var newDir = await Directory('${dir.path}/$folder').create(recursive: true);
    return LocalFileStorage(newDir);
  }

  Future<File> get _markedResultsFile async {
    File file = File('${_directory.path}/marked.txt');
    if (await file.exists()) return file;
    return await file.create();
  }

  Future<File> get _ratedResultsFile async {
    File file = File('${_directory.path}/rated.txt');
    if (await file.exists()) return file;
    return await file.create();
  }

  @override
  Future<void> updateMarkedResults(List<Result> results) async {
    final file = await _markedResultsFile;
    String content =
        jsonEncode(results.map((result) => result.toJson()).toList());
    file.writeAsString(content);
  }

  @override
  Future<void> updateRatedResults(RatedResults results) async {
    final file = await _ratedResultsFile;
    String content = jsonEncode(results);
    file.writeAsString(content);
  }

  @override
  Future<List<Result>> readMarkedResults() async {
    final file = await _markedResultsFile;

    String contents = await file.readAsString();
    final List<Result> results = [];
    if (contents.isEmpty) return results;
    final items = jsonDecode(contents) as List<dynamic>;
    for (var item in items) {
      results.add(Result.fromJson(item));
    }
    return results;
  }

  @override
  Future<RatedResults> readRatedResults() async {
    final file = await _ratedResultsFile;
    String contents = await file.readAsString();
    if (contents.isEmpty) return RatedResults.empty();
    var items = jsonDecode(contents) as List<dynamic>;
    return RatedResults.fromJson(items);
  }
}
