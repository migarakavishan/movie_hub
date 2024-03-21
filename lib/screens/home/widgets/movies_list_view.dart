
import 'package:flutter/material.dart';

import '../../../models/movie_model.dart';
import '../../../services/api_service.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Now Playing",
          style: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        FutureBuilder(
            future: ApiServices().getNowPlayingMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              List<MovieModel> movies = snapshot.data!;
              return SizedBox(
                height: 115,
                child: ListView.builder(
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 220,
                          child: Container(
                            width: 220,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        movies[index].posterPath)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movies[index].title,
                                      style: TextStyle(
                                          color: Colors.grey.shade300),
                                    ),
                                    Container(
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
                                              movies[index]
                                                  .voteAverage
                                                  .toString()
                                                  .substring(0, 3),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }
}