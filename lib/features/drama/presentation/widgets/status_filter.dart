import 'package:flutter/material.dart';

import '../../domain/models/drama.dart';

class StatusFilter extends StatelessWidget {
  const StatusFilter({super.key, required this.value, required this.onChanged});

  final DramaStatus? value;
  final ValueChanged<DramaStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DramaStatus?>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Status'),
      items: const [
        DropdownMenuItem(value: null, child: Text('All statuses')),
        DropdownMenuItem(value: DramaStatus.backlog, child: Text('Backlog')),
        DropdownMenuItem(value: DramaStatus.watching, child: Text('Watching')),
        DropdownMenuItem(value: DramaStatus.finished, child: Text('Finished')),
        DropdownMenuItem(value: DramaStatus.dropped, child: Text('Dropped')),
      ],
      onChanged: onChanged,
    );
  }
}
