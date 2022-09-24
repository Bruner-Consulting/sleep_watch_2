import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartTab extends StatefulWidget {
  const ChartTab({Key? key}) : super(key: key);

  @override
  State<ChartTab> createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('this is the charts tab page'),
    );
  }
}
