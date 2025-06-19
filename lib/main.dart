//
// import 'package:flutter/material.dart';
// import 'package:timelines_plus/timelines_plus.dart';
// import 'package:bottom_sheet/bottom_sheet.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bus Route Bottom Sheet',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   void _showBusRouteSheet(BuildContext context) {
//     showFlexibleBottomSheet(
//       minHeight: 0.2,
//       initHeight: 0.6,
//       maxHeight: 0.9,
//       context: context,
//       isSafeArea: true,
//       anchors: const [0.2, 0.6, 0.9],
//       builder: (context, scrollController, bottomSheetOffset) {
//         return BusRouteBottomSheet(scrollController: scrollController);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Bus Routes')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _showBusRouteSheet(context),
//           child: const Text('Show Route Timeline'),
//         ),
//       ),
//     );
//   }
// }
//
// class BusRouteBottomSheet extends StatelessWidget {
//   final ScrollController scrollController;
//   const BusRouteBottomSheet({super.key, required this.scrollController});
//
//   static const List<Map<String, String>> busStops = [
//     {"time": "08:00 AM", "stop": "Aluva"},
//     {"time": "12:30 PM", "stop": "Pulinchodu"},
//     {"time": "01:00 PM", "stop": "Companypady"},
//     {"time": "01:15 PM", "stop": "Ambattukavu"},
//     {"time": "01:30 PM", "stop": "Muttom"},
//     {"time": "01:45 PM", "stop": "Kalamaserry"},
//     {"time": "02:00 PM", "stop": "Cusat"},
//     {"time": "02:15 PM", "stop": "Pathadipalam"},
//     {"time": "02:30 PM", "stop": "Edapally"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white, // white canvas
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // DRAG HANDLE
//               const SizedBox(height: 12),
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//
//               // OVERVIEW TITLE
//               const SizedBox(height: 16),
//               const Text(
//                 'Route Overview',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Montserrat',
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               // OVERVIEW CARDS STACKED VERTICALLY
//               Column(
//                 children: const [
//                   _OverviewCard(
//                     icon: Icons.directions_bus,
//                     iconColor: Colors.green,
//                     title: 'Downtown Express',
//                     subtitle: 'Route 22',
//                   ),
//                   SizedBox(height: 12),
//                   _OverviewCard(
//                     icon: Icons.access_time,
//                     iconColor: Colors.green,
//                     title: 'Current Status',
//                     subtitle: 'Arriving in 5 min',
//                   ),
//                 ],
//               ),
//
//               // STOPS TITLE
//               const SizedBox(height: 32),
//               // TITLE
//               const Text(
//                 'Route Timeline',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Montserrat',
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // SCROLLABLE TIMELINE
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: FixedTimeline.tileBuilder(
//                     theme: TimelineThemeData(nodePosition: 0.35),
//                     builder: TimelineTileBuilder.connected(
//                       connectionDirection: ConnectionDirection.before,
//                       itemCount: busStops.length,
//
//                       // LEFT: time label
//                       oppositeContentsBuilder: (_, index) => SizedBox(
//                         height: 80,
//                         child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 20),
//                             child: Text(
//                               busStops[index]['time']!,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[800],
//                                 fontFamily: 'Montserrat',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // DOT + LINE
//                       indicatorBuilder: (_, __) => const OutlinedDotIndicator(
//                           color: Colors.green, size: 16),
//                       // 2) Add vertical padding around each connector
//                       connectorBuilder: (context, index, connectorType) {
//                         // only pad between two nodes
//                         final topGap =
//                             connectorType == ConnectorType.start ? 0.0 : 5.0;
//                         final bottomGap =
//                             connectorType == ConnectorType.end ? 0.0 : 5.0;
//                         return Padding(
//                           padding:
//                               EdgeInsets.only(top: topGap, bottom: bottomGap),
//                           child: const SolidLineConnector(
//                             color: Colors.green,
//                           ),
//                         );
//                       },
//                       // RIGHT: stop name
//                       contentsBuilder: (_, index) => SizedBox(
//                         height: 80,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20),
//                             child: Text(
//                               busStops[index]['stop']!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _OverviewCard extends StatelessWidget {
//   final IconData icon;
//   final String title, subtitle;
//   final Color iconColor; // new
//
//   const _OverviewCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.iconColor, // default
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity, // full width
//       padding: const EdgeInsets.all(12),
//       // decoration: BoxDecoration(
//       //   color: Colors.grey[100],        // light card
//       //   borderRadius: BorderRadius.circular(8),
//       //   boxShadow: const [
//       //     BoxShadow(
//       //       color: Colors.black12,
//       //       blurRadius: 4,
//       //       offset: Offset(0, 2),
//       //     )
//       //   ],
//       // ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             padding: const EdgeInsets.all(8),
//             child: Icon(icon, color: Colors.green, size: 30),
//           ),
//           const SizedBox(width: 12),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.black87,
//                     fontSize: 18,
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 14 ,
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:timelines_sample/busroutepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Routes Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}

/// The initial screen with a button to navigate to the timeline page.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openTimeline(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RouteTimelinePage()),
    );
  }

  void _openBusroute(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) =>  BusRoutePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Routes')),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => _openTimeline(context),
          onPressed: () => _openBusroute(context),
          child: const Text('Show Route Timeline'),
        ),
      ),
    );
  }
}

/// A standalone full‐screen page showing your “Route Overview” + timeline.
class RouteTimelinePage extends StatelessWidget {
  const RouteTimelinePage({super.key});

  static const List<Map<String, String>> busStops = [
    {"time": "08:00 AM", "stop": "Aluva"},
    {"time": "12:30 PM", "stop": "Pulinchodu"},
    {"time": "01:00 PM", "stop": "Companypady"},
    {"time": "01:15 PM", "stop": "Ambattukavu Airport"},
    {"time": "01:30 PM", "stop": "Muttom"},
    {"time": "01:45 PM", "stop": "Kalamaserry"},
    {"time": "02:00 PM", "stop": "Cusat"},
    {"time": "02:15 PM", "stop": "Pathadipalam"},
    {"time": "02:30 PM", "stop": "Edapally"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(surfaceTintColor: Colors.white,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Color(0xFF3B8B01),
    ),),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OVERVIEW SECTION
            const Text(
              'Route Overview',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: const [
                _OverviewCard(
                  icon: Icons.directions_bus,
                  iconColor: Colors.green,
                  title: 'Downtown Express ',
                  subtitle: 'Route 22',
                ),
                SizedBox(height: 12),
                _OverviewCard(
                  icon: Icons.access_time,
                  iconColor: Colors.green,
                  title: 'Current Status',
                  subtitle: 'Arriving in 5 min',
                ),
              ],
            ),

            // TIMELINE SECTION
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ' Route Stops',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            // Expanded timeline
            Expanded(
              child: SingleChildScrollView(
                child: FixedTimeline.tileBuilder(
                  theme:  TimelineThemeData(nodePosition: 0.30),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: busStops.length,

                    // LEFT: time label
                    oppositeContentsBuilder: (_, index) => SizedBox(
                      height: 100,
                      // width: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          busStops[index]['time']!,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Montserrat',fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // DOT + LINE (green, with padding)
                    indicatorBuilder: (_, __) =>
                    const DotIndicator(color: Color(0xFF3B8B01), size: 16),
                    connectorBuilder: (context, index, connectorType) {
                      final topGap =
                      connectorType == ConnectorType.start ? 0.0 : 10.0;
                      final bottomGap =
                      connectorType == ConnectorType.end ? 0.0 : 10.0;
                      return Padding(
                        padding:
                        EdgeInsets.only(top: topGap, bottom: bottomGap),
                        child: const SolidLineConnector(color:Color(0xFF3B8B01),space: 50,),
                      );
                    },

                    // RIGHT: stop name
                    contentsBuilder: (_, index) => SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          busStops[index]['stop']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable card showing an icon, title and subtitle.
class _OverviewCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title, subtitle;

  const _OverviewCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      // decoration: BoxDecoration(
      //   color: Colors.grey[100],
      //   borderRadius: BorderRadius.circular(8),
      //   boxShadow: const [
      //     BoxShadow(
      //       color: Colors.black12,
      //       blurRadius: 4,
      //       offset: Offset(0, 2),
      //     )
      //   ],
      // ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF9EEE10),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: 'Montserrat',fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Segoe_UI',fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
