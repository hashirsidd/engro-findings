import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatelessWidget {
  final List images;
  final int index;

  const ImageViewer({Key? key, required this.images, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return images[index] is String
                  ? PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(images[index]),
                    )
                  : PhotoViewGalleryPageOptions(
                      imageProvider: MemoryImage(images[index]),
                    );
            },
            itemCount: images.length,
            loadingBuilder: (context, event) => const Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
            ),
            pageController: PageController(
              initialPage: index,
              keepPage: false,
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
