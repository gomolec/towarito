import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../bloc/scanner_bloc.dart';

class ScannerAnimation extends StatefulWidget {
  const ScannerAnimation({
    super.key,
  });

  @override
  State<ScannerAnimation> createState() => _ScannerAnimationState();
}

class _ScannerAnimationState extends State<ScannerAnimation> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = SimpleAnimation(
      'loop',
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        setState(() {
          _controller.isActive = state.status == ScannerStatus.scanning;
        });
        log(_controller.isActive.toString());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: RiveAnimation.asset(
          'assets/scanner_animation.riv',
          controllers: [_controller],
          onInit: (_) => setState(() {}),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
