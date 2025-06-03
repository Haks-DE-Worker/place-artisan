import 'package:artisan_mobile/features/artisans.component.dart';
import 'package:artisan_mobile/features/new_request.component.dart';
import 'package:artisan_mobile/features/login.component.dart';
import 'package:artisan_mobile/features/register.component.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../common/constants/app_colors.dart';
import '../common/constants/app_constant.dart';
import 'home.component.dart';
import 'my_requests.component.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({super.key});

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {

  final PersistentTabController _menuController =  PersistentTabController(
      initialIndex: 0
  );


  List<Widget> _buildPages() {
    return [
      const HomePage(),
      const ArtisansPage(),
      // const PostsPage(),
      // const TarifsPage(),
      const MyRequestsPage(),
    ];
  }

  PersistentTabView _buildScreens() {
    return PersistentTabView(
      context,
      controller: _menuController,
      screens: _buildPages(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
      animationSettings: _animationSettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(AppConstant.appName),
      ),
      body: _buildScreens(),
    );
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _menuTem(Icons.home_filled, "Accueil"),
      _menuTem(Icons.post_add, "Publications"),
      _menuTem(Icons.add_circle_sharp, "Nouvelle"),
      _menuTem(Icons.people_alt_rounded, "Artisans"),
      _menuTem(Icons.person_pin, "Mon compte"),
    ];
  }
  
  PersistentBottomNavBarItem _menuTem(IconData icon, String text) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon, size: 30),
      title: text,
      activeColorPrimary: AppColors.appColorViolet,
      inactiveColorPrimary: Colors.black,

    );
  }

  NavBarAnimationSettings _animationSettingPage() {
    return const NavBarAnimationSettings(
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide
        )
    );
  }
}
