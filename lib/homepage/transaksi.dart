import 'package:dompetku_application/homepage/transaksi_pemasukan.dart';
import 'package:dompetku_application/homepage/transaksi_pengeluaran.dart';
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
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
            PemasukanItem(),
            Spacer(),
            PengeluaranItem(),
          ],
        ),
      ),
    );
  }
}
