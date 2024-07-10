import 'package:flutter/material.dart';
import 'package:internapp/Model/Post.dart';

class PostListView extends StatelessWidget {
  final Future<List<Post>> futurePosts;

  PostListView({required this.futurePosts});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No posts found');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Post post = snapshot.data![index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
              );
            },
          );
        }
      },
    );
  }
}
