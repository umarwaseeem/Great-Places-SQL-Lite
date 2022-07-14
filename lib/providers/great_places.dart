import 'dart:io';

import "package:flutter/foundation.dart";

import '../helpers/db_helper.dart';
import "../models/place.dart";

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: PlaceLocation(
        "",
        latitude: 0.0,
        longitude: 0.0,
      ),
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      "user_places",
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map(
          (element) => Place(
            id: element["id"],
            title: element["title"],
            image: File(element["image"]),
            location: PlaceLocation(
              "",
              latitude: 0.0,
              longitude: 0.0,
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
