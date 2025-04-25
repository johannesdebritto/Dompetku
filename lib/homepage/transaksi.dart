import 'package:flutter/material.dart';

class TransaksiScreen extends StatefulWidget {
  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: 0), // No horizontal padding
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Pemasukan - kasih padding kiri biar mepet
            Padding(
              padding: EdgeInsets.only(left: 10), // Lebih mepet kiri
              child: _buildTransaksiItem(
                icon: Icons.arrow_downward,
                label: 'Pemasukan',
                amount: 'Rp. 0',
                color: Colors.green.shade700,
              ),
            ),

            Spacer(),

            // Pengeluaran - tetap normal
            Padding(
              padding: EdgeInsets.only(right: 18), // Biar simetris
              child: _buildTransaksiItem(
                icon: Icons.arrow_upward,
                label: 'Pengeluaran',
                amount: 'Rp. 0',
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransaksiItem({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 36,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
