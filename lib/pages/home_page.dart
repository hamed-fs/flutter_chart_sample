import 'package:flutter/material.dart';
import 'package:flutter_chart_sample/pages/bar_chart_page.dart';
import 'package:flutter_chart_sample/pages/line_chart_page.dart';
import 'package:flutter_chart_sample/pages/pie_chart_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(child: _buildList(context)),
          ],
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context) {
  return SingleChildScrollView(
    child: Card(
      child: ExpansionTile(
        title: Text(
          'Flutter Charts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          ListTile(
            title: Text('Bar Chart'),
            onTap: () => _showLineChart(context),
          ),
          ListTile(
            title: Text('Line Chart'),
            onTap: () => _showBarChart(context),
          ),
          ListTile(
            title: Text('Pie Chart'),
            onTap: () => _showPieChart(context),
          ),
        ],
      ),
    ),
  );
}

void _showLineChart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LineChartPage()),
  );
}

void _showBarChart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BarChartPage()),
  );
}

void _showPieChart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PieChartPage()),
  );
}
