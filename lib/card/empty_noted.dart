import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyNotesScreen extends StatelessWidget {
  const EmptyNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/empty_notes.svg', // ganti sesuai nama file SVG kamu
        width: 155,
        height: 155,
      ),
    );
  }
}
