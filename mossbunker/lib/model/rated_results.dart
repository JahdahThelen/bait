import 'package:meticulo/model/result.dart';

class RatedResults {
  Map<Result, int> ratedResults;

  RatedResults(this.ratedResults);

  RatedResults.empty() : ratedResults = {};

  RatedResults.fromJson(List<dynamic> items)
      : ratedResults = {
          for (var item in items) Result.fromJson(item): item["rating"] as int
        };

  List<dynamic> toJson() {
    return ratedResults.entries
        .map((entry) => {
              'title': entry.key.title,
              'id': entry.key.id,
              'rating': entry.value
            })
        .toList();
  }

  int? operator [](Result r) => ratedResults[r];

  int update(Result key, int Function(int) update, {int Function()? ifAbsent}) {
    return ratedResults.update(key, update, ifAbsent: ifAbsent);
  }

  Iterable<MapEntry<Result, int>> get entries => ratedResults.entries;
}
