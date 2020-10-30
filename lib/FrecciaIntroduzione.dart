import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FrecciaIntroduzione extends StatelessWidget {
  FrecciaIntroduzione({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 13.0, 42.2, 1.0),
          size: Size(42.2, 26.0),
          pinLeft: true,
          pinRight: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_4x08wd,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(31.7, 0.0, 10.5, 26.0),
          size: Size(42.2, 26.0),
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: SvgPicture.string(
            _svg_gv56q2,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

const String _svg_4x08wd =
    '<svg viewBox="0.0 13.0 42.2 1.0" ><path transform="translate(-7.5, -5.0)" d="M 7.499999046325684 18.0000114440918 L 49.71945953369141 18.0000114440918" fill="none" stroke="#1700ff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_gv56q2 =
    '<svg viewBox="31.7 0.0 10.5 26.0" ><path transform="translate(13.72, -7.5)" d="M 18 33.49999618530273 L 28.5 20.5 L 18 7.499999523162842" fill="none" stroke="#1700ff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
