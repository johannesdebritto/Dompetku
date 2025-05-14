import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dompetku_application/db/db_tabungan.dart'; // Pastikan sudah mengimpor DBTabungan
import 'package:dompetku_application/notifer/notifiers.dart'; // Import notifiers

class TabunganScreen extends StatefulWidget {
  const TabunganScreen({super.key});

  @override
  State<TabunganScreen> createState() => _TabunganScreenState();
}

class _TabunganScreenState extends State<TabunganScreen> {
  List<Map<String, dynamic>> _tabungan = [];

  @override
  void initState() {
    super.initState();
    _loadTabungan();

    // Tambahkan listener untuk tabunganNotifier
    tabunganNotifier.addListener(_loadTabungan);
  }

  @override
  void dispose() {
    // Hentikan listener saat widget dibuang
    tabunganNotifier.removeListener(_loadTabungan);
    super.dispose();
  }

  Future<void> _loadTabungan() async {
    final data = await DBTabungan().getTabungan(); // Ambil data dari DBTabungan
    setState(() {
      _tabungan = data;
    });
  }

  Future<void> _deleteTabungan(int id) async {
    await DBTabungan().deleteTabungan(id); // Hapus tabungan dari database
    tabunganNotifier.value = !tabunganNotifier.value; // Trigger refresh
  }

  Widget buildTabunganCard(Map<String, dynamic> tabungan, int index) {
    final target = tabungan['target_uang'] ?? 0.0;
    final id = tabungan['id_tabungan'];
    final nama = tabungan['nama_tabungan'] ?? 'Nama Tabungan';

    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6EC),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white, size: 22),
                  onPressed: () => _deleteTabungan(id),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NumberFormat.currency(
                        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                    .format(0),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                NumberFormat.currency(
                        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                    .format(target),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 6),
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
                width: MediaQuery.of(context).size.width * 0.5 -
                    48, // progress 50%
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    '50%',
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
          const Text(
            'Target Tercapai: 1 Agustus 2025',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tabungan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _tabungan.isEmpty
          ? const Center(
              child: Text(
                'Tabungan Kosong',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _tabungan
                    .asMap()
                    .entries
                    .map((entry) => buildTabunganCard(entry.value, entry.key))
                    .toList(),
              ),
            ),
    );
  }
}
