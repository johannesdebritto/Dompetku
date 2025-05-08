import 'package:dompetku_application/db/db_transaksi.dart';
import 'package:dompetku_application/notifer/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalPengeluaranScreen extends StatefulWidget {
  @override
  State<ModalPengeluaranScreen> createState() => _ModalPengeluaranScreenState();
}

class _ModalPengeluaranScreenState extends State<ModalPengeluaranScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final _baseTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w500);
  final _boldStyle = GoogleFonts.inter(fontWeight: FontWeight.bold);

  BoxDecoration get _decoration => BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
        ],
      );

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? prefix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _boldStyle),
        const SizedBox(height: 4),
        Row(
          children: [
            if (prefix != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: _decoration,
                child: Text(prefix, style: _baseTextStyle),
              ),
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
                    hintText: 'Masukkan $label',
                    hintStyle: _baseTextStyle,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                  child: const Icon(Icons.money_off, color: Colors.black54),
                ),
                const SizedBox(width: 8),
                Text(
                  'Catat Pengeluaran',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInputField(
              label: 'Jumlah Pengeluaran',
              controller: _amountController,
              prefix: 'Rp',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Keterangan',
              controller: _noteController,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildButton('Batal', Colors.red, () => Navigator.pop(context)),
                const SizedBox(width: 10),
                _buildButton('Simpan', const Color(0xFF7F56D9), () async {
                  final jumlah = double.tryParse(_amountController.text) ?? 0.0;
                  final keterangan = _noteController.text.trim();
                  final now = DateTime.now();

                  // Validasi agar jumlah tidak negatif
                  if (jumlah <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Jumlah pengeluaran harus lebih besar dari 0')),
                    );
                    return; // Keluar dari fungsi jika validasi gagal
                  }

                  final data = {
                    'tanggal':
                        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}",
                    'waktu':
                        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
                    'nominal_pengeluaran': jumlah,
                    'keterangan': keterangan,
                  };

                  final db = DBTransaksi();
                  await db.insertPengeluaran(data);

                  // Memanggil notifier untuk memberitahukan widget pengeluaranItem agar memperbarui tampilannya
                  pengeluaranNotifier.value = !pengeluaranNotifier.value;

                  // Debug log untuk memastikan data yang disimpan
                  print('✅ Data pengeluaran berhasil disimpan:');
                  print('Jumlah: $jumlah');
                  print('Keterangan: $keterangan');
                  print('Tanggal: ${data['tanggal']}');
                  print('Waktu: ${data['waktu']}');

                  Navigator.pop(context); // Tutup modal setelah simpan
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
