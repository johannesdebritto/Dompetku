import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:intl/intl.dart'; // Import intl
import 'package:dompetku_application/notifer/notifiers.dart'; // Pastikan ini diimport

class TotalScreen extends StatefulWidget {
  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTotal();

    // Tambahkan listener pada pemasukan dan pengeluaran
    pemasukanNotifier.addListener(_loadTotal);
    pengeluaranNotifier.addListener(_loadTotal);
  }

  @override
  void dispose() {
    // Hapus listener saat widget dihapus
    pemasukanNotifier.removeListener(_loadTotal);
    pengeluaranNotifier.removeListener(_loadTotal);
    super.dispose();
  }

  Future<void> _loadTotal() async {
    final db = DBTransaksi();

    // Ambil data pemasukan
    final pemasukanData = await db.getPemasukan();
    double totalPemasukan = 0.0;
    for (var item in pemasukanData) {
      totalPemasukan += (item['uang_masuk'] ?? 0.0) as double;
    }

    // Ambil data pengeluaran
    final pengeluaranData = await db.getPengeluaran();
    double totalPengeluaran = 0.0;
    for (var item in pengeluaranData) {
      totalPengeluaran += (item['nominal_pengeluaran'] ?? 0.0) as double;
    }

    // Hitung total (pemasukan - pengeluaran)
    double totalKeuangan = totalPemasukan - totalPengeluaran;

    setState(() {
      total = totalKeuangan;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Format total dengan pemisah ribuan
    String formattedTotal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(total);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.black, // Latar item
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri semua
          children: [
            // Judul di tengah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/rekap.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 12),
                Text(
                  'Rekap Keuangan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10), // Lebih dekatkan jaraknya dengan Total

            // Baris icon Total + tulisan Total, rata kiri
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/total.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 12),
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(
                height: 4), // Lebih dekatkan jarak antara Total dan nominal

            // Nominal di bawah, rata kiri
            Text(
              formattedTotal, // Langsung pakai string yang sudah diformat lengkap
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
