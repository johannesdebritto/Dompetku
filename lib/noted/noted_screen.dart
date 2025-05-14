import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dompetku_application/db/db_notes.dart';
import 'package:dompetku_application/notifer/notifiers.dart'; // Import notifiers

class NotedScreen extends StatefulWidget {
  const NotedScreen({super.key});

  @override
  State<NotedScreen> createState() => _NotedScreenState();
}

class _NotedScreenState extends State<NotedScreen> {
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();

    // Tambahkan listener untuk notedNotifier
    notedNotifier.addListener(_loadNotes);
  }

  @override
  void dispose() {
    // Hentikan listener saat widget dibuang
    notedNotifier.removeListener(_loadNotes);
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final data = await DBNotes().getNotes();
    setState(() {
      _notes = data;
    });
  }

  Future<void> _deleteNote(int id) async {
    await DBNotes().deleteNote(id);
    notedNotifier.value = !notedNotifier.value; // Trigger refresh
  }

  Widget buildCard(Map<String, dynamic> note, int index) {
    final id = note['id_noted'];
    final judul = note['judul'] ?? 'Tanpa Judul';
    final isi = note['isi_catatan'] ?? '';
    final tanggalRaw = note['tanggal'] ?? DateTime.now().toIso8601String();
    final tanggal =
        DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(tanggalRaw));
    final jam = DateFormat('HH:mm').format(DateTime.parse(tanggalRaw));

    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
              Expanded(
                child: Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white, size: 22),
                  onPressed: () => _deleteNote(id),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            isi,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 62, 125, 0),
              ),
              children: [
                const WidgetSpan(
                  child: Icon(Icons.calendar_today,
                      size: 28, color: Color(0xFF70E000)),
                ),
                TextSpan(text: ' $tanggal  '),
                const WidgetSpan(
                  child: Icon(Icons.access_time,
                      size: 28, color: Color(0xFF70E000)),
                ),
                TextSpan(text: ' $jam WIB'),
              ],
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
        title: const Text('Halaman Catatan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'Catatan masih kosong',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _notes
                    .asMap()
                    .entries
                    .map((entry) => buildCard(entry.value, entry.key))
                    .toList(),
              ),
            ),
    );
  }
}
