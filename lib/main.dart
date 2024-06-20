import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube/ui.dart';
import 'package:youtube/viewmode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => YouTubeViewModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'YouTube Search',
            theme: themeProvider.currentTheme,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
);

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;
  bool _isDarkMode = false;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = lightTheme;
    } else {
      _currentTheme = darkTheme;
    }
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}