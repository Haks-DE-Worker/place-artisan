import 'package:artisan_mobile/common/auth/auth.dart';
import 'package:artisan_mobile/features/home.component.dart';
import 'package:artisan_mobile/features/login.component.dart';
import 'package:artisan_mobile/features/my_requests.component.dart';
import 'package:artisan_mobile/features/submitted_requests.component.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_constant.dart';


// ignore: must_be_immutable
class ConditionalDrawer extends StatelessWidget {

  ConditionalDrawer({super.key});

  List<Map<String, dynamic>> menu_items = [
    {
      'title': 'Accueil',
      'icon': Icons.home,
      'color': Colors.blue,
    },
    {
      'title': 'Nouvelles demandes',
      'icon': Icons.newspaper,
      'color': AppColors.appColorViolet,
    },
    {
      'title': 'Demandes traitées',
      'icon': Icons.check_circle,
      'color': AppColors.appColorChocholate,
    },
    {
      'title': 'Déconnexion',
      'icon': Icons.power_settings_new,
      'color': Colors.red,
      'onTap': () async{
        // Handle logout action
        removeAgenceInfo();
        // Navigator.pushNamed(context, '/login');
      },
    }
  ];

  @override
  Widget build(BuildContext context) {

      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.appColorGray,
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppConstant.appName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'AGENCE ALOREIS SARL',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // List of menu items
               DrawerMenuItem(
                icon: Icons.home,
                title: 'Accueil',
                color: Colors.blue,
                 onTap: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                 }
              ),
              DrawerMenuItem(
                icon: Icons.newspaper,
                title: 'Nouvelles demandes',
                color: AppColors.appColorViolet,
                 onTap: ()  {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SubmittedRequests()),
                      );
                 }
              ),
              DrawerMenuItem(
                icon: Icons.task,
                title: 'Mes demandes',
                color: AppColors.appColorChocholate,
                 onTap: ()  {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyRequestsPage()),
                      );
                 }
              ),
              DrawerMenuItem(
                icon: Icons.power_settings_new,
                title: 'Déconnexion',
                color: Colors.red,
                 onTap: () async {

                      await removeAgenceInfo();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                 }
              ),

          ],
        ),
      );
    } 
  
}

class DrawerMenuItem extends StatelessWidget {
  final icon;
  final String title;
  final color;
  final VoidCallback? onTap;

  const DrawerMenuItem({super.key, required this.icon, required this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }
}