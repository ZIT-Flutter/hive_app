import 'package:flutter/material.dart';
import 'package:hive_app/setting_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.67,
      child: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: List.generate(drawerItemList.length, (index) {
            Widget? destination = drawerItemList[index].destination;

            return InkWell(
              onTap: () {
                if (destination != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => destination));
                }
              },
              child: Card(
                child: Row(
                  children: [
                    Icon(drawerItemList[index].icon),
                    SizedBox(width: 16),
                    Text(drawerItemList[index].title)
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget? destination;

  DrawerItem({required this.title, required this.icon, this.destination});
}

List<DrawerItem> drawerItemList = [
  DrawerItem(
      title: 'Settings',
      icon: Icons.settings,
      destination: const SettingScreen()),
  DrawerItem(title: 'Profile', icon: Icons.people),
  DrawerItem(title: 'Profile', icon: Icons.people),
  DrawerItem(title: 'Profile', icon: Icons.people),
  DrawerItem(title: 'Profile', icon: Icons.people),
  DrawerItem(title: 'Profile', icon: Icons.people),
  DrawerItem(title: 'Profile', icon: Icons.people),
];
