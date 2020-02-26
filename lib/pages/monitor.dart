import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hupaipai/utils/screen_util.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MonitorPage extends StatefulWidget {
  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> with ScreenUtil{
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://vd2.bdstatic.com/mda-jkejvvf9y2p6mnn3/hd/mda-jkejvvf9y2p6mnn3.mp4')..initialize().then((_) {
      setState(() {});
    });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16/9,
      autoPlay: false,
      looping: false,
      autoInitialize: false,
      showControls: true,
      placeholder: Container(
        color: Colors.grey,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _chewieController.pause();
    _chewieController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('实时监控'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(setWidth(15)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('修改出价', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold)),
                  Text('￥888888', style: TextStyle(fontSize: setSp(18), color: Color(0xff666666)))
                ]
              ),
              Container(
                width: setWidth(345),
                height: setWidth(311),
                margin: EdgeInsets.only(top: setWidth(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(setWidth(10)),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: "http://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg",
                    placeholder: (context, url) => Image.asset(
                      'assets/images/img_loading.png',
                      fit: BoxFit.fitWidth,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: setWidth(10)),
                alignment: Alignment.centerLeft,
                  child: Text('投标操作视频', style: TextStyle(fontSize: setSp(22), fontWeight: FontWeight.bold))
              ),
              Container(
                margin: EdgeInsets.only(top: setWidth(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(setWidth(10)),
                  child: Chewie(
                    controller: _chewieController,
                  ),
                )
              )
            ],
          ),

        ),
      ),
    );
  }
}
