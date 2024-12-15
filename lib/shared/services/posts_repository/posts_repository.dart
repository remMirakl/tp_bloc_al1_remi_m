import 'package:tp_bloc_al1_remi_m/shared/services/local_posts_data_source/local_posts_data_source.dart';
import 'package:tp_bloc_al1_remi_m/shared/services/posts_data_source/posts_data_source.dart';

import '../../models/post.dart';

class PostsRepository {
  final PostsDataSource remoteDataSource;
  final LocalPostsDataSource localProductsDataSource;

  PostsRepository({
    required this.remoteDataSource,
    required this.localProductsDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    try {
      final posts = await remoteDataSource.getAllPosts();
      localProductsDataSource.savePosts(posts);
      return posts;
    } catch (error) {
      return localProductsDataSource.getAllPosts();
    }
  }

  Future<Post> createPost(Post post) async {
    final newPost = await remoteDataSource.createPost(post);
    localProductsDataSource.createPost(newPost);
    return newPost;
  }

  Future<Post> updatePost(Post post) async {
    final updatedPost = await remoteDataSource.updatePost(post);
    localProductsDataSource.updatePost(updatedPost);
    return updatedPost;
  }

  Future<void> deletePost(Post post) async {
    await remoteDataSource.deletePost(post);
    localProductsDataSource.deletePost(post);
  }

}
