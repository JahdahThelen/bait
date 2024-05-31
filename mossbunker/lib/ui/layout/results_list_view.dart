import 'package:flutter/material.dart';

import '../../model/result.dart';
import '../widget/icons.dart';
import 'rating_rows.dart';

class ResultsListView extends StatelessWidget {
  final List<ResultListDTO> results;
  final void Function(ResultListDTO) onSave;
  final void Function(ResultListDTO) onRate;

  const ResultsListView(
      {super.key,
      required this.results,
      required this.onSave,
      required this.onRate});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      itemBuilder: (context, index) {
        ResultListDTO item = results[index];
        return ListTile(
          title: Text(item.result.title),
          onTap: () => onSave(item),
          onLongPress: () => onRate(item),
          leading: item.isMarked
              ? const CustomIcon.marked()
              : const CustomIcon.empty(),
          subtitle: item.rating > 0 ? RatingIconRow(rating: item.rating) : null,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: results.length,
      shrinkWrap: true,
    );
  }
}

class ResultListDTO {
  final Result result;
  final bool isMarked;
  final int rating;

  ResultListDTO(
      {required this.result, required this.isMarked, required this.rating});
}
