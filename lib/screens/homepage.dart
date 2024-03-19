import 'package:flutter/material.dart';
import 'package:movie_hub/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: FilledButton(
              onPressed: () {
                ApiServices().getPopularMovies();
              },
              child: const Text("Get Popular Movies"))),
    );
  }
}
