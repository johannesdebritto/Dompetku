import 'package:dompetku_application/historypage/riwayat._total.dart';
import 'package:dompetku_application/historypage/riwayat_diagarm.dart';
import 'package:dompetku_application/historypage/riwayat_garis.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20), // biar nggak mentok bawah
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons
                          .history, // Ganti icon sesuai dengan permintaan
                      size: 30,
                      color: Colors.green[900],
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'RIWAYAT DOMPETKU', // Ganti judul sesuai dengan permintaan
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const DiagramScreen(),
              const SizedBox(
                height: 5,
              ),
              const RiwayatGarisScreen(),
              const SizedBox(
                height: 10,
              ),
              const RiwyaatTotalScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
