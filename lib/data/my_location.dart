import 'package:geolocator/geolocator.dart';

// geolocator를 이용해 위도, 경도 받아오기

class MyLocation{
  double? latitude2;
  double? longitude2;

  Future<void> getMyCurrentLocation() async{
    LocationPermission permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    }catch(e){
      print('There was a problem with the internet connection.');
    }
  }
}