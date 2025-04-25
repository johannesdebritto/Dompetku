import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTabunganScreen extends StatelessWidget {
  const EmptyTabunganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/empty_tabungan.svg', // ganti sesuai nama file SVG kamu
        width: 150,
        height: 150,
      ),
    );
  }
}
