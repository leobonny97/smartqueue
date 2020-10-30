import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class BottoneIntroduzione extends StatelessWidget {
  BottoneIntroduzione({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 81.0, 44.0),
          size: Size(81.0, 44.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
