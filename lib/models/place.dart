import "dart:io";

// - /////////////////////////////////////
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation(this.address,
      {required this.latitude, required this.longitude});
}

// - ///////////////////////////////////////

class Place {
  final String title;
  final String id;
  final PlaceLocation location;
  final File image;

  Place({
    required this.title,
    required this.id,
    required this.location,
    required this.image,
  });
}
