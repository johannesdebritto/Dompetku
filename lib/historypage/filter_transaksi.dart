import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pastikan sudah menambahkan package flutter_svg

class FilterTransaksiScreen extends StatefulWidget {
  final bool isPemasukanActive;
  final Function(bool) onFilterChanged;

  const FilterTransaksiScreen({
    Key? key,
    required this.isPemasukanActive,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  State<FilterTransaksiScreen> createState() => _FilterTransaksiScreenState();
}

class _FilterTransaksiScreenState extends State<FilterTransaksiScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterButton(
          'Pemasukan',
          isActive: widget.isPemasukanActive,
          icon: 'assets/images/pemasukan2.svg',
          onPressed: () => widget.onFilterChanged(true),
        ),
        _buildFilterButton(
          'Pengeluaran',
          isActive: !widget.isPemasukanActive,
          icon: 'assets/images/pengeluaran2.svg',
          onPressed: () => widget.onFilterChanged(false),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String text,
      {required bool isActive,
      required String icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green.shade600 : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.green.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 20, height: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.black : Colors.green.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
