import 'package:dompetku_application/historypage/riwayat_filter.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RiwayatGarisScreen extends StatefulWidget {
  const RiwayatGarisScreen({super.key});

  @override
  _RiwayatGarisScreenState createState() => _RiwayatGarisScreenState();
}

class _RiwayatGarisScreenState extends State<RiwayatGarisScreen> {
  final List<double> pemasukanData = [
    3000,
    5000,
    4000,
    7000,
    6500,
    9000,
    12000
  ];
  final List<String> bulanLabels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul'
  ];
  String selectedFilter = '1 Bulan';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RiwayatFilterScreen(
            onFilterChanged: (filter) =>
                setState(() => selectedFilter = filter)),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.withOpacity(0.2), strokeWidth: 1)),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                  index >= 0 && index < bulanLabels.length
                                      ? bulanLabels[index]
                                      : '',
                                  style: const TextStyle(fontSize: 12)));
                        })),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 3000,
                        getTitlesWidget: (value, _) => Text('${value.toInt()}',
                            style: const TextStyle(fontSize: 12)))),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1)),
              minX: 0,
              maxX: (pemasukanData.length - 1).toDouble(),
              minY: 0,
              maxY: pemasukanData.reduce((a, b) => a > b ? a : b) + 2000,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(pemasukanData.length,
                      (i) => FlSpot(i.toDouble(), pemasukanData[i])),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.3),
                            Colors.blue.withOpacity(0.0)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: const [
            Text('Grafik Pemasukan Bulanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Menunjukkan tren dari Januari sampai Juli 2025',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
