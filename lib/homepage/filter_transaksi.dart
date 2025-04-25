import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pastikan sudah menambahkan package flutter_svg

class FilterTransaksiScreen extends StatefulWidget {
  @override
  State<FilterTransaksiScreen> createState() => _FilterTransaksiScreenState();
}

class _FilterTransaksiScreenState extends State<FilterTransaksiScreen> {
  // Menyimpan status tombol aktif
  bool isPemasukanActive = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Tombol Pemasukan dengan ikon SVG
          _buildFilterButton(
            'Pemasukan',
            isActive: isPemasukanActive,
            icon: 'assets/images/pemasukan2.svg', // Path ke SVG Pemasukan
            onPressed: () {
              setState(() {
                isPemasukanActive = true; // Pemasukan aktif
              });
            },
          ),

          // Tombol Pengeluaran dengan ikon SVG
          _buildFilterButton(
            'Pengeluaran',
            isActive:
                !isPemasukanActive, // Pengeluaran aktif jika Pemasukan tidak aktif
            icon: 'assets/images/pengeluaran2.svg', // Path ke SVG Pengeluaran
            onPressed: () {
              setState(() {
                isPemasukanActive = false; // Pengeluaran aktif
              });
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat tombol dengan style yang lebih modern
  Widget _buildFilterButton(String text,
      {required bool isActive,
      required String icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isActive
            ? Colors.green.shade600 // Warna tombol aktif hijau lebih gelap
            : Colors.white, // Warna tombol tidak aktif putih
        onPrimary: isActive
            ? Colors.white
            : Colors
                .green.shade600, // Warna teks aktif putih, tidak aktif hijau
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Lebih round untuk tombol
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 20.0), // Padding tombol lebih besar
        elevation: 5, // Memberi efek bayangan tombol
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon, // Menggunakan SVG untuk ikon tanpa mengubah warna
            width: 20,
            height: 20,
          ),
          SizedBox(width: 10), // Jarak antara icon dan teks
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter', // Font Inter
              fontSize: 16,
              fontWeight: FontWeight.w600, // Font bold tapi tidak terlalu tebal
              color: isActive
                  ? Colors.black // Teks aktif jadi hitam
                  : Colors.green.shade600, // Teks tidak aktif jadi hijau
            ),
          ),
        ],
      ),
    );
  }
}
