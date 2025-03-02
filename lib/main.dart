import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/search/presentation/providers/suggestion_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/location_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

import 'feature/single_weather/presentation/screens/single_weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "assets/.env");
    print('Environment variables loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SuggestionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather_app_evac_locator',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const SingleWeatherScreen(),
    );
  }
}
