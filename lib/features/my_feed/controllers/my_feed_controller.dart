import 'dart:convert';
import 'dart:developer';

import 'package:daily/features/my_feed/entities/article.dart';
import 'package:daily/features/my_feed/models/rss_feed.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

const mediumFlutterDevsFeedUrl = "https://medium.flutterdevs.com/feed";
const devFeedUrl = "https://dev.to/feed";
const devTeamFeedUrl = "https://dev.to/feed/devteam";
const devAwsBuilders = "https://dev.to/feed/aws-builders";
const blibliMedium = "https://medium.com/feed/bliblidotcom-techblog";
const suragchMedium = "https://medium.com/feed/@suragch";
const khanedyMedium = "https://medium.com/feed/@khannedy";
const dotMedium = "https://blog.dot.co.id/feed";
// const theThinkingMuslim = "https://thethinkingmuslim.com/feed/";
// const ribathNouraniyyah = "https://ribathnouraniyyah.com/feed/";
// const mui = "https://mui.or.id/feed/";
const apiKey = "nsefnfsafaqpiwde3lggd8fitlzlyve0ozfhusja";

class MyFeedController extends GetxController {
  var myFeeds = <Article>[].obs;
  var isLoading = false.obs;

  Future<RssFeed?> fetchFeed(String feedUrl) async {
    // api for convert rss2Json
    final url =
        "https://api.rss2json.com/v1/api.json?rss_url=$feedUrl&api_key=$apiKey&count=20";

    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(url));

      final body = jsonDecode(response.body);

      RssFeed rssFeed = RssFeed.fromJson(body);

      return rssFeed;
    } catch (e) {
      log("Error: " + e.toString());
      return null;
    }
  }

  void loadMyFeed() {
    fetchFeed(mediumFlutterDevsFeedUrl).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(devAwsBuilders).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(devAwsBuilders).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(khanedyMedium).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(suragchMedium).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(blibliMedium).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });

    fetchFeed(dotMedium).then((feed) {
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          myFeeds.add(_article);
        }
      }

      log(myFeeds.length.toString());
    });
  }

  Future<void> launchArticle(String url) async {
    // if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
    );
    return;
    // }
  }

  @override
  void onInit() {
    loadMyFeed();
    super.onInit();
  }
}
