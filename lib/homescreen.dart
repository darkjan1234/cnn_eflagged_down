import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart'; // Import FlareActor
import 'package:eflagged_down/list_tyle/list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-FlagDown Assistance'),
      ),
      drawer: const AppDrawer(),
      body: const Stack(
        children: [
          BackgroundAnimation(), // Add the background animation here
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Eflaggeddown system is almost 70%',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundAnimation extends StatelessWidget {
  const BackgroundAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FlareActor(
        'background_animation.flr', // Replace with your animation file path
        alignment: Alignment.center,
        fit: BoxFit.cover,
        animation: 'darkjan', // Replace with the animation you want to use
      ),
    );
  }
}
