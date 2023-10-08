import 'package:flutter/material.dart';

class TravelList extends StatefulWidget {
  const TravelList({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<TravelList> createState() => _TravelListState();
}

class _TravelListState extends State<TravelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
      ),
    );
  }
}
