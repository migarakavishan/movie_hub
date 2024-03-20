import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/models/movie_model.dart';
import 'package:movie_hub/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    const Spacer(),
                    const Text(
                      'Movie Hub',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: ApiServices().getPopularMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    List<MovieModel> movies = snapshot.data!;
                    return CarouselSlider(
                      options: CarouselOptions(
                          height: size.height * 0.22, autoPlay: true),
                      items: movies.map((movie) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(movie.backdropPath))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 3,
                                        left: 3,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              movie.title,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                    Positioned(
                                        top: 3,
                                        right: 3,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  movie.voteAverage.toString().substring(0, 3),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow.shade600,
                                                  size: 14,
                                                )
                                              ],
                                            )))
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  })
            ],
          ),
        ));
  }
}
