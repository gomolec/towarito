import 'package:flutter/material.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      elevation: 2.0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 16.0 + MediaQuery.of(context).viewPadding.top,
          bottom: 24.0,
        ),
        child: Column(
          children: [
            Container(
              height: 96.0,
              width: 96.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.face,
                size: 56.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Sebastian Gomolec",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Text(
              "Sklep magazyn",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
