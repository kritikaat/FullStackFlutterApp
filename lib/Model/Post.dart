class Post {
  final int userId;
  final String title;
  final String description;

  Post({
    required this.userId,
    required this.title,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json['userId'],
    title: json['title'],
    description: json['body'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'title': title,
    'body': description,
  };
}
