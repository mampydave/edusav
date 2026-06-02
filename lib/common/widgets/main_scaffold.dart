import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentNavIndex;
  final Function(int) onNavTap;
  final String? appBarTitle;
  final List<Widget>? appBarActions;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentNavIndex,
    required this.onNavTap,
    this.appBarTitle,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle != null
          ? AppBar(
              title: Text(
                appBarTitle!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              actions: appBarActions,
            )
          : null,
      body: body,
      bottomNavigationBar: EduSavBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }
}
