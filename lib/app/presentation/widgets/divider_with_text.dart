import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(child: Divider(indent: 20, endIndent: 10)),
      Text(text, style: Theme.of(context).textTheme.bodySmall),
      const Expanded(child: Divider(endIndent: 20, indent: 10)),
    ]);
  }
}
