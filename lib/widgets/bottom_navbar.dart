import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavbarScreen extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final int jumlahTombol;

  const BottomNavbarScreen({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.jumlahTombol,
  }) : super(key: key);

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: LucideIcons.home,
              index: 0,
            ),
            const SizedBox(width: 40), // ruang kosong di tengah
            _buildNavItem(
              icon: LucideIcons.history,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    bool isSelected = widget.selectedIndex == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated Size untuk membuat perubahan ukuran lebih smooth
        AnimatedSize(
          duration: const Duration(milliseconds: 200), // Durasi animasi
          curve: Curves.easeInOut, // Kurva animasi
          child: IconButton(
            icon: Icon(
              icon,
              color: isSelected ? Colors.blueAccent : Colors.grey[700],
              size: isSelected ? 30 : 24, // Perbesar ukuran saat aktif
            ),
            onPressed: () => widget.onItemTapped(index),
          ),
        ),
        // Animated Container untuk underline
        AnimatedContainer(
          duration:
              const Duration(milliseconds: 200), // Durasi animasi underline
          curve: Curves.easeInOut,
          width: isSelected ? 30 : 0, // Lebar underline berubah saat aktif
          height: 2, // Tinggi underline
          color: Colors.blueAccent, // Warna underline
        ),
      ],
    );
  }
}
