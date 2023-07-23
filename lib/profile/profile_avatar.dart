//import 'package:cached_network_image/cached_network_image.dart';
// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/config.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.black.withOpacity(.79),
          child: CircleAvatar(
            radius: 25,
            // child: CachedNetworkImage(
            //   imageUrl: imageUrl,
            //   fit: BoxFit.fill,
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) =>
            //       Icon(Icons.person_outline_rounded,
            //           //color: Colors.blue,
            //           size: 25),
            // ),
            //radius: hasBorder ? 17.0 : 20.0,
            backgroundColor: Colors.blueGrey[50],
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        // Positioned(
        //   bottom: 0.0,
        //   right: 0.0,
        //   child: Container(
        //     height: 10.0,
        //     width: 10.0,
        //     decoration: BoxDecoration(
        //       color: Palette.online,
        //       shape: BoxShape.circle,
        //       border: Border.all(
        //         width: 2.0,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
