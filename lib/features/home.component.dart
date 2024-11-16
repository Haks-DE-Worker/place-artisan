import 'package:flutter/material.dart';

import '../common/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 350,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.appColorChocholate
            ),
        )
      ],
    );
  }

}
