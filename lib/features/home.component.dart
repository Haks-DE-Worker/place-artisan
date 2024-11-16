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

  final List<CardData> cardDataList = [
    CardData(
        imageUrl: 'https://via.placeholder.com/400x200/FF5733/FFFFFF?text=Emploi',
        title: 'Sécretaire de Direction',
        description: "Venez travailler à Don de Dieu",
        buttonText: 'Accéder'
    ),
    CardData(
        imageUrl: 'https://via.placeholder.com/400x200/33A1FF/FFFFFF?text=Le+BTP',
          title: 'Entreprise',
        description: "Recrutement d'une entreprise dans le domaine du BTP",
        buttonText: 'Accéder'
    ),
    CardData(
        imageUrl: 'https://via.placeholder.com/400x200/DAF7A6/FFFFFF?text=Opportunité',
        title: 'Opportunité',
        description: "Nous avons besoin d'un expert en électricité bâtiment",
        buttonText: 'Accéder'
    ),
  ];

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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildSliders(),
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

  Widget buildSliders() {
    return // Slider with cards
      SizedBox(
        height: 250, // Height of the slider
        child: PageView.builder(
          itemCount: cardDataList.length,
          itemBuilder: (context, index) {
            final cardData = cardDataList[index];
            return CardSliderItem(
              imageUrl: cardData.imageUrl,
              title: cardData.title,
              description: cardData.description,
              buttonText: cardData.buttonText,
              onButtonPressed: () {
                // Action when the button is pressed
                print('Button pressed for ${cardData.title}');
              },
            );
          },
        ),
      );
  }

}

// Data model for each card
class CardData {
  final String imageUrl;
  final String title;
  final String description;
  final String buttonText;

  CardData({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

// Custom widget for each card in the slider
class CardSliderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  CardSliderItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Semi-transparent overlay for text visibility
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withOpacity(0.4), // Overlay with transparency
          ),
        ),
        // Content on top of the image
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.appColorGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
