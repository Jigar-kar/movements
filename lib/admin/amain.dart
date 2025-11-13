import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moments/admin/acategory.dart';
import 'package:moments/admin/dashboard.dart';
import 'package:moments/admin/order.dart';
// import 'package:moments/pages/navigationBarPages/categoreis.dart';

class Amain extends StatelessWidget {
  const Amain({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyNavbar(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        canvasColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 20, 20, 20)),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 23, 23, 23),
        ),
      ),
    );
  }
}

class MyNavbar extends StatefulWidget {
  const MyNavbar({Key? key});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    AdminDashBorad(),
    AcategoryPage(),
    OrderList(),
    AcategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Color.fromARGB(80, 247, 246, 246),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ''),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
              ),
            ),
            ListTile(
              title: const Text('Drawer Item 1'),
              onTap: () {
                // Handle drawer item 1 tap
              },
            ),
            ListTile(
              title: const Text('Drawer Item 2'),
              onTap: () {
                // Handle drawer item 2 tap
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
    );
  }
}
