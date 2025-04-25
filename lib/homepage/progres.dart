import 'package:dompetku_application/card/tabungan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressWidget extends StatelessWidget {
  final double progress;
  const ProgressWidget({super.key, this.progress = 0.3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/tabungan.svg',
                  width: 40, height: 40),
              const SizedBox(width: 5),
              const Text('Progres Tabungan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Lihat semua',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TabunganCardScreen(progress: progress),
          // const EmptyTabunganScreen()
        ],
      ),
    );
  }
}
