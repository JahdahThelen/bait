import 'package:flutter/material.dart';

import 'icons.dart';

class SimpleSearchBar extends StatelessWidget {
  final String hintText = "Search for a movie...";

  final void Function(String)? onSearch;

  const SimpleSearchBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    hintText: hintText,
                    onSubmitted: onSearch,
                    leading: const Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomIcon.search(),
                    ),
                  );
                },
                suggestionsBuilder: (_, __) => []),
          ),
        ],
      ),
    );
  }
}
