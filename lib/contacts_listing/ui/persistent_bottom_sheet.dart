import 'dart:ui';

import 'package:flutter/material.dart';

class PersistentBottomSheet extends StatelessWidget {
  final VoidCallback onCancelSearchPressedCallback;
  final VoidCallback onHighlightPressedCallback;

  PersistentBottomSheet({
    @required this.onCancelSearchPressedCallback,
    @required this.onHighlightPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[100],
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          FlatButton.icon(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.close),
            label: Text('cancel'),
            onPressed: onCancelSearchPressedCallback,
          ),
          FloatingActionButton(
            child: Icon(Icons.done),
            onPressed: onHighlightPressedCallback,
          ),
        ],
      ),
    );
  }
}
