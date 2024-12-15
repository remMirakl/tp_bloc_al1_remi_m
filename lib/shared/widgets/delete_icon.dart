import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/posts_bloc/posts_bloc.dart';
import '../models/post.dart';

class DeleteIcon extends StatelessWidget {
  final Post post;

  const DeleteIcon({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      tooltip: "Supprimer",
      onPressed: () async {
        final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmer la suppression"),
              content: const Text("Êtes-vous sûr de vouloir supprimer ce post ?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );

        if (shouldDelete == true) {
          context.read<PostsBloc>().add(DeletePost(post));
        }
      },
    );
  }
}
