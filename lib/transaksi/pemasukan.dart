import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PemasukanScreen extends StatefulWidget {
  const PemasukanScreen({Key? key}) : super(key: key);

  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  List<Map<String, dynamic>> pemasukanList = [];

  @override
  void initState() {
    super.initState();
    _loadPemasukan();
  }

  Future<void> _loadPemasukan() async {
    final db = DBTransaksi();
    final allData = await db.getPemasukan();
    final sortedData = allData.reversed.take(5).toList();
    setState(() {
      pemasukanList = sortedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: pemasukanList.isEmpty
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
              children: pemasukanList.map((data) {
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
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.monetization_on,
                          color: Colors.green,
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
                              '+${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(data['uang_masuk'])}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${data['tanggal']}, ${data['waktu']}',
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
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
