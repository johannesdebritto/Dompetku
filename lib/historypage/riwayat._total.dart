import 'package:dompetku_application/historypage/filter_transaksi.dart';
import 'package:dompetku_application/transaksi/pemasukan.dart';
import 'package:dompetku_application/transaksi/pengeluaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RiwyaatTotalScreen extends StatefulWidget {
  const RiwyaatTotalScreen({super.key});
  @override
  _RiwyaatTotalScreenState createState() => _RiwyaatTotalScreenState();
}

class _RiwyaatTotalScreenState extends State<RiwyaatTotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/rekap.svg',
                  width: 36, height: 36),
              const SizedBox(width: 10),
              const Text(
                'Rekap Sekilas',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilterTransaksiScreen(),
          const SizedBox(
            height: 5,
          ),
          const PemasukanScreen(),
          const PengeluaranScreen(),
        ],
      ),
    );
  }
}
