import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Pastikan sudah menambahkan package lucide_icons

class FilterTransaksiScreen extends StatefulWidget {
  const FilterTransaksiScreen({super.key});

  @override
  State<FilterTransaksiScreen> createState() => _FilterTransaksiScreenState();
}

class _FilterTransaksiScreenState extends State<FilterTransaksiScreen> {
  // Menyimpan status tombol aktif
  bool isPemasukanActive = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Tombol Pemasukan
          _buildFilterButton(
            'Pemasukan',
            isActive: isPemasukanActive,
            icon: LucideIcons.plusCircle,
            onPressed: () {
              setState(() {
                isPemasukanActive = true; // Pemasukan aktif
              });
            },
          ),

          // Tombol Pengeluaran
          _buildFilterButton(
            'Pengeluaran',
            isActive:
                !isPemasukanActive, // Pengeluaran aktif jika Pemasukan tidak aktif
            icon: LucideIcons.minusCircle,
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

  // Fungsi untuk membuat tombol dengan style yang sesuai
  Widget _buildFilterButton(String text,
      {required bool isActive,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isActive
            ? Colors.green
            : Colors.white, // Warna tombol aktif hijau, tidak aktif putih
        onPrimary: isActive
            ? Colors.white
            : Colors.green, // Warna teks aktif putih, tidak aktif hijau
        side:
            const BorderSide(color: Colors.green, width: 3), // Garis tepi hijau
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Sudut tumpul
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 20.0), // Padding tombol
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isActive
                  ? Colors.white
                  : Colors.green), // Warna icon sesuai status aktif
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter', // Font Inter
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
