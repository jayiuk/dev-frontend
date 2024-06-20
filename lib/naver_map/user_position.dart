import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';

class LocationService {
  final NaverMapController mapController;
  NMarker? _currentLocationMarker;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationService(this.mapController) {
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      // 초기 위치 설정
      LocationData locationData = await location.getLocation();
      _currentLocationMarker = NMarker(
        id: 'currentLocation',
        position: NLatLng(locationData.latitude!, locationData.longitude!),
        size: const NSize(36, 36), // 마커 크기 설정
        icon: const NOverlayImage.fromAssetImage(
            'assets/images/current_location.png'),
      );

      mapController.updateCamera(
        NCameraUpdate.withParams(
          target: NLatLng(locationData.latitude!, locationData.longitude!),
          zoom: 17.8,
        ),
      );
      mapController.addOverlay(_currentLocationMarker!);

      // 위치 변화 감지 설정
      location.onLocationChanged.listen((LocationData res) {
        if (_currentLocationMarker != null) {
          mapController.getLocationOverlay();
        }
        _currentLocationMarker = NMarker(
          id: 'currentLocation',
          position: NLatLng(res.latitude!, res.longitude!),
          size: const NSize(36, 36), // 마커 크기 설정
          icon: const NOverlayImage.fromAssetImage(
              'assets/images/current_location.png'),
        );
        mapController.addOverlay(_currentLocationMarker!);
      });
    } catch (e) {
      print('Error while getting location: $e');
    }
  }
}
