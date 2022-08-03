import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {},
      ),
    );
  }
}
