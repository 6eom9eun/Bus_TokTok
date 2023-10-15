import 'package:flutter/material.dart';
import 'package:hackathon/data/my_location.dart';
import 'package:hackathon/data/network.dart';
import 'package:hackathon/pages/home.dart'; // Import the Home widget
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '09530d1ccfae5c1d0f1d1d82d5027b94';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Home(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BusTokTok',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0), // 이름과 로딩 바 사이의 간격 조절
            Center(
              child: SpinKitRing(
                color: Colors.white,
                size: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
