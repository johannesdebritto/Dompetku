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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomAppBar(
          color: const Color(0xFF2D2F33),
          elevation: 8,
          child: SizedBox(
            height: 40, // Tetap 30 seperti permintaanmu
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.translate(
                  offset: const Offset(0, -15), // Geser ke atas biar pas
                  child: _buildNavItem(
                    icon: LucideIcons.home,
                    index: 0,
                    label: 'Beranda',
                  ),
                ),
                const SizedBox(width: 1), // ruang tengah
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: _buildNavItem(
                    icon: LucideIcons.history,
                    index: 2,
                    label: 'Riwayat',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    bool isSelected = widget.selectedIndex == index;
    const Color iconColor = Color(0xFFC2E7FF);
    const Color activeBgColor = Color(0xFF004A77);
    const Color labelColor = Color(0xFFC4C7C5);

    return GestureDetector(
      onTap: () => widget.onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? activeBgColor : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          // const SizedBox(height: 0),
          // if (isSelected)
          //   Text(
          //     label,
          //     style: const TextStyle(
          //       color: labelColor,
          //       fontSize: 10,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
