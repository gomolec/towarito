import 'dart:developer';

import 'package:flutter/material.dart';

class ProductLinkButton extends StatelessWidget {
  final String? url;

  const ProductLinkButton({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return const SizedBox.shrink();
    }
    return Center(
      child: TextButton.icon(
        onPressed: () {
          log(url.toString());
        },
        icon: const Icon(Icons.link_rounded),
        label: const Text("Strona internetowa produktu"),
      ),
    );
  }
}
