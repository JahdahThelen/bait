import 'package:meticulo/model/rated_results.dart';

import '../model/result.dart';

abstract class AbstractStorage {
  Future<void> updateMarkedResults(List<Result> results);

  Future<void> updateRatedResults(RatedResults results);

  Future<List<Result>> readMarkedResults();

  Future<RatedResults> readRatedResults();
}
