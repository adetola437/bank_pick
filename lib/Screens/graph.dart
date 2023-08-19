// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Graph extends StatefulWidget {
//   const Graph({super.key});

//   @override
//   State<Graph> createState() => _GraphState();
// }

// class _GraphState extends State<Graph> {
//   List<DataPoint> dataPoints = [
//     const DataPoint(month: 'Jan', value: 30),
//     const DataPoint(month: 'Feb', value: 50),
//     const DataPoint(month: 'Mar', value: 40),
//     const DataPoint(month: 'Apr', value: 70),
//     const DataPoint(month: 'May', value: 60),
//     const DataPoint(month: 'Jun', value: 80),
//   ];

//   String selectedMonth = 'Jan';
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 300,
//           child: SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             series: <ChartSeries>[
//               LineSeries<DataPoint, String>(
//                 dataSource: dataPoints,
//                 xValueMapper: (DataPoint point, _) => point.month,
//                 yValueMapper: (DataPoint point, _) => point.value,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 50,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: dataPoints.length,
//             itemBuilder: (context, index) {
//               final point = dataPoints[index];

//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedMonth = point.month!;
//                   });
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: selectedMonth == point.month
//                           ? Colors.blue
//                           : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(4),
//                     color: selectedMonth == point.month
//                         ? Colors.blue.withOpacity(0.2)
//                         : null,
//                   ),
//                   child: Text(
//                     point.month!,
//                     style: TextStyle(
//                       color: selectedMonth == point.month
//                           ? Colors.blue
//                           : Colors.black,
//                       fontWeight:
//                           selectedMonth == point.month ? FontWeight.bold : null,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DataPoint {
//   final String? month;
//   final double? value;

//   const DataPoint({this.month, this.value});
// }
