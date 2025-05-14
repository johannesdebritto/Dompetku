import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:intl/intl.dart';
import 'package:dompetku_application/notifer/notifiers.dart';

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

    pemasukanNotifier.addListener(_loadTotal);
    pengeluaranNotifier.addListener(_loadTotal);
  }

  @override
  void dispose() {
    pemasukanNotifier.removeListener(_loadTotal);
    pengeluaranNotifier.removeListener(_loadTotal);
    super.dispose();
  }

  Future<void> _loadTotal() async {
    final db = DBTransaksi();

    final pemasukanData = await db.getPemasukan();
    double totalPemasukan = 0.0;
    for (var item in pemasukanData) {
      totalPemasukan += (item['uang_masuk'] ?? 0.0) as double;
    }

    final pengeluaranData = await db.getPengeluaran();
    double totalPengeluaran = 0.0;
    for (var item in pengeluaranData) {
      totalPengeluaran += (item['nominal_pengeluaran'] ?? 0.0) as double;
    }

    double totalKeuangan = totalPemasukan - totalPengeluaran;

    setState(() {
      total = totalKeuangan;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          image: DecorationImage(
            image: AssetImage('assets/images/heroapp2.png'),
            fit: BoxFit.cover,
          ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 10),
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
            SizedBox(height: 4),
            Text(
              formattedTotal,
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
