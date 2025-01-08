import 'package:flutter/material.dart';
import 'package:toonflix/service/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onClick() {
    ApiService api = ApiService();
    api.getTodaysToons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          'Today\'s Webtoon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          IconButton(onPressed: onClick, icon: Icon(Icons.add_box_rounded))
        ],
      ),
    );
  }
}
