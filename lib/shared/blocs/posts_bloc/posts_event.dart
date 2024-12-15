part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {
  const PostsEvent();
}

class GetAllPosts extends PostsEvent {
  const GetAllPosts();
}

class CreatePost extends PostsEvent {
  final Post postToAdd;

  const CreatePost(this.postToAdd);
}

class UpdatePost extends PostsEvent {
  final Post newPost;

  const UpdatePost(this.newPost);
}

class DeletePost extends PostsEvent {
  final Post post;

  const DeletePost(this.post);
}



