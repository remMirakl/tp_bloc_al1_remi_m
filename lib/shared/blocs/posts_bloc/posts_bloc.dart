import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../AppException.dart';
import '../../models/post.dart';
import '../../services/posts_repository/posts_repository.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {

    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        final products = await postsRepository.getAllPosts();
        if(products.isEmpty) {
          emit(state.copyWith(
            status: PostsStatus.empty,
          ));
          return;
        }
        emit(state.copyWith(
          posts: products,
          status: PostsStatus.success,
        ));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: appException,
        ));
      }
    });

    on<CreatePost>((event, emit) async {
      final post = event.postToAdd;
      emit(state.copyWith(status: PostsStatus.addingPost));

      try {
        final newPost = await postsRepository.createPost(post);
        emit(state.copyWith(
          posts: [...state.posts, newPost],
          status: PostsStatus.postCreated,
        ));
        add(const GetAllPosts());
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostsStatus.postCreationError,
          exception: appException,
        ));
        add(const GetAllPosts());
      }
    });

    on<UpdatePost>((event, emit) async {
      final post = event.newPost;
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        final updatedPost = await postsRepository.updatePost(post);
        final updatedPosts = state.posts.map((p) => p.id == updatedPost.id ? updatedPost : p).toList();
        emit(state.copyWith(
          posts: updatedPosts,
          status: PostsStatus.postUpdated,
        ));
        add(const GetAllPosts());
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostsStatus.postUpdateError,
          exception: appException,
        ));
        add(const GetAllPosts());
      }
    });

    on<DeletePost>((event, emit) async {
      final post = event.post;
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        await postsRepository.deletePost(post);
        final updatedPosts = state.posts.where((p) => p.id != post.id).toList();
        emit(state.copyWith(
          posts: updatedPosts,
          status: PostsStatus.postDeleted,
        ));
        add(const GetAllPosts());
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostsStatus.postDeletionError,
          exception: appException,
        ));
        add(const GetAllPosts());
      }
    });
  }
}
