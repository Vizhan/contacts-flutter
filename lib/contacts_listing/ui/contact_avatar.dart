import 'dart:typed_data';

import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  final Uint8List imageBytes;
  final double radius;

  ContactAvatar({
    @required this.imageBytes,
    @required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          fit: BoxFit.fill,
          placeholder: AssetImage('assets/ic_user.png'),
          image: MemoryImage(imageBytes),
        ),
      ),
    );
  }
}
