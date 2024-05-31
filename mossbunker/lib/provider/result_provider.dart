import 'package:flutter/material.dart';

import '../ui/layout/results_list_view.dart';

abstract class ResultProvider extends ChangeNotifier {
  List<ResultListDTO> get results;

  Future<void> search(String expression);

  void save(ResultListDTO item);

  void rate(ResultListDTO item, int newRating);
}
