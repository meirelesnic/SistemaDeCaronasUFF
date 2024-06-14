import 'package:flutter/material.dart';

class Estrelas extends StatelessWidget {
  final int rating; // Número de estrelas preenchidas
  final int maxRating; // Número máximo de estrelas

  Estrelas({
    required this.rating,
    this.maxRating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double iconSize = constraints.maxWidth / maxRating;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(maxRating, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Theme.of(context).colorScheme.primary,
              size: iconSize,
            );
          }),
        );
      },
    );
  }
}

