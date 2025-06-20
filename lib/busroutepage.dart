import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines_sample/main.dart'; // for RouteTimelinePage import

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({super.key});
  @override
  State<BusRoutePage> createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {
  bool isLoading = true;

  final _routes = const [
    _RouteCardData(
      network: 'Aluva/International 8B',
      stopName: 'Aluva',
      lineNumber: '2',
      destination: 'International Airport',
      scheduledTime: '17:31:00',
      icon: Icons.directions_bus,
    ),
    _RouteCardData(
      network: 'Aluva/International 32B',
      stopName: 'Aluva',
      lineNumber: '8',
      destination: 'International Airport',
      scheduledTime: '17:35:52',
      icon: Icons.directions_bus,
    ),
    _RouteCardData(
      network: 'Aluva/International 64B',
      stopName: 'Aluva',
      lineNumber: '3',
      destination: 'International Airport',
      scheduledTime: '17:40:28',
      icon: Icons.directions_bus,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // initial 3s shimmer
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  void _toggleShimmer() {
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metro Bus Routes'),
        actions: [
          IconButton(
            icon: Icon(isLoading ? Icons.visibility_off : Icons.refresh),
            tooltip: 'Toggle Shimmer',
            onPressed: _toggleShimmer,
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
        itemCount: _routes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) {
          if (isLoading) {
            return _buildShimmerCard(context);
          } else {
            return _buildDataCard(context, _routes[i]);
          }
        },
      ),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 2 * 12;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network placeholder (70% width, 20px height)
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: cardWidth * 0.5,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: cardWidth * 0.25,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // StopName placeholder (50% width, 24px height)
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: cardWidth * 0.5,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: cardWidth * 0.15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // Destination placeholder (60% width, 18px height)
            Container(
              width: cardWidth * 0.6,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(BuildContext context, _RouteCardData r) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RouteTimelinePage()),
      ),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Network + time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      r.network,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Color(0xFF3B8B01),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.clock_fill, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(r.scheduledTime, style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Stop name + line number
              Row(
                children: [
                  Expanded(
                    child: Text(
                      r.stopName,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    r.lineNumber,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Icon + destination
              Row(
                children: [
                  Icon(r.icon, size: 20, color: const Color(0xFF3B8B01)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      r.destination,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteCardData {
  final String network, stopName, lineNumber, destination, scheduledTime;
  final IconData icon;
  const _RouteCardData({
    required this.network,
    required this.stopName,
    required this.lineNumber,
    required this.destination,
    required this.scheduledTime,
    required this.icon,
  });
}
