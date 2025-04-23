import 'package:dompetku_application/homepage/kontenbawah.dart';
import 'package:dompetku_application/homepage/noted.dart';
import 'package:dompetku_application/homepage/progres.dart';
import 'package:dompetku_application/homepage/total.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
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
                      LucideIcons.layoutDashboard,
                      size: 30,
                      color: Colors.green[900],
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'DASHBOARD DOMPETKU',
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
              const TotalScreen(),
              const SizedBox(height: 2),
              // Tambahkan widget progress di sini
              const ProgressWidget(), // <--- panggil ProgressWidget-nya
              const SizedBox(height: 2), // beri jarak sebelum konten bawah
              const NoteWidget(),
              const SizedBox(height: 2), // beri jarak sebelum konten bawah
              const KontenBawahScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
