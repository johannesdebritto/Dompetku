import 'package:dompetku_application/db/db_tabungan.dart';
import 'package:dompetku_application/modals/modal_tambah_tabungan.dart';
import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabunganCardScreen extends StatefulWidget {
  const TabunganCardScreen({super.key});

  @override
  State<TabunganCardScreen> createState() => _TabunganCardScreenState();
}

class _TabunganCardScreenState extends State<TabunganCardScreen> {
  List<Map<String, dynamic>> _tabunganList = [];

  @override
  void initState() {
    super.initState();
    fetchTabungan();
    tabunganNotifier.addListener(fetchTabungan);
  }

  @override
  void dispose() {
    tabunganNotifier.removeListener(fetchTabungan);
    super.dispose();
  }

  Future<void> fetchTabungan() async {
    final data = await DBTabungan().getTabungan();
    setState(() {
      _tabunganList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final cardWidth = MediaQuery.of(context).size.width - 90;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: _tabunganList.map((tabungan) {
          final int id = tabungan['id_tabungan'];
          final String nama = tabungan['nama_tabungan'] ?? '-';
          final double target = (tabungan['target_uang'] ?? 0).toDouble();
          final String tanggalTarget = tabungan['tanggal_target'] ?? '-';
          final double uangTabungan =
              (tabungan['uang_tabungan'] ?? 0).toDouble();

          // Hitung progress
          final double progress =
              (target == 0) ? 0.0 : (uangTabungan / target).clamp(0.0, 1.0);

          return Container(
            width: cardWidth,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6EC),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // ID Box
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Nama Tabungan
                    Expanded(
                      child: Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Tombol Hapus dan Plus
                    Row(
                      children: [
                        // Tombol Hapus
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.white, size: 18),
                            onPressed: () async {
                              await DBTabungan().deleteTabungan(id);
                              tabunganNotifier.value = !tabunganNotifier.value;
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),

                        // Tombol Plus
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.white, size: 18),
                            onPressed: () {
                              // Default jumlah uang bisa diganti jadi input jika perlu
                              showDialog(
                                context: context,
                                builder: (_) => ModalTambahTabunganScreen(
                                  idTabungan: id,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Progress Keuangan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatter.format(uangTabungan),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(formatter.format(target),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),

                const SizedBox(height: 6),

                // Progress Bar
                Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: (cardWidth - 32) * progress,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  'Target Tercapai: $tanggalTarget',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
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
