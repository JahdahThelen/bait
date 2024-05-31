import 'package:mossbunker/model/rated_results.dart';
import 'package:mossbunker/provider/result_provider.dart';
import 'package:mossbunker/storage/abstract_storage.dart';

import '../api/api_client.dart';
import '../model/result.dart';
import '../ui/layout/results_list_view.dart';

enum ResultsType { searched, marked, rated }

class ImdbProvider extends ResultProvider {
  ResultsType _resultsType = ResultsType.marked;
  final AbstractStorage? _storage;
  final ApiClient _api;
  List<Result> _searchResults = [];
  List<Result> _markedResults = [];
  RatedResults _ratedResults = RatedResults.empty();

  ImdbProvider(this._storage, this._api) {
    loadData();
  }

  Future<void> loadData() async {
    if (_storage == null) return;
    _markedResults = await _storage!.readMarkedResults();
    _ratedResults = await _storage!.readRatedResults();
    notifyListeners();
  }

  @override
  List<ResultListDTO> get results {
    switch (_resultsType) {
      case ResultsType.searched:
        return searchResults;
      case ResultsType.marked:
        return markedResults;
      case ResultsType.rated:
        return ratedResults;
    }
  }

  List<ResultListDTO> get searchResults => _searchResults
      .map((result) => ResultListDTO(
          result: result,
          isMarked: _markedResults.contains(result),
          rating: _ratedResults[result] ?? 0))
      .toList(growable: false);

  List<ResultListDTO> get markedResults => _markedResults
      .map((result) => ResultListDTO(
          result: result, isMarked: true, rating: _ratedResults[result] ?? 0))
      .toList(growable: false);

  List<ResultListDTO> get ratedResults => _ratedResults.entries
      .map((entry) => ResultListDTO(
          result: entry.key,
          isMarked: _markedResults.contains(entry.key),
          rating: entry.value))
      .toList(growable: false);

  @override
  Future<void> search(String expression) async {
    if (expression.isEmpty) {
      _resultsType = ResultsType.marked;
      notifyListeners();
      return;
    }
    _resultsType = ResultsType.searched;
    List<Result> newResult = await _api.search(expression);
    _searchResults = newResult;
    notifyListeners();
  }

  @override
  void save(ResultListDTO item) {
    Result result = item.result;
    if (_markedResults.contains(result)) {
      _markedResults.remove(result);
    } else {
      _markedResults.add(result);
    }
    _saveMarkedToStorage();
    notifyListeners();
  }

  void _saveMarkedToStorage() {
    if (_storage == null) return;
    _storage!.updateMarkedResults(_markedResults);
  }

  @override
  void rate(ResultListDTO item, int newRating) {
    _ratedResults.update(
      item.result,
      (rating) => rating = newRating,
      ifAbsent: () => newRating,
    );
    _saveRatedToStorage();
    notifyListeners();
  }

  void _saveRatedToStorage() {
    if (_storage == null) return;
    _storage!.updateRatedResults(_ratedResults);
  }
}
