import 'package:flutter/material.dart';
import 'package:flutter_chart_sample/helper.dart';
import 'package:flutter_chart_sample/util.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/legend_form.dart';
import 'package:mp_chart/mp/core/enums/limite_label_postion.dart';
import 'package:mp_chart/mp/core/enums/mode.dart';
import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_chart/mp/core/limit_line.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';

class LineChartBasic extends StatefulWidget {
  @override
  LineChartBasicState createState() => LineChartBasicState();
}

class LineChartBasicState extends State<LineChartBasic> {
  final List<Entry> values = List<Entry>();
  LineChartController _controller;

  void _getInitialData() {
    int _count = 5;

    for (int i = 0; i < _count; i++) {
      values.add(Entry(x: i.toDouble(), y: generateNextRandomValue(25, 5)));
    }
  }

  Stream<Entry> createDataTimesStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));

      yield Entry(x: (values.length).toDouble(), y: generateNextRandomValue((values[values.length - 2].y).toDouble(), 5));
    }
  }

  Stream<Entry> dataStream;

  @override
  void initState() {
    _getInitialData();

    _initController();
    _initLineData();

    dataStream = createDataTimesStream();

    dataStream.listen((data) {
      setState(() {
        values.add(data);
        _initLineData();
      });
    });

    super.initState();
  }

  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 100,
          child: _initLineChart(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 50,
          child: Center(child: Text('Dataset size: ${values.length}')),
        )
      ],
    );
  }

  void _initController() {
    Description desc = Description()..enabled = false;

    LimitLine limitLine01 = LimitLine(60, 'Upper Limit');
    limitLine01.setLineWidth(2);
    limitLine01.enableDashedLine(10, 10, 0);
    limitLine01.labelPosition = (LimitLabelPosition.RIGHT_TOP);
    limitLine01.textSize = (10);
    limitLine01.typeface = Util.EXTRA_BOLD;

    LimitLine limitLine02 = LimitLine(-5, 'Lower Limit');
    limitLine02.setLineWidth(2);
    limitLine02.enableDashedLine(10, 10, 0);
    limitLine02.labelPosition = (LimitLabelPosition.RIGHT_BOTTOM);
    limitLine02.textSize = (10);
    limitLine02.typeface = Util.EXTRA_BOLD;

    _controller = LineChartController(
      axisLeftSettingFunction: (axisLeft, controller) {
        axisLeft
          ..drawLimitLineBehindData = true
          ..addLimitLine(limitLine01)
          ..addLimitLine(limitLine02)
          ..setAxisMaximum(70)
          ..setAxisMinimum(-10);
      },
      axisRightSettingFunction: (axisRight, controller) {
        axisRight.enabled = (false);
      },
      legendSettingFunction: (legend, controller) {
        legend.shape = (LegendForm.LINE);
      },
      xAxisSettingFunction: (xAxis, controller) {
        xAxis
          ..drawLimitLineBehindData = false
          ..position = XAxisPosition.BOTTOM;
      },
      drawGridBackground: false,
      backgroundColor: ColorUtils.WHITE,
      dragXEnabled: true,
      dragYEnabled: true,
      scaleXEnabled: true,
      scaleYEnabled: true,
      pinchZoomEnabled: true,
      description: desc,
    );
  }

  void _initLineData() async {
    LineDataSet set1;

    set1 = LineDataSet(values, 'DataSet 1');

    set1.setDrawIcons(false);

    set1.setColor1(Theme.of(context).accentColor);
    set1.setCircleColor(ColorUtils.BLACK);
    set1.setHighLightColor(ColorUtils.PURPLE);

    set1.setLineWidth(2);
    set1.setCircleRadius(3);

    set1.setDrawCircleHole(false);
    set1.setDrawCircles(false);

    set1.setFormLineWidth(1);
    set1.setFormSize(15);

    set1.setDrawValues(false);
    set1.setValueTextSize(9);

    set1.enableDashedHighlightLine(10, 5, 0);

    set1.setDrawFilled(false);

    set1.setFillColor(ColorUtils.FADE_RED_END);

    set1.setMode(Mode.LINEAR);

    List<ILineDataSet> dataSets = List();
    dataSets.add(set1);

    _controller.data = LineData.fromList(dataSets);
  }

  Widget _initLineChart() {
    LineChart lineChart = LineChart(_controller);

    _controller.animator..reset();

    return lineChart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Line Chart Basic')),
      body: getBody(),
    );
  }
}
