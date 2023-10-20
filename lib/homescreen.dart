import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart'; // Import FlareActor
import 'package:realtime_text_recognition/list_tyle/list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home App'), // Change the app title
      ),
      drawer: const AppDrawer(),
      body: const Stack(
        children: [
          BackgroundAnimation(), // Add the background animation here
          ProductList(), // Add a product list here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: 'dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Settings',
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

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can replace this with a ListView or GridView of product cards
    return ListView.builder(
      itemCount: 1234, // Number of products
      itemBuilder: (context, index) {
        return PlateNumber(
          productName: 'Violater Details $index',
          productPrice: 1234, // Replace with the actual product details
          // Add product image and other details as needed
        );
      },
    );
  }
}

class PlateNumber extends StatelessWidget {
  final String productName;
  final double productPrice;

  const PlateNumber({
    required this.productName,
    required this.productPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Customize the design of a product card
    return Card(
      child: ListTile(
        title: Text(productName),
        subtitle: Text('\detection${productPrice.toStringAsFixed(2)}'),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle the product order action
          },
          child: const Text('View'),
        ),
      ),
    );
  }
}
