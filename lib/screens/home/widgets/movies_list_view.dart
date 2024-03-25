import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/movie_model.dart';
import '../../movie_view/movie_view.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({super.key, required this.title, required this.future});

  final String title;
  final Future<List<MovieModel>> future;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        4,
                        (index) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade900,
                                  highlightColor: Colors.grey.shade800,
                                  child: Container(
                                    width: 90,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )),
                            )),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              List<MovieModel> movies = snapshot.data!;
              return SizedBox(
                height: 140,
                child: ListView.builder(
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieView(
                                        movie: movies[index],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: SizedBox(
                            width: 90,
                            height: 140,
                            child: Stack(
                              children: [
                                Container(
                                  width: 90,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              movies[index].posterPath))),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 90,
                                    height: 28,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Text(
                                      movies[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
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
