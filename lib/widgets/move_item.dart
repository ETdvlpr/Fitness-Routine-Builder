import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/move.dart';

class MoveItem extends StatelessWidget {
  final Move move;

  const MoveItem({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: move.imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.fitness_center,
          size: 40,
        ),
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
      title: Text(move.name),
      subtitle: Text(
          'Muscle Group: ${move.muscleGroup}, Spring Load: ${move.springLoad}'),
    );
  }
}
