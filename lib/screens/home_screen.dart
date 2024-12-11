import 'package:flutter/material.dart';
import 'package:lab2/widgets/joke_type_card.dart';
import '../services/api_services.dart';
import './jokes_screen.dart';
import './random_joke_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke App"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.casino),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RandomJokeScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              const Center(
                child: Text(
                  "Joke of\nthe Day",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final jokeTypes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 3.5 / 2,
                ),
                itemCount: jokeTypes.length,
                itemBuilder: (context, index) {
                  return JokeTypeCard(
                    jokeType: jokeTypes[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JokesScreen(type: jokeTypes[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
