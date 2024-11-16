import 'package:flutter/material.dart';


class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() {
    return _MyRequestsPageState();
  }
}

class _MyRequestsPageState extends State<MyRequestsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Tarifs"),
    );
  }

}
