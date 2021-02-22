import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/widgets/single_weather.dart';
import 'package:weather_app/widgets/slider_dots.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/models/weatherlocation.dart';
import 'package:weather_app/widgets/buildin_transformer.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg;
  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == "Sunny") {
      bgImg = 'assets/sunny.jpg';
    } else if (locationList[_currentPage].weatherType == "Night") {
      bgImg = 'assets/night.jpg';
    } else if (locationList[_currentPage].weatherType == "Rain") {
      bgImg = 'assets/Rain.jpg';
    } else if (locationList[_currentPage].weatherType == "Cloudy") {
      bgImg = 'assets/cloudy.jpeg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onDoubleTap: () {
                print('Menu cliicked');
              },
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(bgImg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(top: 140),
              padding: EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage) SliderDot(true) else SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
              transformer: ScaleAndFadeTransformer(),
              onPageChanged: _onPageChanged,
              viewportFraction: 0.8,
              itemCount: locationList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => SingleWeather(
                index: i,
              ),
            )
          ],
        ),
      ),
    );
  }
}
