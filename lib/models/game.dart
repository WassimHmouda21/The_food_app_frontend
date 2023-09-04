import 'package:flutter/material.dart';

class Game {
  //att
  final String image;
  final String title;
  final int price;
  late int quantity;

  //constuctor
  Game(this.image, this.title, this.price, {required this.quantity});
}
