// ignore_for_file: must_be_immutable

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class SelectionMapView extends StatelessWidget {
  SelectionMapView({
    this.localizationObject,
    this.canChangeLocalization = true,
  });

  LocalizationObject? localizationObject;

  GoogleMapController? mapController;
  final bool canChangeLocalization;

  void _onMapCreated(GoogleMapController controller, Set<Marker> markers) {
    mapController = controller;
    if (localizationObject != null) {
      markersStream.add(
        {
          Marker(
            markerId: const MarkerId('testMarker'),
            position: localizationObject!.latLng!,
            infoWindow: InfoWindow(
              title: localizationObject!.localizationString,
            ),
          ),
        },
      );
    }
  }

  Set<Marker> markers = {};

  Set<Marker> defaultMarker = {};

  LatLng? pinLocalization;

  final BehaviorSubject<Set<Marker>> markersStream = BehaviorSubject.seeded({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose localization'),
        actions: [
          if (canChangeLocalization)
            IconButton(
              onPressed: () async {
                Navigator.pop(
                  context,
                  localizationObject,
                );
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
            )
        ],
      ),
      body: AsyncBuilder<Set<Marker>>(
        stream: markersStream.stream,
        builder: (context, snapshot) {
          if (snapshot == null) {
            return const SizedBox();
          }
          if (mapController != null) {
            Future.delayed(const Duration(milliseconds: 50))
                .then((value) => mapController!.showMarkerInfoWindow(const MarkerId('testMarker')));
          }
          return Stack(
            children: [
              GoogleMap(
                markers: snapshot,
                onTap: (LatLng latLng) async {
                  if (!canChangeLocalization) {
                    return;
                  }
                  pinLocalization = latLng;
                  final placeMarks = await placemarkFromCoordinates(
                    pinLocalization!.latitude,
                    pinLocalization!.longitude,
                    localeIdentifier: 'pl',
                  );
                  String localizationString =
                      '${placeMarks.first.name!} ${placeMarks.first.street!} ${placeMarks.first.country!}';

                  localizationObject = LocalizationObject(latLng: latLng, localizationString: localizationString);
                  markersStream.add(
                    {
                      Marker(
                        markerId: const MarkerId('testMarker'),
                        position: latLng,
                        infoWindow: InfoWindow(
                          title: localizationString,
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    },
                  );
                },
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (controller) => _onMapCreated(controller, markers),
                initialCameraPosition: CameraPosition(
                  target: localizationObject?.latLng ?? const LatLng(12, 13),
                  zoom: 10,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LocalizationObject {
  LocalizationObject({
    this.latLng,
    required this.localizationString,
  });

  LatLng? latLng;
  final String localizationString;
}
