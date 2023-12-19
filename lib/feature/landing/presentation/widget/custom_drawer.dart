import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[900],
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Contact',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Speakers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Agenda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Contact',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Sponsors',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Team',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
