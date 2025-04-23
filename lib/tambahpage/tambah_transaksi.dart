import 'package:flutter/material.dart';

class TambahScreen extends StatefulWidget {
  const TambahScreen({super.key});

  @override
  State<TambahScreen> createState() => _TambahScreenState();
}

class _TambahScreenState extends State<TambahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Halo! Ini halaman Tambah.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
