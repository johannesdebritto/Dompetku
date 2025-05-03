import 'package:flutter/material.dart';

class PemasukanScreen extends StatelessWidget {
  const PemasukanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0), // Padding kiri
      child: Column(
        children: List.generate(5, (index) {
          return Row(
            children: [
              // Kotak dengan icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Colors.green,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              // Teks +Rp 50.000 dan info lainnya
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '+Rp 50.000',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '25 April 2025, 14:30',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pemasukan dari penjualan produk',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
