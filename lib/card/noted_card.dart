import 'package:flutter/material.dart';

class NotedCardScreen extends StatefulWidget {
  const NotedCardScreen({super.key});

  @override
  State<NotedCardScreen> createState() => _NotedCardScreenState();
}

class _NotedCardScreenState extends State<NotedCardScreen> {
  @override
  Widget build(BuildContext context) {
    final date = '1 Agustus 2025';
    final time = '15:30 WIB';

    return Container(
      width: MediaQuery.of(context).size.width - 90,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
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
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Contoh Catatan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white, size: 18),
                  onPressed: () {
                    // Aksi saat tombol hapus ditekan
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Isi catatan keuangan Anda di sini...',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 62, 125, 0)),
              children: [
                const WidgetSpan(
                  child: Icon(Icons.calendar_today,
                      size: 24, color: Color(0xFF70E000)),
                ),
                TextSpan(text: ' $date  '),
                const WidgetSpan(
                  child: Icon(Icons.access_time,
                      size: 24, color: Color(0xFF70E000)),
                ),
                TextSpan(text: ' $time'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
