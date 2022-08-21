import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'image_full_screen_controller.dart';

class ImageFullScreen extends StatefulWidget {
  final String tag;
  final String url;

  ImageFullScreen({Key key, @required this.tag, @required this.url})
      : assert(tag != null),
        assert(url != null),
        super(key: key);

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  ImageFullScreenController _controller = new ImageFullScreenController();

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.tag,
            child: CachedNetworkImage(
              imageUrl: widget.url,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
