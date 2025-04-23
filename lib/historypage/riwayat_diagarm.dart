import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DiagramScreen extends StatefulWidget {
  const DiagramScreen({super.key});

  @override
  State<DiagramScreen> createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  final Map<String, double> dataMap = {
    "Pemasukan": 70,
    "Pengeluaran": 30,
  };

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'DIAGRAM KEUANGAN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              PieChart(
                dataMap: dataMap,
                colorList: colorList,
                chartType: ChartType.ring,
                chartRadius: 120,
                ringStrokeWidth: 30,
                legendOptions: const LegendOptions(showLegends: false),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValues: false,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: dataMap.entries.map((entry) {
                  final color =
                      entry.key == "Pemasukan" ? Colors.green : Colors.red;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical:
                            4), // kasih jarak kecil biar nggak dempet banget
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${entry.key}: ${entry.value.toInt()}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
