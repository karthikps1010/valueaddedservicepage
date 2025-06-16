
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:timelines_sample/main.dart';
class BusRoutePage extends StatelessWidget {
  BusRoutePage({super.key});


  @override
  Widget build(BuildContext context) {
    final routes = const [
      _RouteCardData(
          network: 'Berlin/Brandenburg VBB',
          stopName: 'U Kaiserdamm (Berlin)',
          lineNumber: '2',
          destination: 'S+U Pankow (Berlin)',
          scheduledTime: '17:31:00',
          icon: Icons.train),
      _RouteCardData(
          network: 'Poznań ZTM',
          stopName: 'Polna [PONA71]',
          lineNumber: '8',
          destination: 'Ogrody',
          scheduledTime: '17:27:52',
          icon: Icons.directions_bus),
      _RouteCardData(
          network: 'Poznań ZTM',
          stopName: 'Politechnika [PP72]',
          lineNumber: '3',
          destination: 'Błażeja',
          scheduledTime: '17:30:28',
          icon: Icons.tram),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Bus/Tram Routes')),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: routes.length,
        itemBuilder: (ctx, i) {
          final r = routes[i];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) =>  RouteTimelinePage()),
              );            },
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.fromLTRB(12, 15, 12, 0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(r.network,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        Row(children: [
                          const Icon(CupertinoIcons.clock_fill,
                              size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(r.scheduledTime,
                              style: const TextStyle(color: Colors.green)),
                        ])
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      Expanded(
                          child: Text(r.stopName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600))),
                      Text(r.lineNumber,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary)),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Icon(r.icon,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(r.destination,
                              style: const TextStyle(fontSize: 14))),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
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
