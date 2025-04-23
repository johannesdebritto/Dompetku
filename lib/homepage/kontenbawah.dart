import 'package:dompetku_application/homepage/filter_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Tambahkan kalau belum

class KontenBawahScreen extends StatefulWidget {
  const KontenBawahScreen({super.key});

  @override
  State<KontenBawahScreen> createState() => _KontenBawahScreenState();
}

class _KontenBawahScreenState extends State<KontenBawahScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0), // Background hitam
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  LucideIcons.barChart3, // Icon di kiri
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8), // Jarak antara icon dan teks
                Text(
                  'Rekap Sekilas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FilterTransaksiScreen(),
          ],
        ),
      ),
    );
  }
}
