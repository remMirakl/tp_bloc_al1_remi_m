import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_bloc_al1_remi_m/post_creation_screen/post_creation_screen.dart';
import 'package:tp_bloc_al1_remi_m/posts_screen/post_list_item.dart';

import 'package:tp_bloc_al1_remi_m/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:tp_bloc_al1_remi_m/shared/models/post.dart';

import '../AppException.dart';
import '../post_detail_screen/post_detail_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        switch (state.status) {
          case PostsStatus.postCreated:
            _showSuccessSnackBar(context, 'Post créé avec succès');
            break;
          case PostsStatus.postUpdated:
            _showSuccessSnackBar(context, 'Post modifié avec succès');
            break;
          case PostsStatus.postDeleted:
            _showSuccessSnackBar(context, 'Post supprimé avec succès');
            break;
          case PostsStatus.postCreationError:
            _showErrorSnackBar(context, state.exception);
            break;
          case PostsStatus.postUpdateError:
            _showErrorSnackBar(context, state.exception);
            break;
          case PostsStatus.postDeletionError:
            _showErrorSnackBar(context, state.exception);
            break;
          case PostsStatus.error:
            _showErrorSnackBar(context, state.exception);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: const Text(
              'Réseau social',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.indigoAccent,
          ),
          body: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              return switch (state.status) {
                PostsStatus.initial || PostsStatus.loading => _buildLoading(context),
                PostsStatus.error => _buildError(context, state.exception),
                PostsStatus.empty => _buildEmpty(context),
                PostsStatus.success => _buildSuccess(context, state.posts),
                PostsStatus.addingPost => _buildLoading(context),
                PostsStatus.postCreated => _buildSuccess(context, state.posts),
                PostsStatus.updatingPost => _buildLoading(context),
                PostsStatus.postUpdated => _buildSuccess(context, state.posts),
                PostsStatus.deletingPost => _buildLoading(context),
                PostsStatus.postDeleted => _buildSuccess(context, state.posts),
                PostsStatus.postCreationError => _buildError(context, state.exception),
                PostsStatus.postUpdateError => _buildError(context, state.exception),
                PostsStatus.postDeletionError => _buildError(context, state.exception),
              };
            },
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.indigoAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostCreationScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    return Center(
      child: Text(
        'Oups, une erreur est survenur: $exception',
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return const Center(
      child: Text(
        'Aucun post à afficher',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> posts) {
    return RefreshIndicator(
      onRefresh: () async => _getAllPosts(),
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostListItem(
            post: post,
            onTap: () => _openPostDetailScreen(context, post),
          );
        },
      ),
    );
  }

  void _openPostDetailScreen(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  void _getAllPosts() {
    context.read<PostsBloc>().add(const GetAllPosts());
  }

  void _showErrorSnackBar(BuildContext context, AppException? exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Erreur : $exception',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
