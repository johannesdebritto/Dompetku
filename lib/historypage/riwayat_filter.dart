import 'package:flutter/material.dart';

class RiwayatFilterScreen extends StatefulWidget {
  final Function(String) onFilterChanged;

  RiwayatFilterScreen({super.key, required this.onFilterChanged});

  @override
  State<RiwayatFilterScreen> createState() => _RiwayatFilterScreenState();
}

class _RiwayatFilterScreenState extends State<RiwayatFilterScreen> {
  String selectedFilter = '1 Bulan';

  void _setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    widget.onFilterChanged(filter); // Kirim ke parent
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['1 Bulan', '3 Bulan', '1 Tahun'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () => _setFilter(filter),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isSelected ? Colors.green.shade600 : Colors.grey[300],
              foregroundColor: isSelected ? Colors.white : Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(filter),
          ),
        );
      }).toList(),
    );
  }
}
