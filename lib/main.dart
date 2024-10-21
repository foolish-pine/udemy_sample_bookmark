import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ブックマーク'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Entry {
  final String title;
  final String url;

  Entry({required this.title, required this.url});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Entry> items = [
    Entry(title: 'Flutter', url: 'https://flutter.dev/'),
    Entry(title: 'GitHub', url: 'https://github.com/foolish-pine')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item.title;
          final url = item.url;

          return ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebViewPage(title: title, url: url);
              }));
            },
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
