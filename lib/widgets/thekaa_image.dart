import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

Widget thekaaImage(
  String path, {
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
  Widget? errorWidget,
}) {
  final fallback = errorWidget ??
      Container(
        width: width,
        height: height,
        color: const Color(0xFFF3ECE0),
        child: const Center(
          child: Icon(Icons.restaurant, color: ThekaaColors.terracotta, size: 24),
        ),
      );

  if (path.isEmpty) return fallback;

  if (path.startsWith('http://') || path.startsWith('https://')) {
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => fallback,
    );
  }

  if (path.startsWith('assets/')) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => fallback,
    );
  }

  return Image.file(
    File(path),
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (_, __, ___) => fallback,
  );
}

ImageProvider thekaaImageProvider(
  String path, {
  String fallbackAsset = 'assets/images/biryani_hd.jpg',
}) {
  if (path.isEmpty) return AssetImage(fallbackAsset);
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return NetworkImage(path);
  }
  if (path.startsWith('assets/')) {
    return AssetImage(path);
  }
  return FileImage(File(path));
}

