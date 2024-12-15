

import '../../models/post.dart';
import '../posts_data_source/posts_data_source.dart';

abstract class LocalPostsDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts();

  @override
  Future<void> savePosts(List<Post> posts);

  @override
  Future<Post>createPost(Post postToAdd);

  @override
  Future<void>deletePost(Post post);

  @override
  Future<Post>updatePost(Post newPost);

}