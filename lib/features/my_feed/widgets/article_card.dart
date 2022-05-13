import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/app_theme.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(
      {Key? key,
      required this.logoUrl,
      required this.title,
      required this.pubDate,
      required this.thumbnailUrl,
      required this.author})
      : super(key: key);

  final String logoUrl;
  final String title;
  final String pubDate;
  final String thumbnailUrl;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [AppShadow.card],
        border: Border.all(
          color: Colors.grey.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: CachedNetworkImage(
                  imageUrl: logoUrl,
                  width: 36,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                author,
                style: AppTextStyle.small,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyle.bigTitle,
          ),
          const SizedBox(height: 16),
          Text(
            pubDate,
            style: AppTextStyle.small,
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                    boxShadow: [AppShadow.card],
                  ),
                  child: Text(
                    "🚀",
                    style: AppTextStyle.bigTitle,
                  ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                    boxShadow: [AppShadow.card],
                  ),
                  child: Text(
                    "🔥",
                    style: AppTextStyle.bigTitle,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100,
                    boxShadow: [AppShadow.card],
                  ),
                  child: Text(
                    "📁",
                    style: AppTextStyle.bigTitle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
