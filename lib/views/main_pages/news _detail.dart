// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recycleapp/models/news_model.dart';
import 'package:recycleapp/widgets/NewsWebViewPage.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          // 🖼️ Image avec effet parallax et retour
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: news.imageUrl,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(news.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: 16,
                  //   top: MediaQuery.of(context).padding.top + 8,
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.black54,
                  //     child: IconButton(
                  //       icon: const Icon(Icons.arrow_back, color: Colors.white),
                  //       onPressed: () => Navigator.pop(context),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    left: 16,
                    bottom: 20,
                    right: 16,
                    child: Text(
                      news.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📰 Contenu détaillé
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat.yMMMMd().format(news.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Text(
                        news.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Lien source
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewsWebViewPage(url: news.link),
                              ),
                            );
                          },
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('Lire l’article complet'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
