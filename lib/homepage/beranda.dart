import 'package:dompetku_application/homepage/kontenbawah.dart';
import 'package:dompetku_application/homepage/noted.dart';
import 'package:dompetku_application/homepage/progres.dart';
import 'package:dompetku_application/homepage/total.dart';
import 'package:dompetku_application/homepage/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      backgroundColor: Colors.grey[200],
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
                    SvgPicture.asset(
                      'assets/images/dashboard.svg',
                      height: 30,
                      width: 30,
                      color: const Color.fromARGB(
                          255, 0, 0, 0), // kasih warna kalau SVG-nya support
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
              TotalScreen(),
              TransaksiScreen(),
              const SizedBox(height: 2),
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
