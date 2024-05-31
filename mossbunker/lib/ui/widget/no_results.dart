import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  final String text = "Nothing to show.";

  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
