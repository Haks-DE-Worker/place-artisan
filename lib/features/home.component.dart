import 'package:flutter/material.dart';

import '../common/constants/app_colors.dart';
import '../common/widgets/app_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppTextField(
              controller: _searchController,
              hintText: "Rechercher des artisans",
              labelText: "",
              prefixIcon: const Icon(Icons.search),
              onChanged: _filterSearchResults,
            ),
          ),
        ],
      ),
    );
  }

  // Function to filter the lists based on the search query
  void _filterSearchResults(String query) {
    setState(() {

    });
  }

}
