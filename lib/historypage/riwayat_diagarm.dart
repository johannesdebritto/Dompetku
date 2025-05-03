import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DiagramScreen extends StatefulWidget {
  DiagramScreen({Key? key}) : super(key: key);

  @override
  State<DiagramScreen> createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  final Map<String, double> dataMap = {
    "Pemasukan": 70,
    "Pengeluaran": 30,
  };

  final colorList = <Color>[
    Colors.greenAccent, // More vibrant green
    Colors.redAccent, // More vibrant red
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black, // Changed the box color to black
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.5), // Darker shadow for modern effect
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'DIAGRAM KEUANGAN',
                style: TextStyle(
                  fontSize: 22, // Increased font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Colors.white, // Changed text color to white
                ),
              ),
              SizedBox(height: 20),
              PieChart(
                dataMap: dataMap,
                colorList: colorList,
                chartType: ChartType.ring,
                chartRadius: 80, // Ukuran chart
                ringStrokeWidth: 30, // Ketebalan ring
                legendOptions: LegendOptions(showLegends: false),
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValues: false,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: dataMap.entries.map((entry) {
                  final color = entry.key == "Pemasukan"
                      ? Colors.greenAccent
                      : Colors.redAccent;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4), // Small vertical spacing
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
                        SizedBox(width: 8),
                        Text(
                          '${entry.key}: ${entry.value.toInt()}%',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // White text for labels
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
