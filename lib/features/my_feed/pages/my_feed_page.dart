import 'package:daily/app_theme.dart';
import 'package:daily/features/account/controllers/account_controller.dart';
import 'package:daily/features/my_feed/controllers/my_feed_controller.dart';
import 'package:daily/features/my_feed/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class MyFeedPage extends StatelessWidget {
  MyFeedPage({Key? key}) : super(key: key);

  final controller = Get.put(MyFeedController());
  final accountC = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily.dev Clone",
          style: AppTextStyle.bigTitle,
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Container(
          //   padding: const EdgeInsets.all(20.0),
          //   decoration: BoxDecoration(
          //     // borderRadius: const BorderRadius.only(
          //     //   bottomRight: Radius.circular(25),
          //     //   bottomLeft: Radius.circular(25),
          //     // ),
          //     borderRadius: BorderRadius.circular(20),
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 50,
          //         width: 50,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50),
          //           color: Colors.white,
          //         ),
          //         child: const Icon(Icons.person),
          //       ),
          //       const SizedBox(width: 16),
          //       Obx(
          //         () => accountC.user.value.email != null
          //             ? Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     accountC.user.value.name
          //                         .toString()
          //                         .capitalize
          //                         .toString(),
          //                     style: AppTextStyle.title.copyWith(
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   Text(
          //                     accountC.user.value.email.toString(),
          //                     style: AppTextStyle.small.copyWith(
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             : const Text("No user loggedIn"),
          //       ),
          //       const Spacer(),
          //       IconButton(
          //         onPressed: () => accountC.signOut(
          //           accountC.user.value.sessionId.toString(),
          //         ),
          //         icon: const Icon(
          //           Icons.logout,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 20),
          Obx(
            () => controller.isLoading.value
                ? const SpinKitFadingCircle(
                    color: Colors.grey,
                  )
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      for (var item in controller.myFeeds)
                        // final item = controller.myFeeds[index];

                        InkWell(
                          onTap: () =>
                              controller.launchArticle(item.link.toString()),
                          child: ArticleCard(
                            logoUrl: item.logo ?? "",
                            title: item.title ?? "",
                            author: item.author ?? "",
                            pubDate: item.datePublished ?? "",
                            thumbnailUrl: item.thumbnail ?? "",
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
