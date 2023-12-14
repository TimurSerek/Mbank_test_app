import 'package:flutter/material.dart';
import 'package:mbank_test_app/core/constants/strings.dart';
import 'package:mbank_test_app/features/characters/presentation/pages/characters.dart';
import 'package:mbank_test_app/features/episodes/presentation/pages/episodes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedTab,
          children: [
            CharactersScreen(),
            const EpisodesScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onSelectedTab,
          currentIndex: _selectedTab,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: AppStrings.characters,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.movie),
              label: AppStrings.episodes,
            ),
          ],
        ));
  }
}
