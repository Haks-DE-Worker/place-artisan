import 'package:flutter/material.dart';

class ArtisansPage extends StatefulWidget {
  const ArtisansPage({super.key});

  @override
  State<ArtisansPage> createState() {
    return _ArtisansPageState();
  }
}

class _ArtisansPageState extends State<ArtisansPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("New transactions"),
    );
  }

}
