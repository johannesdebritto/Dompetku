import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:dompetku_application/db/db_transaksi.dart';

class RiwayatGarisScreen extends StatefulWidget {
  const RiwayatGarisScreen({super.key});

  @override
  State<RiwayatGarisScreen> createState() => _RiwayatGarisScreenState();
}

class _RiwayatGarisScreenState extends State<RiwayatGarisScreen> {
  List<double> totalPerHari = List.filled(30, 0.0);
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    _findStartDateDanLoad();
  }

  Future<void> _findStartDateDanLoad() async {
    final db = DBTransaksi();
    DateTime? foundDate;

    // Mencari tanggal pertama yang punya transaksi (baik pemasukan atau pengeluaran)
    for (int i = 0; i < 365; i++) {
      final date = DateTime.now().subtract(Duration(days: i));
      final tanggal = DateFormat('yyyy-MM-dd').format(date);

      final pemasukan = await db.getPemasukanByTanggal(tanggal);
      final pengeluaran = await db.getPengeluaranByTanggal(tanggal);

      if (pemasukan.isNotEmpty || pengeluaran.isNotEmpty) {
        foundDate = date;
        break;
      }
    }

    if (foundDate != null) {
      final now = DateTime.now();
      final daysSince = now.difference(foundDate).inDays;
      final periodeKe = daysSince ~/ 30;
      final calculatedStart = foundDate.add(Duration(days: periodeKe * 30));

      setState(() {
        startDate = calculatedStart;
      });

      _loadTotalPerHari();
    }
  }

  Future<void> _loadTotalPerHari() async {
    if (startDate == null) return;

    final db = DBTransaksi();
    List<double> totals = [];

    // Load data 30 hari berdasarkan startDate
    for (int i = 0; i < 30; i++) {
      DateTime date = startDate!.add(Duration(days: i));
      String tanggal = DateFormat('yyyy-MM-dd').format(date);

      final pemasukan = await db.getPemasukanByTanggal(tanggal);
      final pengeluaran = await db.getPengeluaranByTanggal(tanggal);

      double totalPemasukan = 0.0;
      for (var item in pemasukan) {
        totalPemasukan += (item['uang_masuk'] ?? 0.0) as double;
      }

      double totalPengeluaran = 0.0;
      for (var item in pengeluaran) {
        totalPengeluaran += (item['nominal_pengeluaran'] ?? 0.0) as double;
      }

      totals.add(totalPemasukan - totalPengeluaran);
    }

    setState(() {
      totalPerHari = totals;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startDate == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Prediksi Keuangan 30 Hari',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 0.5,
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 5,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index % 5 == 0 && index >= 0 && index < 30) {
                        final day = startDate!.add(Duration(days: index));
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(DateFormat('d').format(day)),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    interval: 50000,
                    getTitlesWidget: (value, _) => Text(
                      '${value.toInt()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border:
                    Border.all(color: Colors.black.withOpacity(0.1), width: 1),
              ),
              minX: 0,
              maxX: 29,
              minY: 0,
              maxY: 200000,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    totalPerHari.length,
                    (i) => FlSpot(i.toDouble(), totalPerHari[i]),
                  ),
                  isCurved: false,
                  color: Colors.green,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.3),
                        Colors.green.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.green,
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
