import 'package:flutter/material.dart';
import 'package:travelbox/views/home.dart';
import 'package:travelbox/views/account.dart';
import 'package:travelbox/views/premium.dart';

class Footbarr extends StatelessWidget {
  const Footbarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      color: Color(0xFFF4F9FB),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          IconButton(
            icon: Icon(Icons.account_circle, color: Color(0xFF1E90FF)),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Account()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFF1E90FF)),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.star, color: Color(0xFF1E90FF)),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pro()),
              );
            },
          ),
        ],
      ),
    );
  }
}