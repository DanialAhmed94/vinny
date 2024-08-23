import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vinny_ai_chat/constants/AppConstants.dart';
import 'package:vinny_ai_chat/view/Navigation_AccountView/AccountView.dart';
import 'package:vinny_ai_chat/view/Navigation_ChatView/chatView.dart';

import '../Navigation_Home/Navigation_Home.dart';
import '../Navigation_UpgradeView/UpgradeView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeviewState();
}

class _HomeviewState extends State<HomeView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          NavigationHome(),
          ChatView(),
          Upgradeview(),
          Accountview(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar( currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white, // Set selected item text color
        unselectedItemColor: Colors.white,
        backgroundColor: AppConstants.navigationBarColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'InterSemiBold',
          fontSize: 12,
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'InterSemiBold',
          fontSize: 12,
          color: Colors.white,
        ),

        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConstants.homeUnselected),
              activeIcon: SvgPicture.asset(AppConstants.homeSelected),
              label: "Home"),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppConstants.chatUnselected),
            activeIcon: SvgPicture.asset(AppConstants.chatSelected),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppConstants.upgradeUnselected),
            activeIcon: SvgPicture.asset(AppConstants.upgradeSelected),
            label: "Upgrade",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppConstants.accountUnselected),
            activeIcon: SvgPicture.asset(AppConstants.accountSelected),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
