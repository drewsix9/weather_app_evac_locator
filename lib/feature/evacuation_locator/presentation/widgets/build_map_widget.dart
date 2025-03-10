import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../../core/const/coordinates.dart';
import '../providers/evacuation_locator_provider.dart';

class BuildMapWidget extends StatefulWidget {
  const BuildMapWidget({super.key});

  @override
  State<BuildMapWidget> createState() => _BuildMapWidgetState();
}

class _BuildMapWidgetState extends State<BuildMapWidget> {
  @override
  Widget build(BuildContext context) {
    final evacProvider = context.watch<EvacuationLocatorProvider>();

    return Stack(
      children: [
        FlutterMap(
          mapController: evacProvider.mapController,
          options: MapOptions(
            onMapReady: () {
              context.read<EvacuationLocatorProvider>().setMapControllerReady();
            },
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.drag,
            ),
            initialCenter: boholLatLng,
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            if (evacProvider.points.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: evacProvider.points,
                    strokeWidth: 5,
                    color: Colors.green,
                  ),
                ],
              ),
            Consumer<EvacuationLocatorProvider>(
              builder: (context, provider, child) => MarkerLayer(
                markers: provider.markers,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
