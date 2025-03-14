import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Define a provider that fetches the city name
final locationProvider = FutureProvider<String>((ref) async {
  try {
    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permission denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied';
    }

    // Define location settings for different platforms
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Minimum distance before location updates
    );

    // Get the current position with the new settings
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    // Reverse geocode to get city name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks[0].locality ?? 'City not found';
    } else {
      return 'City not found';
    }
  } catch (e) {
    return 'Error: $e';
  }
});
