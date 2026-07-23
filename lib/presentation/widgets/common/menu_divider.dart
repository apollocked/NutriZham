import 'package:flutter/material.dart';

class MenuDivider extends StatelessWidget {
  final double horizontalPadding;

  const MenuDivider({super.key, this.horizontalPadding = 60});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(
        color: Theme.of(context).colorScheme.outlineVariant,
        height: 1,
      ),
    );
  }
}
