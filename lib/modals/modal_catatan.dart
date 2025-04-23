import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalCatatanScreen extends StatefulWidget {
  const ModalCatatanScreen({super.key});

  @override
  State<ModalCatatanScreen> createState() => _ModalCatatanScreenState();
}

class _ModalCatatanScreenState extends State<ModalCatatanScreen> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();

  final baseTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w500);
  final boldStyle = GoogleFonts.inter(fontWeight: FontWeight.bold);

  BoxDecoration get _decoration => BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(2, 2),
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
        const SizedBox(height: 4),
        Container(
          decoration: _decoration,
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
          padding: const EdgeInsets.symmetric(vertical: 15),
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: _decoration,
                    child: const Icon(Icons.note, color: Colors.black54)),
                const SizedBox(width: 8),
                Text('Catatan Keuangan',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _buildInputField(
              label: 'Judul',
              controller: judulController,
              hint: 'Masukkan judul catatan (opsional)',
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Isi Catatan',
              controller: isiController,
              maxLines: 5,
              hint: 'Tulis isi catatan di sini',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                const SizedBox(width: 10),
                _buildButton('Simpan', const Color(0xFF7F56D9), () {
                  final tanggal = DateTime.now().toIso8601String();
                  print('Judul: ${judulController.text}');
                  print('Isi: ${isiController.text}');
                  print('Tanggal: $tanggal');
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
