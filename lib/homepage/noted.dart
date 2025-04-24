import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    // Set tanggal dan waktu manual
    final date = '1 Agustus 2025';
    final time = '15:30 WIB';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/catatan.svg',
                  width: 28, height: 28),
              const SizedBox(width: 10),
              const Text(
                'Catatan Keuangan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width - 90, // Tambahkan ini
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
                        color: Color.fromARGB(255, 0, 0, 0),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Isi catatan keuangan Anda di sini...',
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 62, 125, 0)),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.calendar_today,
                            size: 24, color: Color(0xFF70E000)),
                      ),
                      TextSpan(text: ' $date  '),
                      WidgetSpan(
                        child: Icon(Icons.access_time,
                            size: 24, color: Color(0xFF70E000)),
                      ),
                      TextSpan(text: ' $time'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
