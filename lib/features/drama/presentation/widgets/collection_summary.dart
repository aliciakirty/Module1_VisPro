import 'package:flutter/material.dart';

class CollectionSummary extends StatelessWidget {
  const CollectionSummary({super.key, required this.total, required this.finished});

  final int total;
  final int finished;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: _Metric(label: 'In vault', value: '$total')),
            Expanded(child: _Metric(label: 'Finished', value: '$finished')),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 4),
      Text(label),
    ]);
  }
}
