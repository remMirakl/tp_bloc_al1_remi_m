import 'package:tp_bloc_al1_remi_m/shared/services/posts_data_source/posts_data_source.dart';

import '../../models/post.dart';

class FakePostsDataSource extends PostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: 1, title: 'Post de fou', description: 'Description de fou'),
    Post(id: 2, title: 'Post de dingo', description: 'Description de dingo'),
    Post(id: 3, title: 'Post de malade', description: 'Description de malade'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == newPost.id);
    _fakePosts[index] = newPost;
    return newPost;
  }

  @override
  Future<void> savePosts(List<Post> posts) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.addAll(posts);
  }

  @override
  Future<void> deletePost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.removeWhere((element) => element.id == post.id);
  }
}
