import 'package:flutter/material.dart';

class DashboardItemWidget extends StatelessWidget {
  const DashboardItemWidget(
      {super.key, required this.numberOfTask, required this.type});

  final int numberOfTask;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              '$numberOfTask',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(type),
            ),
          ],
        ),
      ),
    );
  }
}
