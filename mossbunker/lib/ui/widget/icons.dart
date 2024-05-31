import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Icon icon;

  const CustomIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) => icon;

  const CustomIcon.empty({super.key})
      : icon = const Icon(Icons.cancel_outlined, color: Colors.transparent);

  const CustomIcon.cancel({super.key})
      : icon = const Icon(Icons.cancel_outlined, size: 40);

  const CustomIcon.confirm({super.key})
      : icon = const Icon(Icons.check_circle_outline, size: 40);

  const CustomIcon.rating({super.key, required bool selected})
      : icon =
            selected ? const Icon(Icons.star) : const Icon(Icons.star_border);

  const CustomIcon.marked({super.key}) : icon = const Icon(Icons.bookmark);

  const CustomIcon.search({super.key}) : icon = const Icon(Icons.search);
}
