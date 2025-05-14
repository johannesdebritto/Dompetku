import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  List<Map<String, dynamic>> pengeluaranList = [];

  @override
  void initState() {
    super.initState();
    _loadPengeluaran();
  }

  Future<void> _loadPengeluaran() async {
    final db = DBTransaksi();
    final allData = await db.getPengeluaran();
    final sortedData = allData.reversed
        .take(5)
        .toList(); // Atau pakai LIMIT langsung dari DBTransaksi
    setState(() {
      pengeluaranList = sortedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: pengeluaranList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada transaksi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Column(
              children: pengeluaranList.map((data) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon Box
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.money_off,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '-${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(
                                double.tryParse(data['nominal_pengeluaran']
                                        .toString()) ??
                                    0.0,
                              )}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${data['tanggal']}, ${data['waktu'] ?? ''}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data['keterangan'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
