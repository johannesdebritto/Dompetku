import 'package:flutter/material.dart';

class RiwyaatTotalScreen extends StatefulWidget {
  const RiwyaatTotalScreen({super.key});
  @override
  _RiwyaatTotalScreenState createState() => _RiwyaatTotalScreenState();
}

class _RiwyaatTotalScreenState extends State<RiwyaatTotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      width: double.infinity, // lebar penuh
      height: 200.0, // tinggi bisa ditentukan
    );
  }
}
