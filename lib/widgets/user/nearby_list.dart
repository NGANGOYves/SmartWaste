import 'package:flutter/material.dart';

class NearbyItem {
  final String title;
  final String imageUrl;

  NearbyItem({required this.title, required this.imageUrl});
}

class NearbyList extends StatelessWidget {
  final List<NearbyItem> items;
  final void Function(NearbyItem) onTap;

  const NearbyList({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.imageUrl,
                    height: 70,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 100,
                  child: Text(
                    item.title,
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
