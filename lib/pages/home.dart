import 'package:flutter/material.dart';
import 'package:hackathon/pages/weather_screen.dart';

class Home extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  Home({
    Key? key,
    this.parseWeatherData,
    this.parseAirPollution,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'BusTokTok',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.location_searching,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              // 추가 기능을 구현할 수 있습니다.
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WeatherScreen(
                            parseWeatherData: widget.parseWeatherData,
                            parseAirPollution: widget.parseAirPollution,
                          );
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                  ),
                  child: Text(
                    '날씨',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // "음성 입력" 버튼 동작을 추가하세요.
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                  ),
                  child: Text(
                    '음성 입력',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
