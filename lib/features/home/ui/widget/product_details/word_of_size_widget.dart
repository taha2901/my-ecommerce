
import 'package:flutter/material.dart';

class WordOFSizeWidget extends StatelessWidget {
  const WordOFSizeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Size',
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
