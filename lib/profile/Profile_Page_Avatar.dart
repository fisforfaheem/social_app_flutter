//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/config.dart';

class ProfilePageAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;

  const ProfilePageAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = true,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100.0,
          backgroundColor: Colors.black.withOpacity(.79),
          child: CircleAvatar(
            radius: 100,
            //radius: hasBorder ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: Palette.online,
              shape: BoxShape.circle,
              border: Border.all(
                width: 11.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
