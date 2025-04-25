import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalPemasukanScreen extends StatefulWidget {
  @override
  State<ModalPemasukanScreen> createState() => _ModalPemasukanScreenState();
}

class _ModalPemasukanScreenState extends State<ModalPemasukanScreen> {
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
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
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
        SizedBox(height: 4),
        Row(
          children: [
            if (prefix != null)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: _decoration,
                  child: Text(prefix, style: baseTextStyle)),
            if (prefix != null) SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintText: hint ?? 'Masukkan $label',
                    hintStyle: baseTextStyle,
                  ),
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (suffix != null) SizedBox(width: 8),
            if (suffix != null)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    child: Icon(Icons.attach_money, color: Colors.black54)),
                SizedBox(width: 8),
                Text('Catat Pemasukan',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
                label: 'Uang Masuk',
                controller: uangMasukController,
                prefix: 'Rp',
                keyboardType: TextInputType.number,
                hint: 'Masukkan nominal'),
            SizedBox(height: 10),
            _buildInputField(
                label: 'Kiloan',
                controller: kiloanController,
                suffix: 'Kg',
                keyboardType: TextInputType.number,
                hint: 'Masukkan berat'),
            SizedBox(height: 10),
            _buildInputField(label: 'Catatan', controller: catatanController),
            SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 10),
                _buildButton('Simpan', Color(0xFF7F56D9), () {
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
