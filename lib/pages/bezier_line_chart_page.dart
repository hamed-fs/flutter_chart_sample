import 'package:flutter/material.dart';

import 'package:bezier_chart/bezier_chart.dart';

class BezierLineChartPage extends StatefulWidget {
  @override
  _BezierLineChartPageState createState() => _BezierLineChartPageState();
}

class _BezierLineChartPageState extends State<BezierLineChartPage> {
  final _fromDate = DateTime(2018, 11, 22);
  final _toDate = DateTime.now();

  List<DataPoint<DateTime>> _dataset = List<DataPoint<DateTime>>();

  void initialData() {
    _dataset.add(DataPoint<DateTime>(value: 10, xAxis: DateTime.now().subtract(Duration(days: 2))));
    _dataset.add(DataPoint<DateTime>(value: 50, xAxis: DateTime.now().subtract(Duration(days: 3))));
    _dataset.add(DataPoint<DateTime>(value: 20, xAxis: DateTime.now().subtract(Duration(days: 35))));
    _dataset.add(DataPoint<DateTime>(value: 80, xAxis: DateTime.now().subtract(Duration(days: 36))));
    _dataset.add(DataPoint<DateTime>(value: 14, xAxis: DateTime.now().subtract(Duration(days: 65))));
    _dataset.add(DataPoint<DateTime>(value: 30, xAxis: DateTime.now().subtract(Duration(days: 64))));
  }

  @override
  void initState() {
    initialData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bezier Line Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _buildBezierLineChart(context, _fromDate, _toDate, _dataset),
    );
  }
}

Widget _buildBezierLineChart(BuildContext context, DateTime fromDate, DateTime toDate, List<DataPoint<DateTime>> data) {
  return Center(
    child: Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        bezierChartScale: BezierChartScale.MONTHLY,
        fromDate: fromDate,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            label: 'Duty',
            onMissingValue: (dateTime) {
              if (dateTime.month.isEven) {
                return 10.0;
              }
              return 5.0;
            },
            data: data,
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: true,
          backgroundColor: Theme.of(context).accentColor,
          footerHeight: 30.0,
        ),
      ),
    ),
  );
}
