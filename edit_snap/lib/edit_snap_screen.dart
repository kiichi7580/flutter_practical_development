import 'dart:typed_data';

import 'package:edit_snap/gen/assets.gen.dart';
import 'package:edit_snap/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_lib;

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key, required this.imageBitmap});

  final Uint8List imageBitmap;

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends State<ImageEditScreen> {
  late Uint8List _imageBitmap;

  @override
  void initState() {
    super.initState();
    _imageBitmap = widget.imageBitmap;
  }

  void _rotateImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;

    final rotateImage = image_lib.copyRotate(image, angle: 90);

    setState(() {
      _imageBitmap = image_lib.encodeBmp(rotateImage);
    });
  }

  void _flipImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;

    final flipImage = image_lib.copyFlip(
      image,
      direction: image_lib.FlipDirection.horizontal,
    );
    setState(() {
      _imageBitmap = image_lib.encodeBmp(flipImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.imageSelectScreenTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(_imageBitmap),
            IconButton(
              onPressed: () => _rotateImage(),
              icon: Assets.rotateIcon.svg(
                height: 24,
                width: 24,
              ),
            ),
            IconButton(
              onPressed: () => _flipImage(),
              icon: Assets.flipIcon.svg(
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
