import '../google_maps_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({double lat, double long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=18&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$GOOGLE_MAPS_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_MAPS_API_KEY";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
