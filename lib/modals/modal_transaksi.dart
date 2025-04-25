import 'package:dompetku_application/buttons/button_buat_tabungan.dart';
import 'package:dompetku_application/buttons/button_catat_pemasukan.dart';
import 'package:dompetku_application/buttons/button_catat_pengeluaran.dart';
import 'package:dompetku_application/buttons/button_catatan_keuangan.dart';
import 'package:flutter/material.dart';

class ModalTransaksiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: ButtonCatatPemasukan()),
              SizedBox(width: 12),
              Expanded(child: ButtonCatatPengeluaran()),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: ButtonBuatTabungan()),
              SizedBox(width: 12),
              Expanded(child: ButtonCatatanKeuangan()),
            ],
          ),
        ],
      ),
    );
  }
}
