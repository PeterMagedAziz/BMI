// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//
//   late final WebViewController controller;
//
//
//
//   get articles => null;
//
//   void initState() {
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('${articles['url']}'),
//       );
//   }
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
//
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView'),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }
