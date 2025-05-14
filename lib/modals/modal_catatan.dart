import 'package:dompetku_application/db/db_notes.dart';
import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalCatatanScreen extends StatefulWidget {
  @override
  State<ModalCatatanScreen> createState() => _ModalCatatanScreenState();
}

class _ModalCatatanScreenState extends State<ModalCatatanScreen> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();

  final baseTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w500);
  final boldStyle = GoogleFonts.inter(fontWeight: FontWeight.bold);

  final dbNotes = DBNotes(); // Instance database

  BoxDecoration get _decoration => BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      );

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: boldStyle),
        SizedBox(height: 4),
        Container(
          decoration: _decoration,
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              border: InputBorder.none,
              hintText: hint ?? 'Masukkan $label',
              hintStyle: baseTextStyle,
            ),
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(label,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Future<void> _simpanCatatan() async {
    final judul = judulController.text.trim();
    final isi = isiController.text.trim();

    if (isi.isEmpty) {
      print('❌ Gagal menyimpan catatan: isi catatan kosong');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Isi catatan tidak boleh kosong')),
      );
      return;
    }

    try {
      await dbNotes.insertNote({
        'judul': judul,
        'isi_catatan': isi,
      });

      notedNotifier.value = !notedNotifier.value;
      Navigator.pop(context);

      print('✅ Catatan berhasil disimpan: Judul="$judul", Isi="$isi"');
    } catch (e) {
      print('🚫 Terjadi kesalahan saat menyimpan catatan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat menyimpan catatan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: _decoration,
                    child: Icon(Icons.note, color: Colors.black54)),
                SizedBox(width: 8),
                Text('Catatan Keuangan',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Judul',
              controller: judulController,
              hint: 'Masukkan judul catatan (opsional)',
            ),
            SizedBox(height: 10),
            _buildInputField(
              label: 'Isi Catatan',
              controller: isiController,
              maxLines: 5,
              hint: 'Tulis isi catatan di sini',
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 10),
                _buildButton('Simpan', Color(0xFF7F56D9), _simpanCatatan),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
