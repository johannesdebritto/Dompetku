import 'package:dompetku_application/db/db_tabungan.dart';
import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalTambahTabunganScreen extends StatefulWidget {
  final int idTabungan; // ID tabungan yang akan diupdate
  ModalTambahTabunganScreen({required this.idTabungan});

  @override
  State<ModalTambahTabunganScreen> createState() =>
      _ModalTambahTabunganScreenState();
}

class _ModalTambahTabunganScreenState extends State<ModalTambahTabunganScreen> {
  final jumlahUangController = TextEditingController(); // Controller untuk uang
  final db = DBTabungan(); // Inisialisasi database

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
            offset: Offset(2, 2),
          ),
        ],
      );

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
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
            keyboardType: keyboardType,
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
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _simpanTabungan() async {
    final jumlahUang = double.tryParse(jumlahUangController.text.trim());

    if (jumlahUang == null || jumlahUang <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan jumlah uang yang valid')),
      );
      return;
    }

    // Ambil data lama untuk ditambahkan jumlah baru
    final allTabungan = await db.getTabungan();
    final current = allTabungan.firstWhere(
      (item) => item['id_tabungan'] == widget.idTabungan,
      orElse: () => {},
    );

    if (current.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tabungan tidak ditemukan')),
      );
      return;
    }

    final currentUang = current['uang_tabungan'] ?? 0.0;
    final totalUang = currentUang + jumlahUang;

    await db.updateUangTabunganById(widget.idTabungan, totalUang);
    tabunganNotifier.value = !tabunganNotifier.value;

    Navigator.pop(context);
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
                  child: Icon(Icons.savings, color: Colors.black54),
                ),
                SizedBox(width: 8),
                Text(
                  'Tambah Tabungan',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Input field untuk jumlah uang yang akan ditambahkan
            _buildInputField(
              label: 'Jumlah Uang',
              controller: jumlahUangController,
              hint: 'Masukkan jumlah uang yang ingin ditambahkan',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 10),
                _buildButton('Simpan', Color(0xFF7F56D9), _simpanTabungan),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
