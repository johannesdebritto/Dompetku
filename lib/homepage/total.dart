import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TotalScreen extends StatefulWidget {
  const TotalScreen({super.key});

  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1), // krem
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/rekap.svg',
                    width: 40, height: 40),
                const SizedBox(width: 12),
                const Text(
                  'Rekap Keuangan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildItem('assets/images/pemasukan1.svg', 'Pemasukan', 'Rp. 0',
                Colors.green.shade800),
            const SizedBox(height: 1),
            _buildItem('assets/images/pengeluaran1.svg', 'Pengeluaran', 'Rp. 0',
                Colors.red),
            const SizedBox(height: 1),
            _buildItem('assets/images/total.svg', 'Total', 'Rp. 0', Colors.blue,
                isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String iconPath, String label, String amount, Color color,
      {bool isBold = false}) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 40, height: 40),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            '$label: $amount',
            style: TextStyle(
              fontSize: 20,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              fontFamily: 'Inter',
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
