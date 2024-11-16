import 'package:flutter/material.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() {
    return _NewRequestPageState();
  }
}

class _NewRequestPageState extends State<NewRequestPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("New transactions"),
    );
  }

}
