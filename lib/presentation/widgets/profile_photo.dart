import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/constants/assets.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.imageUrl,
    this.fileImagePath,
    this.radius = 24,
  });
  final String? imageUrl;
  final String? fileImagePath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Builder(builder: (context) {
          if (fileImagePath != null) {
            return Image.file(
              File(fileImagePath!),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImages.profile),
            );
          }
          return Image.network(
            imageUrl ??
                'https://www.elitesingles.co.uk/wp-content/uploads/sites/59/2019/11/2b_en_articleslide_sm2-350x264.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset(AppImages.profile),
          );
        }),
      ),
    );
  }
}
