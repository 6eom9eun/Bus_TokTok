import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:hackathon/model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  int? temp;
  String? des;
  Widget? icon;
  Widget? pollution;
  Widget? quality;
  double? air;
  double? air2;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);

    Future.delayed(Duration(seconds: 5), () { // 5초 뒤에 다시 Home으로
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    temp = temp2.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    var grade = airData['list'][0]['main']['aqi'];
    var index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition);
    pollution = model.getAirIcon(grade);
    quality = model.airIndex(index);
    air = airData['list'][0]['components']['pm2_5'];
    air2 = airData['list'][0]['components']['pm10'];
    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('BusTokTok',
        style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false, // 자동으로 생성되는 뒤로가기 버튼을 없애는 부분
      ),
      body:GestureDetector( // 화면을 탭했을 때 Home 화면으로 돌아가도록 함
          onTap: () {
            Navigator.pop(context); // 화면을 탭했을 때 Home 화면으로 돌아가도록 함
          },
          child: Stack(
            children: [
              Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 120.0,
                              ),
                              Text(
                                '$cityName',
                                style: GoogleFonts.lato(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(const Duration(minutes: 1),
                                      builder: (context) {
                                        print(getSystemTime());
                                        return Text(
                                          getSystemTime(),
                                          style: GoogleFonts.lato(
                                              fontSize: 16.0,
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        );
                                      }),
                                  Text(
                                    DateFormat('- EEEE,').format(date),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat('d MMM, yyyy').format(date),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp\u2103',
                                style: GoogleFonts.lato(
                                    fontSize: 85.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  icon!,
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '$des',
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white30)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'AQI(대기질 지수)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                pollution!,
                                const SizedBox(
                                  height: 5.0,
                                ),
                                quality!,
                                // Text(
                                //   '$air',
                                //   style: GoogleFonts.lato(
                                //       fontSize: 24.0,
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.white),
                                // ),
                                // Text(
                                //   '㎍/m3',
                                //   style: GoogleFonts.lato(
                                //       fontSize: 14.0,
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.white),
                                // ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$air2',
                                  style: GoogleFonts.lato(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$air',
                                  style: GoogleFonts.lato(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '㎍/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

