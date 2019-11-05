import 'package:flutter/material.dart';

import 'package:flutter_chart_sample/models/chart_item.dart';
import 'package:flutter_chart_sample/models/library_item.dart';
import 'package:flutter_chart_sample/pages/bar_chart_page.dart';
import 'package:flutter_chart_sample/pages/bezier_line_chart_page.dart';
import 'package:flutter_chart_sample/pages/candle_stick_chart_page.dart';
import 'package:flutter_chart_sample/pages/line_chart_page.dart';
import 'package:flutter_chart_sample/pages/pie_chart_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<LibraryItem> libraryItems = [
    LibraryItem(
      'MP CHARTS',
      [
        ChartItem(
          'Line Chart',
          LineChartPage(),
        ),
        ChartItem(
          'Bar Chart',
          BarChartPage(),
        ),
        ChartItem(
          'Pie Chart',
          PieChartPage(),
        ),
      ],
    ),
    LibraryItem(
      'Bezier Chart',
      [
        ChartItem(
          'Line Chart',
          BezierLineChartPage(),
        )
      ],
    ),
    LibraryItem(
      'Candle Chart',
      [
        ChartItem(
          'Candle Chart',
          CandleChartPage(),
        )
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: _getListItems(context, libraryItems),
        ),
      ),
    );
  }
}

void _showChart(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

List<Widget> _getListItems(
    BuildContext context, List<LibraryItem> libraryItems) {
  return libraryItems
      .map(
        (libraryItem) => ExpansionTile(
          title: Text(
            libraryItem.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: libraryItem.chartItems
              .map(
                (chartItem) => ListTile(
                  title: Text(chartItem.title),
                  onTap: () => _showChart(context, chartItem.screen),
                ),
              )
              .toList(),
        ),
      )
      .toList();
}
