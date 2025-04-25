import 'package:dompetku_application/card/noted_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 5),
          const NotedCardScreen(), // Panggil widget dari file terpisah
          // const EmptyNotesScreen(),
        ],
      ),
    );
  }
}
