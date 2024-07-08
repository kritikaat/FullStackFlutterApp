import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internapp/bottom_Navigation/bottomNavigation.dart';
import 'package:internapp/user_profile.dart/user_profile.dart';
//import 'package:internapp/services/auth_service.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                   'Hello👋',
//                   style: GoogleFonts.raleway(
//                     textStyle: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20
//                     )
//                   ),
//                 ),
//                 const SizedBox(height: 10,),
//                 Text(
//                   FirebaseAuth.instance.currentUser!.email!.toString(),
//                   style: GoogleFonts.raleway(
//                     textStyle: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20
//                     )
//                   ),
//                 ),
//                  const SizedBox(height: 30,),
//                 _logout(context)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

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
            Text(
              'Hello👋',
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!.toString(),
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Expanded(child: BottomNavigationBarExample()),
          ],
        ),
      ),
    );
  }
}

  // Widget _logout(BuildContext context) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: const Color(0xff0D6EFD),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       minimumSize: const Size(double.infinity, 60),
  //       elevation: 0,
  //     ),
  //     onPressed: () async {
  //       await AuthService().signout(context: context);
  //     },
  //     child: const Text("Sign Out"),
  //   );
  // }