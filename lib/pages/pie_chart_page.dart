import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chart_sample/util.dart';
import 'package:mp_chart/mp/chart/pie_chart.dart';
import 'package:mp_chart/mp/controller/pie_chart_controller.dart';
import 'package:mp_chart/mp/core/common_interfaces.dart';
import 'package:mp_chart/mp/core/data/pie_data.dart';
import 'package:mp_chart/mp/core/data_set/pie_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/entry/pie_entry.dart';
import 'package:mp_chart/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_chart/mp/core/enums/legend_orientation.dart';
import 'package:mp_chart/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_chart/mp/core/highlight/highlight.dart';
import 'package:mp_chart/mp/core/poolable/point.dart';
import 'package:mp_chart/mp/core/render/pie_chart_renderer.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import 'package:mp_chart/mp/core/value_formatter/percent_formatter.dart';

class PieChartBasic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartBasicState();
}

class PieChartBasicState extends State<PieChartBasic> implements OnChartValueSelectedListener {
  PieChartController _controller;
  PercentFormatter _formatter = PercentFormatter();
  int _count = 4;
  double _range = 10.0;

  @override
  void initState() {
    _initController();
    _initPieData(_count, _range);

    super.initState();
  }

  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(right: 0, left: 0, top: 0, bottom: 100, child: PieChart(_controller)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _count.toDouble(),
                            min: 0,
                            max: 25,
                            onChanged: (value) {
                              _count = value.toInt();
                              _initPieData(_count, _range);
                            })),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$_count',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorUtils.BLACK, fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _range,
                            min: 0,
                            max: 200,
                            onChanged: (value) {
                              _range = value;
                              _initPieData(_count, _range);
                            })),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        '${_range.toInt()}',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorUtils.BLACK, fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  final List<String> PARTIES = List()..add('Party A')..add('Party B')..add('Party C')..add('Party D')..add('Party E')..add('Party F')..add('Party G')..add('Party H')..add('Party I')..add('Party J')..add('Party K')..add('Party L')..add('Party M')..add('Party N')..add('Party O')..add('Party P')..add('Party Q')..add('Party R')..add('Party S')..add('Party T')..add('Party U')..add('Party V')..add('Party W')..add('Party X')..add('Party Y')..add('Party Z');

  void _initController() {
    Description desc = Description()..enabled = false;
    _controller = PieChartController(
        legendSettingFunction: (legend, controller) {
          _formatter.setPieChartPainter(controller);
          legend
            ..verticalAlignment = (LegendVerticalAlignment.TOP)
            ..horizontalAlignment = (LegendHorizontalAlignment.RIGHT)
            ..orientation = (LegendOrientation.VERTICAL)
            ..drawInside = (false)
            ..xEntrySpace = (7)
            ..yEntrySpace = (0)
            ..yOffset = (0);
        },
        rendererSettingFunction: (renderer) {
          (renderer as PieChartRenderer)
            ..setHoleColor(ColorUtils.WHITE)
            ..setTransparentCircleColor(ColorUtils.WHITE)
            ..setTransparentCircleAlpha(110)
            ..setEntryLabelColor(ColorUtils.WHITE)
            ..setEntryLabelTextSize(12);
        },
        rotateEnabled: true,
        drawHole: true,
        drawCenterText: true,
        extraLeftOffset: 5,
        extraTopOffset: 10,
        extraRightOffset: 5,
        extraBottomOffset: 5,
        usePercentValues: true,
        centerText: _generateCenterSpannableText(),
        highLightPerTapEnabled: true,
        selectionListener: this,
        holeRadiusPercent: 58.0,
        transparentCircleRadiusPercent: 61,
        description: desc);
  }

  void _initPieData(int count, double range) async {
    List<PieEntry> entries = List();

    for (int i = 0; i < count; i++) {
      entries.add(PieEntry(value: ((Random().nextDouble() * range) + range / 5), label: PARTIES[i % PARTIES.length]));
    }

    PieDataSet dataSet = PieDataSet(entries, 'Election Results');

    dataSet.setDrawIcons(false);

    dataSet.setSliceSpace(3);
    dataSet.setIconsOffset(MPPointF(0, 40));
    dataSet.setSelectionShift(5);

    List<Color> colors = List();
    for (Color c in ColorUtils.VORDIPLOM_COLORS) colors.add(c);
    for (Color c in ColorUtils.JOYFUL_COLORS) colors.add(c);
    for (Color c in ColorUtils.COLORFUL_COLORS) colors.add(c);
    for (Color c in ColorUtils.LIBERTY_COLORS) colors.add(c);
    for (Color c in ColorUtils.PASTEL_COLORS) colors.add(c);
    colors.add(ColorUtils.HOLO_BLUE);
    dataSet.setColors1(colors);

    _controller.data = PieData(dataSet);
    _controller.data
      ..setValueFormatter(_formatter)
      ..setValueTextSize(11)
      ..setValueTextColor(ColorUtils.WHITE)
      ..setValueTypeface(Util.LIGHT);

    setState(() {});
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}

  String _generateCenterSpannableText() {
    return 'Pie Chart Basic';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pie Chart Basic')),
      body: getBody(),
    );
  }
}
