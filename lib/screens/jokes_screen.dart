import 'package:flutter/material.dart';
import 'package:lab2/widgets/error_message.dart';
import '../services/api_services.dart';
import '../models/joke.dart';
import '../widgets/joke_card.dart';

class JokesScreen extends StatelessWidget {
  final String type;

  const JokesScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$type Jokes"),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: LinearProgressIndicator(
              minHeight: 3,
            ));
          } else if (snapshot.hasError) {
            return const ErrorMessage(message: "Failed to load jokes.");
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeCard(joke: jokes[index]);
              },
            );
          }
        },
      ),
    );
  }
}
