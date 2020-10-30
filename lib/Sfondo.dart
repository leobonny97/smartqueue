import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class Sfondo extends StatelessWidget {
  Sfondo({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 265.0, 393.0),
          size: Size(265.0, 393.0),
          fixedWidth: true,
          fixedHeight: true,
          child: GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 1,
            childAspectRatio: 0.67,
            children: [{}].map((map) {
              return SizedBox(
                width: 265.0,
                height: 393.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 265.0, 393.0),
                      size: Size(265.0, 393.0),
                      fixedWidth: true,
                      fixedHeight: true,
                      child: GridView.count(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 1,
                        childAspectRatio: 0.67,
                        children: [{}].map((map) {
                          return SizedBox(
                            width: 265.0,
                            height: 393.0,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 0.0, 265.0, 393.0),
                                  size: Size(265.0, 393.0),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffff7700),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff707070)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
