

import '../../models/post.dart';
import 'local_posts_data_source.dart';

class FakeLocalPostsDataSource extends LocalPostsDataSource {
  final List<Post> _localPosts = [];

  @override
  Future<List<Post>> getAllPosts() async {
    return _localPosts;
  }

  @override
  Future<void> savePosts(List<Post> posts) async {
    _localPosts.clear();
    _localPosts.addAll(posts);
  }

  @override
  Future<Post> createPost(Post post) async {
    _localPosts.add(post);
    return post;
  }

  @override
  Future<void> deletePost(Post post) async {
    _localPosts.removeWhere((p) => p.id == post.id);
  }

  @override
  Future<Post> updatePost(Post post) async {
    final index = _localPosts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _localPosts[index] = post;
      return post;
    } else {
      throw Exception("Post not found");
    }
  }
}
