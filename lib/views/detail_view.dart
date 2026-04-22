import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['title'] ?? 'Detalle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          data['description'] ?? 'Sin información adicional',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}