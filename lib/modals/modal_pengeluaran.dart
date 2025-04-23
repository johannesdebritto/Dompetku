import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalPengeluaranScreen extends StatefulWidget {
  const ModalPengeluaranScreen({super.key});
  @override
  State<ModalPengeluaranScreen> createState() => _ModalPengeluaranScreenState();
}

class _ModalPengeluaranScreenState extends State<ModalPengeluaranScreen> {
  final uangMasukController = TextEditingController();
  final kiloanController = TextEditingController();
  final catatanController = TextEditingController();

  final baseTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w500);
  final boldStyle = GoogleFonts.inter(fontWeight: FontWeight.bold);

  BoxDecoration get _decoration => BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 4, offset: const Offset(2, 2))
        ],
      );

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? prefix,
    String? suffix,
    TextInputType keyboardType = TextInputType.text,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: boldStyle),
        const SizedBox(height: 4),
        Row(
          children: [
            if (prefix != null)
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: _decoration,
                  child: Text(prefix, style: baseTextStyle)),
            if (prefix != null) const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintText: hint ?? 'Masukkan $label',
                    hintStyle: baseTextStyle,
                  ),
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (suffix != null) const SizedBox(width: 8),
            if (suffix != null)
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: _decoration,
                  child: Text(suffix, style: baseTextStyle)),
          ],
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
                    child: const Icon(Icons.money_off, color: Colors.black54)),
                const SizedBox(width: 8),
                Text('Catat Pengeluaran',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _buildInputField(
                label: 'Uang Masuk',
                controller: uangMasukController,
                prefix: 'Rp',
                keyboardType: TextInputType.number,
                hint: 'Masukkan nominal'),
            const SizedBox(height: 10),
            _buildInputField(
                label: 'Kiloan',
                controller: kiloanController,
                suffix: 'Kg',
                keyboardType: TextInputType.number,
                hint: 'Masukkan berat'),
            const SizedBox(height: 10),
            _buildInputField(label: 'Catatan', controller: catatanController),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                const SizedBox(width: 10),
                _buildButton('Simpan', const Color(0xFF7F56D9), () {
                  print('Uang Masuk: ${uangMasukController.text}');
                  print('Kiloan: ${kiloanController.text}');
                  print('Catatan: ${catatanController.text}');
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
