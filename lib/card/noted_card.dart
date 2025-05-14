import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dompetku_application/db/db_notes.dart';
import 'package:dompetku_application/notifer/notifiers.dart'; // ⬅️ Import notifiers

class NotedCardScreen extends StatefulWidget {
  const NotedCardScreen({super.key});

  @override
  State<NotedCardScreen> createState() => _NotedCardScreenState();
}

class _NotedCardScreenState extends State<NotedCardScreen> {
  List<Map<String, dynamic>> _notesList = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();

    // Dengarkan perubahan dari notedNotifier
    notedNotifier.addListener(_loadNotes);
  }

  @override
  void dispose() {
    // Hentikan listener saat widget dihapus dari tree
    notedNotifier.removeListener(_loadNotes);
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final data = await DBNotes().getNotes();
    setState(() {
      _notesList = data;
    });
  }

  Future<void> _deleteNote(int id) async {
    await DBNotes().deleteNote(id);
    notedNotifier.value = !notedNotifier.value; // 🔁 Trigger refresh
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 100;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: _notesList.asMap().entries.map((entry) {
          final index = entry.key;
          final note = entry.value;

          final id = note['id_noted'] ?? 0;
          final judul = note['judul'] ?? 'Tanpa Judul';
          final isi = note['isi_catatan'] ?? '';
          final tanggalRaw =
              note['tanggal'] ?? DateTime.now().toIso8601String();
          final tanggal = DateFormat('d MMMM y', 'id_ID')
              .format(DateTime.parse(tanggalRaw));
          final jam = DateFormat('HH:mm').format(DateTime.parse(tanggalRaw));

          return Container(
            width: cardWidth,
            margin: const EdgeInsets.only(right: 16),
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
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        judul,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.white, size: 18),
                        onPressed: () => _deleteNote(id),
                        padding: const EdgeInsets.all(8),
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  isi,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 62, 125, 0),
                    ),
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.calendar_today,
                            size: 24, color: Color(0xFF70E000)),
                      ),
                      TextSpan(text: ' $tanggal  '),
                      const WidgetSpan(
                        child: Icon(Icons.access_time,
                            size: 24, color: Color(0xFF70E000)),
                      ),
                      TextSpan(text: ' $jam WIB'),
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
