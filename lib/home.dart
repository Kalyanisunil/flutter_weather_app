// import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
// import 'package:weather_app/BottomBar.dart';
import 'package:weather_app/consts.dart';
import 'package:weather_app/currentcard.dart';
// import 'package:weather_app/currentcard.dart';
import 'package:weather_app/weathercard.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? weather;
  @override
  void initState() {
    super.initState();
    _fetchWeatherData("Kallambalam,India");
  }

  Future<void> _fetchWeatherData(String cityName) async {
    final Weather w = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      weather = w;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.calendar_month),
            color: Colors.white,
          ),
        ],
        backgroundColor: Color(0xFF0d1b2a),
      ),
      body: _buildWeather(),
    );
  }

  Widget _buildWeather() {
    // DateTime today = DateTime.now();
    if (weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget locationName() {
      return Text(
        weather?.areaName ?? "",
        style: TextStyle(fontSize: 17, color: Colors.white),
      );
    }

    DateTime now = weather!.date!;

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF0d1b2a), // Deep Navy Blue
                Color(0xFF1b263b), // Dark Slate Blue
                Color(0xFF415a77), // Cool Grey Blue
                Color(0xFF778da9),
              ])),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
            child: Column(
              children: [
                // Center(
                //   child: Text(DateFormat(" M/d/y h:mm a").format(now),
                //       style: TextStyle(color: Colors.white, fontSize: 20)),
                // ),
                Center(
                  child: Text(DateFormat(" EEEE").format(now),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: locationName(),
                ),

                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/rainy.png',
                        width: 180,
                        height: 180,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.5),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.5),
                          child: Text(
                            ' ${weather!.temperature!.celsius?.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.5),
                          child: Text(
                            ' ${weather!.weatherDescription}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 110,
                      // ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/windy.png",
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${weather!.windSpeed}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      // Image.asset(
                      //   "assets/images/cloudysunny.png",
                      //   width: 30,
                      //   height: 30,
                      //   color: Colors.white,
                      // ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${weather!.cloudiness}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Image.asset(
                        "assets/icons/windy.png",
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "0.3%",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.hourglass_empty,
                      color: Colors.white,
                    ),
                    Text(
                      "Hourly Forecast",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.5,
                ),
                CarouselSlider(
                  items: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: WeatherCard(
                          iconPath: 'assets/icons/windy.png',
                          condition: "Windy",
                          value: "12"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: WeatherCard(
                          iconPath: 'assets/icons/cloudy.png',
                          condition: "Cloudy",
                          value: "50"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: WeatherCard(
                          iconPath: 'assets/icons/sun.png',
                          condition: "Humidity",
                          value: "78"),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
