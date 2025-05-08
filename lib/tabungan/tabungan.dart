import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabunganScreen extends StatelessWidget {
  const TabunganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final target = 500000.0;

    Widget buildTabunganCard() {
      return Container(
        width: MediaQuery.of(context).size.width - 30, // Memperbesar lebar card
        padding: const EdgeInsets.all(20), // Memperbesar padding card
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
                  width: 40, // Memperbesar ukuran kotak nomor
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Memperbesar teks nomor
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Menambah jarak antar elemen
                const Text(
                  'Tabungan Maggot',
                  style: TextStyle(
                    fontSize: 22, // Memperbesar font judul
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
                    icon:
                        const Icon(Icons.delete, color: Colors.white, size: 22),
                    onPressed: () {
                      // Aksi saat tombol hapus ditekan
                    },
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
                Text(formatter.format(0),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20)),
                Text(formatter.format(target),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20)),
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
            const Text('Target Tercapai: 1 Agustus 2025',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                )),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tabungan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTabunganCard(),
            const SizedBox(height: 16), // Jarak antar card
            buildTabunganCard(),
          ],
        ),
      ),
    );
  }
}
