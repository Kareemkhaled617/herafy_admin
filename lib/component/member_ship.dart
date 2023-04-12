import 'package:flutter/material.dart';

class Membership extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            Container(
              width: 90.0,
              child: const Text(
                "Membership",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Container(
              width: 50.0,
              child: const Text(
                "Classic",
                textAlign: TextAlign.left,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Container(
              width: 50.0,
              child: const Text(
                "Silver",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: const Icon(Icons.account_balance_wallet),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Container(
              width: 90.0,
              child: const Text(
                "Gold",
                textAlign: TextAlign.left,
              ),
            ),
          ],
        );
      },
    );
  }
}
