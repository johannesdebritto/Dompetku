import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModaltabunganScreen extends StatefulWidget {
  const ModaltabunganScreen({super.key});
  @override
  State<ModaltabunganScreen> createState() => _ModaltabunganScreenState();
}

class _ModaltabunganScreenState extends State<ModaltabunganScreen> {
  final namaTabunganController = TextEditingController();
  final targetNominalController = TextEditingController();
  final tanggalMulaiController = TextEditingController();
  final tanggalTargetController = TextEditingController();
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
    TextInputType keyboardType = TextInputType.text,
    String? hint,
    bool readOnly = false,
    VoidCallback? onTap,
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
                child: Text(prefix, style: baseTextStyle),
              ),
            if (prefix != null) const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  onTap: onTap,
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

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
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
                    child: const Icon(Icons.savings, color: Colors.black54)),
                const SizedBox(width: 8),
                Text('Catat Tabungan',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _buildInputField(
                label: 'Nama Tabungan', controller: namaTabunganController),
            const SizedBox(height: 10),
            _buildInputField(
                label: 'Target Nominal',
                controller: targetNominalController,
                prefix: 'Rp',
                keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Tanggal Mulai',
              controller: tanggalMulaiController,
              readOnly: true,
              onTap: () => _selectDate(tanggalMulaiController),
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Tanggal Target',
              controller: tanggalTargetController,
              readOnly: true,
              onTap: () => _selectDate(tanggalTargetController),
            ),
            const SizedBox(height: 10),
            _buildInputField(label: 'Catatan', controller: catatanController),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                const SizedBox(width: 10),
                _buildButton('Simpan', const Color(0xFF7F56D9), () {
                  print('Nama: ${namaTabunganController.text}');
                  print('Target: ${targetNominalController.text}');
                  print('Mulai: ${tanggalMulaiController.text}');
                  print('Target Tanggal: ${tanggalTargetController.text}');
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
