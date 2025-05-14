import 'package:dompetku_application/card/empty_noted.dart';
import 'package:dompetku_application/card/noted_card.dart';
import 'package:dompetku_application/noted/noted_screen.dart';
import 'package:dompetku_application/db/db_notes.dart'; // Import database
import 'package:dompetku_application/notifer/notifiers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  Future<bool> _checkIfNotesExist() async {
    final db = DBNotes();
    final notes = await db.getNotes();
    return notes.isNotEmpty;
  }

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotedScreen()),
                  );
                },
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder(
            valueListenable: notedNotifier,
            builder: (context, _, __) {
              return FutureBuilder<bool>(
                future: _checkIfNotesExist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData && snapshot.data == true) {
                    return const NotedCardScreen();
                  } else {
                    return const EmptyNotesScreen();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
