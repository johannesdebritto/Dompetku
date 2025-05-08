import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:intl/intl.dart';

class PengeluaranItem extends StatefulWidget {
  @override
  State<PengeluaranItem> createState() => _PengeluaranItemState();
}

class _PengeluaranItemState extends State<PengeluaranItem> {
  double totalPengeluaran = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTotalPengeluaran();

    // Menambahkan listener untuk memperbarui tampilan saat pengeluaranNotifier berubah
    pengeluaranNotifier.addListener(_onPengeluaranUpdated);
  }

  @override
  void dispose() {
    // Jangan lupa untuk menghapus listener saat widget dihancurkan
    pengeluaranNotifier.removeListener(_onPengeluaranUpdated);
    super.dispose();
  }

  void _onPengeluaranUpdated() {
    _loadTotalPengeluaran(); // Panggil ulang untuk update total pengeluaran
  }

  Future<void> _loadTotalPengeluaran() async {
    final db = DBTransaksi();
    final data = await db.getPengeluaran();
    double total = 0.0;

    for (var item in data) {
      total += (item['nominal_pengeluaran'] ?? 0.0) as double;
    }

    setState(() {
      totalPengeluaran = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 18),
      child: _buildTransaksiItem(
        icon: Icons.arrow_upward,
        label: 'Pengeluaran',
        amount: NumberFormat.currency(
                locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
            .format(totalPengeluaran),
        color: Colors.red.shade700,
      ),
    );
  }

  Widget _buildTransaksiItem({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 36),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: Colors.white)),
            SizedBox(height: 8),
            Text(amount,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: color)),
          ],
        ),
      ],
    );
  }
}
