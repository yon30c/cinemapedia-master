import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class IframeScreen extends StatefulWidget {
  const IframeScreen({super.key, required this.iframe});

  final String iframe;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IframeScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool webView = true;
  bool webViewJs = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                baseUrl: Uri.parse('https://jkanime.net/'),
                widget.iframe,
                factoryBuilder: () => _WidgetFactory(
                  webView: webView,
                  webViewJs: webViewJs,
                ),
                rebuildTriggers: RebuildTriggers([webView, webViewJs]),
              ),
            ),
          ],
        ),
      );
}

class _WidgetFactory extends WidgetFactory {
  @override
  final bool webView;

  @override
  final bool webViewJs;

  _WidgetFactory({
    required this.webView,
    required this.webViewJs,
  });
}
