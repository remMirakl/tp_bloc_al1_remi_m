import '../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();
  Future<void> savePosts(List<Post> posts);
  Future<Post> createPost(Post postToAdd);
  Future<void> deletePost(Post post);
  Future<Post> updatePost(Post newPost);

}