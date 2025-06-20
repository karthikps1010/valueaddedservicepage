import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines_plus/timelines_plus.dart';

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
      home: const RouteTimelinePage(),
    );
  }
}

class RouteTimelinePage extends StatefulWidget {
  const RouteTimelinePage({super.key});

  @override
  State<RouteTimelinePage> createState() => _RouteTimelinePageState();
}

class _RouteTimelinePageState extends State<RouteTimelinePage> {
  bool isLoading = false;

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
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF3B8B01)),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  isLoading = false;
                });
              });
            },
            child: const Text("Load", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            isLoading
                ? ShimmerBox(height: 20, width: 180)
                : const Text(
              'Route Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            isLoading
                ? Column(
              children: List.generate(2, (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ShimmerBox(height: 50, width: double.infinity),
              )),
            )
                : Column(
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
            const SizedBox(height: 32),
            isLoading
                ? ShimmerBox(height: 20, width: 120)
                : const Text(
              ' Route Stops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: FixedTimeline.tileBuilder(
                  theme:  TimelineThemeData(nodePosition: 0.3),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: busStops.length,
                    oppositeContentsBuilder: (_, index) => SizedBox(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: isLoading
                            ? ShimmerBox(height: 14, width: 60)
                            : Text(
                          busStops[index]['time']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    indicatorBuilder: (_, __) => const DotIndicator(
                        color: Color(0xFF3B8B01), size: 16),
                    connectorBuilder: (_, index, type) => const SolidLineConnector(
                        color: Color(0xFF3B8B01), space: 50),
                    contentsBuilder: (_, index) => SizedBox(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: isLoading
                            ? ShimmerBox(height: 16, width: 100)
                            : Text(
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
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF9EEE10),
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
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Segoe_UI',
                    fontWeight: FontWeight.w500,
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

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerBox({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
