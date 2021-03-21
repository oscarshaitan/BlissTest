import 'package:bliss_test/_core/models/emoji.dart';
import 'package:flutter/material.dart';

import 'emoji_tile.dart';

class GridImageAppWidget extends StatelessWidget {
  final List<ImageApp> images;
  final Function(ImageApp) onTap;

  const GridImageAppWidget({
    Key key,
    @required this.images,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      Flexible(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          child: images.isEmpty
              ? Center(
                  child: Text('No Images to show'),
                )
              : GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.9),
                  itemBuilder: (BuildContext context, int index) {
                    return ImageTile(
                      onTap: () {
                        onTap(images[index]);
                      },
                      image: images[index],
                    );
                  },
                ),
        ),
      ),
    ]);
  }
}
