import 'package:flutter/material.dart';

import '../widget/buttons.dart';
import '../widget/icons.dart';

class RatingIconRow extends StatelessWidget {
  final int rating;

  const RatingIconRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++) CustomIcon.rating(selected: i < rating)
      ],
    );
  }
}

class RatingButtonRow extends StatelessWidget {
  final int rating;
  final void Function(int newRating) onPressed;

  const RatingButtonRow(
      {super.key, required this.rating, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (var i = 0; i < 5; i++)
        CustomIconButton.rating(
          selected: i < rating,
          onPressed: () => onPressed(i + 1),
        )
    ]);
  }
}
