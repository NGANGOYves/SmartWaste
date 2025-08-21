// import 'package:flutter/material.dart';
// import 'package:webview_all/webview_all.dart';

// class NewsWebViewPage extends StatelessWidget {
//   final String url;

//   const NewsWebViewPage({super.key, required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Article complet")),
//       body: Webview(url: url),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';
import 'dart:async';

class NewsWebViewPage extends StatefulWidget {
  final String url;

  const NewsWebViewPage({super.key, required this.url});

  @override
  State<NewsWebViewPage> createState() => _NewsWebViewPageState();
}

class _NewsWebViewPageState extends State<NewsWebViewPage> {
  bool _isLoading = true;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();

    // Simulate loading delay
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    // Optional: After 10s, if still white, consider it failed
    Timer(const Duration(seconds: 10), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
          _loadFailed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Article complet")),
      body: Stack(
        children: [
          if (!_loadFailed) Webview(url: widget.url),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (_loadFailed)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 10),
                  const Text("Échec du chargement de la page"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _loadFailed = false;
                      });
                      // Retry: re-trigger the timer
                      initState();
                    },
                    child: const Text("Réessayer"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
