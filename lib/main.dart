import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'view_models/portfolio_view_model.dart';
import 'views/home_page.dart';

void main() {
  // Removes the '#' from the URL for a cleaner look on web
  usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PortfolioViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomePage(),
    );
  }
}
