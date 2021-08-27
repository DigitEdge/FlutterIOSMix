import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:my_flutter/one_page.dart';

/** channel
 * MethodChanner - 传递方法，一次性通信（点击一次，通信一次）
 * BasicChannel - 持续通信
 * EventChannel - 数据流传递
 * 每一个 channel 都有对应的 codec
 * */

void main() => runApp(MyApp(window.defaultRouteName));

class MyApp extends StatefulWidget {
  final String? pageIndex;
  MyApp(this.pageIndex);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MethodChannel _oneChannel = MethodChannel("one_page");
  final MethodChannel _twoChannel = MethodChannel("two_page");
  final BasicMessageChannel _msgChannel =
      BasicMessageChannel('messageChannel', StandardMessageCodec());

  final _pushIOSPageChannel = MethodChannel("show_ios_native");

  String _pageIndex = "one";

  @override
  void initState() {
    super.initState();

    _msgChannel.setMessageHandler((message) async {
      print("收到了来自 iOS 的消息");
    });

    _oneChannel.setMethodCallHandler((MethodCall call) async {
      _pageIndex = call.method;
      setState(() {});
    });

    _twoChannel.setMethodCallHandler((MethodCall call) async {
      _pageIndex = call.method;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: rootPage());
  }

  Widget rootPage() {
    switch (_pageIndex) {
      case "one":
        return OnePage(() {
          print("object");
          _oneChannel.invokeMethod("exit", "args");
        }, () {
          _pushIOSPageChannel.invokeMethod("pushIOSPage", "args");
        });
      case "two":
        return GestureDetector(
          onTap: () {
            _twoChannel.invokeMethod(
                "exit", "args"); //通信需要唯一确定的 channel 来进行，通过name 确定这个唯一的 channel
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.cyan,
            child: Text("two"),
          ),
        );
      default:
        return Center(
          child: Text("one"),
        );
    }
    // return Container();
  }
}
