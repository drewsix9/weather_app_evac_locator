import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../data/model/weather_response/weather_response.dart';
import '../providers/theme_provider.dart';

class ComfortLevelWidget extends StatelessWidget {
  final WeatherResponse? weatherResponse;
  const ComfortLevelWidget({
    super.key,
    this.weatherResponse,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final dividerColor = Theme.of(context).dividerColor;
    final firstGradientColor = isDarkMode
        ? CustomDarkColors.firstGradientColor
        : CustomColors.firstGradientColor;
    final secondGradientColor = isDarkMode
        ? CustomDarkColors.secondGradientColor
        : CustomColors.secondGradientColor;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherResponse!.current!.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      progressBarWidth: 12,
                      trackWidth: 12,
                      handlerSize: 0,
                    ),
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humidity",
                      bottomLabelStyle: TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.5,
                        color: textColor,
                      ),
                      mainLabelStyle: TextStyle(
                        color: textColor,
                      ),
                    ),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                      progressBarColors: [
                        firstGradientColor,
                        secondGradientColor,
                      ],
                      trackColor: Colors.grey,
                      hideShadow: true,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Feels Like ",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "${weatherResponse!.current!.feelsLike}°",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    margin: EdgeInsets.only(left: 40, right: 40),
                    color: dividerColor,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "UV Index ",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "${weatherResponse!.current!.uvi}",
                          style: TextStyle(
                            fontSize: 14,
                            height: 0.8,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
