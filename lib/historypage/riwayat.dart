import 'package:dompetku_application/historypage/riwayat._total.dart';
import 'package:dompetku_application/historypage/riwayat_diagarm.dart';
import 'package:dompetku_application/historypage/riwayat_garis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RiwayatScreen extends StatefulWidget {
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
          padding: EdgeInsets.only(bottom: 20), // biar nggak mentok bawah
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/riwayat.svg',
                      height: 30,
                      width: 30,
                      color: Color.fromARGB(
                          255, 0, 0, 0), // kasih warna kalau SVG-nya support
                    ),
                    SizedBox(width: 8),
                    Text(
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
              DiagramScreen(),
              SizedBox(
                height: 5,
              ),
              RiwayatGarisScreen(),
              SizedBox(
                height: 10,
              ),
              RiwyaatTotalScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
