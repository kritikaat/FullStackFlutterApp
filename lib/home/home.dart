import 'package:flutter/material.dart';
import 'package:internapp/bottom_Navigation/bottomNavigation.dart';
import 'package:internapp/user_profile.dart/user_profile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Good App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              );
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: BottomNavigationBarExample()),
          ],
        ),
      ),
    );
  }
}

 