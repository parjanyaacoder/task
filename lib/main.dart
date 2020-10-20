import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<GraphData> graph = <GraphData>[
      GraphData('Jan',45,34,53),
      GraphData('Feb',57,62,56),
      GraphData('March',59,60,82),
      GraphData('April',51,26,38),
      GraphData('May',51,63,38),
      GraphData('June',55,61,82),
      GraphData('July',65,46,88),
      GraphData('Aug',35,16,98),
      GraphData('Sept',45,6,48),
      GraphData('Oct',25,6,98),
      GraphData('Nov',15,26,48),
      GraphData('Dec',85,96,78),

    ];
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text:'Month'),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text:'Days'),
            ),
            legend: Legend(isVisible:true),
            series: <StackedColumnSeries<GraphData,String>>[
              StackedColumnSeries<GraphData,String>(
                dataSource:graph,
                xValueMapper: (GraphData graphData,_) => graphData.month,
                yValueMapper: (GraphData graphData,_) => graphData.a,
                name: 'Present',
              ),
              StackedColumnSeries<GraphData,String>(
                dataLabelSettings: DataLabelSettings(isVisible:true,
                labelAlignment: ChartDataLabelAlignment.auto,
                  labelPosition: ChartDataLabelPosition.inside,
                  angle: 270,
                ),
                name: 'Absent',
                dataLabelMapper: (GraphData graphData,_) => graphData.month,
                dataSource:graph,
                xValueMapper: (GraphData graphData,_) => graphData.month,
                yValueMapper: (GraphData graphData,_) => graphData.b,
              ),
              StackedColumnSeries<GraphData,String>(
                dataSource:graph,
                name: 'Holiday',
                xValueMapper: (GraphData graphData,_) => graphData.month,
                yValueMapper: (GraphData graphData,_) => graphData.c,
              )
              ],


              ),

          ),
        ),

    );
  }
}


class GraphData
{
final String month;
final int a;
final int b;
final int c;

  GraphData(this.month, this.a, this.b, this.c);
}

