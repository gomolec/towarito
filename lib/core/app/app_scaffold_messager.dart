import 'package:flutter/material.dart';

class AppScaffoldMessager {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackbar({
    required String message,
    String? actionLabel,
    void Function()? actionFunction,
  }) {
    if (rootScaffoldMessengerKey.currentState == null ||
        rootScaffoldMessengerKey.currentContext == null) {
      return;
    }
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        elevation: 3.0,
        // backgroundColor: Theme.of(rootScaffoldMessengerKey.currentContext!)
        //     .colorScheme
        //     .inverseSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          top: 24.0,
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
        ),
        content: Text(message),
        action: actionFunction != null
            ? SnackBarAction(
                label: actionLabel ?? 'Akcja',
                onPressed: actionFunction,
              )
            : null,
      ),
    );
  }
}
