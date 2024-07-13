import 'package:flutter/material.dart';
import 'package:internapp/Model/Post.dart';
import 'package:internapp/bottom_Navigation/createpostScreen.dart';
import 'package:internapp/bottom_Navigation/updateScreen.dart';
import 'package:internapp/services/post_service.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  late Future<List<Post>> futurePosts;
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    futurePosts = PostService().fetchPosts();
    futurePosts.then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _fetchPosts();
      }
    });
  }

  Future<void> _navigateToCreatePostScreen() async {
    final createdPost = await Navigator.push<Post>(
      context,
      MaterialPageRoute(builder: (context) => CreatePostScreen()),
    );

    if (createdPost != null) {
      setState(() {
        _posts.insert(0, createdPost);
      });
    }
  }

  Future<void> _navigateToUpdatePostScreen(Post post) async {
    final updatedPost = await Navigator.push<Post>(
      context,
      MaterialPageRoute(builder: (context) => UpdatePostScreen(post: post)),
    );

    if (updatedPost != null) {
      setState(() {
        int index = _posts.indexWhere((p) => p.id == updatedPost.id);
        if (index != -1) {
          _posts[index] = updatedPost;
        }
      });
    }
  }

  Future<void> _deletePost(int id) async {
    try {
      await PostService().deletePost(id);
      setState(() {
        _posts.removeWhere((post) => post.id == id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToCreatePostScreen,
          ),
        ],
      ),
      body: Center(
        child: _selectedIndex == 0
            ? _posts.isEmpty
                ? FutureBuilder<List<Post>>(
                    future: futurePosts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No posts found');
                      } else {
                        _posts = snapshot.data!;
                        return _buildPostList();
                      }
                    },
                  )
                : _buildPostList()
            : _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPostList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        Post post = _posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _navigateToUpdatePostScreen(post),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deletePost(post.id),
              ),
            ],
          ),
        );
      },
    );
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
}
