import 'package:apppeliculas_p63/providers/movies_provider.dart';
import 'package:apppeliculas_p63/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//void main() => runApp(const MyApp());
void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ )=> MoviesProvider(), 
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas-P63',
      initialRoute: 'home',
      routes: {
        'home': (_)=>const HomeScreen(),
        'details': (_)=>const DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme( color: Colors.indigo)
      ),
    );
  }
}

