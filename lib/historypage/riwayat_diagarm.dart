import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:dompetku_application/db/db_transaksi.dart'; // Import DBTransaksi

class DiagramScreen extends StatefulWidget {
  DiagramScreen({Key? key}) : super(key: key);

  @override
  State<DiagramScreen> createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  Map<String, double> dataMap = {
    "Pemasukan": 0,
    "Pengeluaran": 0,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.redAccent,
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = DBTransaksi();

    // Ambil data pemasukan
    final pemasukanData = await db.getPemasukan();
    double totalPemasukan = 0.0;
    for (var item in pemasukanData) {
      totalPemasukan += (item['uang_masuk'] ?? 0.0) as double;
    }

    // Ambil data pengeluaran
    final pengeluaranData = await db.getPengeluaran();
    double totalPengeluaran = 0.0;
    for (var item in pengeluaranData) {
      totalPengeluaran += (item['nominal_pengeluaran'] ?? 0.0) as double;
    }

    // Cegah pembagian dengan nol
    if (totalPemasukan == 0 && totalPengeluaran == 0) {
      setState(() {
        dataMap = {
          "Pemasukan": 0,
          "Pengeluaran": 0,
        };
      });
      return;
    }

    setState(() {
      dataMap = {
        "Pemasukan": totalPemasukan,
        "Pengeluaran": totalPengeluaran,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = dataMap["Pemasukan"]! + dataMap["Pengeluaran"]!;
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              PieChart(
                dataMap: dataMap,
                colorList: colorList,
                chartType: ChartType.ring,
                chartRadius: 80,
                ringStrokeWidth: 30,
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
                  final percent =
                      total == 0 ? 0 : (entry.value / total * 100).toInt();
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
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
                          '${entry.key}: $percent%',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
