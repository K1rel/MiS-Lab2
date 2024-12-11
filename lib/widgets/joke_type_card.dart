import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeTypeCard({
    Key? key,
    required this.jokeType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.blue.shade100,
        child: Center(
          child: Text(
            jokeType,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
