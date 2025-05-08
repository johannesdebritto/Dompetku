import 'package:flutter/material.dart';

class NotedScreen extends StatelessWidget {
  const NotedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final date = '1 Agustus 2025';
    final time = '15:30 WIB';

    Widget buildCard() {
      return Container(
        width:
            MediaQuery.of(context).size.width - 30, // Menyesuaikan lebar card
        padding: const EdgeInsets.all(20), // Memperbesar padding card
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
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
                  'Contoh Catatan',
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
            const SizedBox(height: 10),
            const Text(
              'Isi catatan keuangan Anda di sini ihdsifjisfdojsodkfoisjdofjpsakdfpojsoifhsajdpojfsn',
              style: TextStyle(fontSize: 18), // Memperbesar font isi catatan
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 20, // Memperbesar font tanggal dan waktu
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 62, 125, 0)),
                children: [
                  const WidgetSpan(
                    child: Icon(Icons.calendar_today,
                        size: 28, color: Color(0xFF70E000)),
                  ),
                  TextSpan(text: ' $date  '),
                  const WidgetSpan(
                    child: Icon(Icons.access_time,
                        size: 28, color: Color(0xFF70E000)),
                  ),
                  TextSpan(text: ' $time'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Catatan'),
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
            buildCard(),
            const SizedBox(height: 16), // Jarak antar card
            buildCard(),
          ],
        ),
      ),
    );
  }
}
