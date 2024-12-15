class Post {
  final int id;
  final String title;
  final String description;

  const Post({
    required this.id,
    required this.title,
    required this.description,
  });

  Post copyWith({String? title, String? description}) {
    return Post(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
