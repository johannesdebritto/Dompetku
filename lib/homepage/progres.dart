import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ProgressWidget extends StatefulWidget {
  final double progress;
  const ProgressWidget({super.key, this.progress = 0.3});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final target = 500000.0;

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(16, 0, 16, 16), // Padding kanan tetap ada
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
          const SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width -
                90, // Atur lebar box di sini
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6EC),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Tabungan Maggot',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatter.format(0),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(formatter.format(target),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                Stack(
                  children: [
                    Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10))),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width *
                              widget.progress -
                          48, // Mengurangi sedikit lebar progress bar agar tidak mepet
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                            '${(widget.progress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Target Tercapai: 1 Agustus 2025',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
