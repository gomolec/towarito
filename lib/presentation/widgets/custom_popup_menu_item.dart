import 'package:flutter/material.dart';

class CustomPopupMenuItem extends StatefulWidget implements PopupMenuEntry {
  final String title;
  final IconData iconData;
  final void Function() onTap;

  const CustomPopupMenuItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomPopupMenuItem> createState() => _CustomPopupMenuItemState();

  @override
  double get height => throw UnimplementedError();

  @override
  bool represents(value) {
    throw UnimplementedError();
  }
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      onTap: widget.onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.iconData,
              size: 24.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
