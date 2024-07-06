import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';

class AuthLayoutBuilder extends StatelessWidget {
  final Widget child;

  const AuthLayoutBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
