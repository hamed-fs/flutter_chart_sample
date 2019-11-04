import 'package:flutter/material.dart';

import 'package:flutter_chart_sample/pages/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:HomePage(),
    );
  }
}
