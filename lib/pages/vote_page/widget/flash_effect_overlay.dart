import 'package:flutter/material.dart';

class FlashEffectOverlay extends StatelessWidget {
  const FlashEffectOverlay({
    super.key,
    required this.showFlash,
    required this.flashColor,
    required this.flashAlignment,
  });

  final bool showFlash;
  final Color flashColor;
  final Alignment flashAlignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showFlash ? 0.7 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        alignment: flashAlignment,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: flashAlignment == Alignment.centerLeft
                  ? [
                      flashColor.withValues(alpha: 0.7),
                      flashColor.withValues(alpha: 0.0),
                    ]
                  : [
                      flashColor.withValues(alpha: 0.0),
                      flashColor.withValues(alpha: 0.7),
                    ],
              stops: const [0.0, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: flashAlignment == Alignment.centerLeft
                ? const BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
          ),
        ),
      ),
    );
  }
}
