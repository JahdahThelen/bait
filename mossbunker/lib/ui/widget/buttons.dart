import 'package:flutter/material.dart';

import 'icons.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;

  const CustomIconButton({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) =>
      IconButton(icon: icon, onPressed: onPressed);

  const CustomIconButton.cancel({super.key, this.onPressed})
      : icon = const CustomIcon.cancel();

  const CustomIconButton.confirm({super.key, this.onPressed})
      : icon = const CustomIcon.confirm();

  CustomIconButton.rating({super.key, required bool selected, this.onPressed})
      : icon = CustomIcon.rating(selected: selected);
}
