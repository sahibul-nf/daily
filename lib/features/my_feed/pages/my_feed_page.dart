import 'package:cached_network_image/cached_network_image.dart';
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
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              // borderRadius: const BorderRadius.only(
              //   bottomRight: Radius.circular(25),
              //   bottomLeft: Radius.circular(25),
              // ),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.person),
                ),
                const SizedBox(width: 16),
                Obx(
                  () => accountC.user.value.email != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              accountC.user.value.name
                                  .toString()
                                  .capitalize
                                  .toString(),
                              style: AppTextStyle.title.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              accountC.user.value.email.toString(),
                              style: AppTextStyle.small.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : const Text("No user loggedIn"),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => accountC.signOut(
                    accountC.user.value.sessionId.toString(),
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => controller.isLoading.value
                ? const SpinKitFadingCircle(
                    color: Colors.grey,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      itemCount: controller.myFeeds.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemBuilder: (context, index) {
                        // const placeholderImg = 'assets/image64.png';
                        final item = controller.myFeeds[index];

                        return InkWell(
                          onTap: () =>
                              controller.launchArticle(item.link.toString()),
                          child: ArticleCard(
                            logoUrl: item.logo ?? "",
                            title: item.title ?? "",
                            author: item.author ?? "",
                            pubDate: item.datePublished ?? "",
                            thumbnailUrl: item.thumbnail ?? "",
                          ),
                        );

                        // return ListTile(
                        //   leading: controller.myFeeds[index].thumbnail != null
                        //       ? CachedNetworkImage(
                        //           placeholder: (context, url) =>
                        //               Image.asset(placeholderImg),
                        //           imageUrl: controller.myFeeds[index].thumbnail
                        //               .toString(),
                        //           height: 50,
                        //           width: 70,
                        //           alignment: Alignment.center,
                        //           fit: BoxFit.cover,
                        //         )
                        //       : const Icon(Icons.image),
                        //   title:
                        //       Text(controller.myFeeds[index].title.toString()),
                        //   subtitle: Text(controller.myFeeds[index].datePublished
                        //       .toString()),
                        //   onTap: () => controller.launchArticle(
                        //       controller.myFeeds[index].link.toString()),
                        //   trailing: const Icon(Icons.arrow_right),
                        // );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
