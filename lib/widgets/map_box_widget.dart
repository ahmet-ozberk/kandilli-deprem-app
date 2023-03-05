import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grock/grock.dart';
import 'package:map_launcher/map_launcher.dart';

openMapsSheet(context, double lat, double lon, String name) async {
    try {
      Coords coords = Coords(lat, lon);
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 0,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: SafeArea(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: "$name Lokasyonu",
                        ),
                        title: Text(
                          map.mapName,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.w600),
                        ),
                        //subtitle: Text(map.mapType.toString()),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SvgPicture.asset(
                            map.icon,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Grock.snackBar(title: "Hata", description: "Bir sorun oluştu. Tekrar deneyin.");
    }
  }