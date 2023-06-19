import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;
  final void Function()? onTap;

  const MenuListTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.trailingIcon = Icons.chevron_right_rounded,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 56.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    leadingIcon,
                    size: 24.0,
                    color: onTap == null
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: onTap == null
                                ? Theme.of(context).colorScheme.onSurfaceVariant
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(
                    trailingIcon,
                    size: 24.0,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          thickness: 1.0,
          height: 8.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
      ],
    );
  }
}
