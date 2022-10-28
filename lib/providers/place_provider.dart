import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.lat, pickedLocation.long);
    final updateLocation = PlaceLocation(
      lat: pickedLocation.lat,
      long: pickedLocation.long,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updateLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.lat,
      'loc_lng': newPlace.location.long,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                lat: item['loc_lat'],
                long: item['loc_lng'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  void deletePlaces(String id) {
    _items.removeWhere((element) => element.id == id);
    DBHelper.delete('user_places', id);
    notifyListeners();
  }
}
