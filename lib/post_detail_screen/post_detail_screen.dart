import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_bloc_al1_remi_m/shared/models/post.dart';
import 'package:tp_bloc_al1_remi_m/shared/widgets/delete_icon.dart';

import '../shared/blocs/posts_bloc/posts_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, 'postDetail', arguments: post);
  }

  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updatePost() {
    final updatedPost = widget.post.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<PostsBloc>().add(UpdatePost(updatedPost));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state.status == PostsStatus.postDeletionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.exception.toString())),
          );
        }
        if (state.status == PostsStatus.postDeleted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text(
            'Détails du post',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.indigoAccent,
          actions: [
            DeleteIcon(post: widget.post),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.indigoAccent),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: _updatePost,
                  child: const Text('Modifier le post', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
