import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terrapay Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: InAppWebViewPage(),
    );
  }
}

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? _webViewController;
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: <Widget>[
      InAppWebView(
          initialUrlRequest:
              URLRequest(url: Uri.parse('https://139.84.142.247/')),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
                javaScriptEnabled: true),
          ),
          onProgressChanged: (InAppWebViewController controller, int p) {
            progress = p;
            setState(() {});
          },
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          }),
      if (progress < 100)
        LinearProgressIndicator(
          value: progress / 100,
          minHeight: 5,
          color: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
    ])));
  }
}
