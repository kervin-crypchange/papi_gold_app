
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradeViewMiniChartWidget extends StatefulWidget {
  final String symbol;

  const TradeViewMiniChartWidget({
    super.key,
    this.symbol = 'XAUUSD',
  });

  @override
  State<TradeViewMiniChartWidget> createState() => _TradeViewMiniChartWidgetState();
}

class _TradeViewMiniChartWidgetState extends State<TradeViewMiniChartWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Contenido HTML con el script y la etiqueta de TradingView
    final htmlContent = '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            body, html {
              margin: 0;
              padding: 0;
              width: 100%;
              height: 100%;
              overflow: hidden;
              background-color: transparent;
            }
            tv-mini-chart {
              width: 100%;
              height: 100%;
            }
          </style>
          <script type="module" src="https://widgets.tradingview-widget.com/w/en/tv-mini-chart.js"></script>
        </head>
        <body>
          <tv-mini-chart symbol="OANDA:${widget.symbol}" time-frame="1D" show-time-scale></tv-mini-chart>
        </body>
      </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: WebViewWidget(controller: _controller),
    );
  }
}