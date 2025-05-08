import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Kalau nanti ingin format uang

class PemasukanItem extends StatefulWidget {
  @override
  _PemasukanItemState createState() => _PemasukanItemState();
}

class _PemasukanItemState extends State<PemasukanItem> {
  double _totalPemasukan = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTotalPemasukan();

    // Menambahkan listener untuk memperbarui tampilan saat pemasukanNotifier berubah
    pemasukanNotifier.addListener(_onPemasukanUpdated);
  }

  @override
  void dispose() {
    // Jangan lupa untuk menghapus listener saat widget dihancurkan
    pemasukanNotifier.removeListener(_onPemasukanUpdated);
    super.dispose();
  }

  void _onPemasukanUpdated() {
    _loadTotalPemasukan(); // Panggil ulang untuk update total pemasukan
  }

  Future<void> _loadTotalPemasukan() async {
    final db = DBTransaksi();
    final data = await db.getPemasukan();

    double total = 0.0;
    for (var item in data) {
      total += item['uang_masuk'] ?? 0.0;
    }

    setState(() {
      _totalPemasukan = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: _buildTransaksiItem(
        icon: Icons.arrow_downward,
        label: 'Pemasukan',
        amount: 'Rp ${_formatRupiah(_totalPemasukan)}',
        color: Colors.green.shade700,
      ),
    );
  }

  String _formatRupiah(double value) {
    return NumberFormat("#,##0", "id_ID").format(value);
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
        Icon(
          icon,
          color: color,
          size: 36,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
