import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp_bloc_al1_remi_m/shared/widgets/delete_icon.dart';

import '../shared/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
    required this.post,
    this.onTap,
  });

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[200],
      shadowColor: Colors.blueAccent,
      elevation: 7,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigoAccent,
          child: Text(post.title[0].toString().toUpperCase()),
        ),
        title: Text(
          post.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          post.description,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
        trailing: DeleteIcon(post: post),
      ),
    );
  }
}
