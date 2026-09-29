import 'package:flutter/material.dart';

class DramaSearch extends StatelessWidget {
  const DramaSearch({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search your collection',
      ),
    );
  }
}
