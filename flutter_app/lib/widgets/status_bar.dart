import 'package:flutter/material.dart';

class CustomStatusBar extends StatelessWidget {
  final bool light;
  const CustomStatusBar({super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    final col = light ? Colors.white : const Color(0xFF1E3A2F);
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 14, 28, 0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: col)),
          Row(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [3, 5, 7, 9].map((h) {
                final idx = [3, 5, 7, 9].indexOf(h);
                return Container(
                  width: 3,
                  height: h.toDouble(),
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: idx < 3 ? col : col.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(width: 6),
            Icon(Icons.wifi, size: 16, color: col),
            const SizedBox(width: 4),
            Container(
              width: 23,
              height: 12,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                border: Border.all(color: col, width: 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.75,
                child: Container(
                    decoration: BoxDecoration(
                        color: col,
                        borderRadius: BorderRadius.circular(1))),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
