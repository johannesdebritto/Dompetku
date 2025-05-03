import 'package:dompetku_application/homepage/noted.dart';
import 'package:dompetku_application/homepage/progres.dart';
import 'package:dompetku_application/homepage/total.dart';
import 'package:dompetku_application/homepage/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BerandaScreen extends StatefulWidget {
  BerandaScreen({super.key});

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
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                100, // tambahkan padding bawah
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/dashboard.svg',
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
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
              SizedBox(height: 2),
              ProgressWidget(),
              SizedBox(height: 2),
              NoteWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
