import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TotalScreen extends StatefulWidget {
  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.black, // Latar item
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri semua
          children: [
            // Judul di tengah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/rekap.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 12),
                Text(
                  'Rekap Keuangan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10), // Lebih dekatkan jaraknya dengan Total

            // Baris icon Total + tulisan Total, rata kiri
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/total.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 12),
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(
                height: 4), // Lebih dekatkan jarak antara Total dan nominal

            // Nominal di bawah, rata kiri
            Text(
              'Rp. 0',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
