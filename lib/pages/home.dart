import 'package:flutter/material.dart';
import 'package:hackathon/pages/weather_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(onStatus: (val) {
        if (val == 'notListening') {
          setState(() => _isListening = false);
        }
      }, onError: (val) => print('onError: $val'));

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
          });
        },
        localeId: 'ko-KR' // STT : text 한글로
      );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

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
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return WeatherScreen(
                            parseWeatherData: widget.parseWeatherData,
                            parseAirPollution: widget.parseAirPollution,
                          );
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var begin = 0.0;
                          var end = 1.0;
                          var curve = Curves.easeInOut;
                          var opacityTween = Tween(begin: begin, end: end).chain(
                            CurveTween(curve: curve),
                          );

                          return FadeTransition(
                            opacity: opacityTween.animate(animation),
                            child: child,
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
                  onPressed: _startListening,
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
                SizedBox(height: 20.0),
                Text(_text),  // 음성 텍스트를 보여줍니다
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                  ),
                  child: Text(
                    '맛집',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
