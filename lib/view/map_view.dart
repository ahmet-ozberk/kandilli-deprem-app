import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:kandilli_deprem/widgets/map_box_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';

class MapView extends ConsumerWidget {
  final double lat;
  final double lon;
  final String name;
  const MapView({super.key, required this.lat, required this.lon, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'appBarTitle',
          transitionOnUserGestures: true,
          child: Text(
            name,
            style: GoogleFonts.adventPro(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            maxLines: 1,
          ).material(),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(lat, lon),
                zoom: 10,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(lat, lon),
                      builder: (context) {
                        return GrockInfoWidget(
                          message: name,
                          child: const Icon(
                            Icons.location_on_rounded,
                            size: 46,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                child: GrockBlurEffect(
                  borderRadius: 12.borderRadius,
                  opacity: 0.8,
                  blur: 5,
                  child: GrockContainer(
                    onTap: () => openMapsSheet(context, lat, lon, name),
                    height: 50,
                    width: context.width,
                    child: Center(child: Text("Haritada Göster",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.deepPurple,fontWeight: FontWeight.w600),)),
                  ),
                ),
              ).paddingBottomHorizontal(12),
            ),
          ],
        ),
      ),
    );
  }
  
}
