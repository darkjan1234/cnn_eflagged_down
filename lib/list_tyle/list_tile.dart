import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key); // Added key parameter

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Text(
              'Violation Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Records'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/record/record');
            },
          ),
          ListTile(
            title: const Text('Violation'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/violation/violation');
            },
          ),
          ListTile(
            title: const Text('Camera CNN'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/cameracnn/cameracnn');
            },
          ),
        ],
      ),
    );
  }
}
