import 'dart:io';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinny_ai_chat/view/Navigation_ChatView/chat_detailView.dart';
import 'package:vinny_ai_chat/view/welcome/premimumView.dart';

import '../../Providers/categories_provider.dart';
import '../../Providers/categorizedBots_provider.dart';
import '../../Providers/featuredBots_provider.dart';
import '../../Providers/freeBots_provider.dart';
import '../../Providers/likeDislikeProvider.dart';
import '../../constants/AppConstants.dart';
import '../../helper/transition.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? userName;

  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<BotProvider>(context, listen: false).fetchBots();
    });
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
    Future.microtask(() {
      Provider.of<FeaturedBotProvider>(context, listen: false)
          .fetchFeaturedBotsData();
    });
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild the widget to reflect active tab changes
    });

    _loadUserName();
  }

  Future<void> _loadUserName() async {
    userName = await getUserName();
    setState(() {}); // Update the UI once the userName is fetched
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName") ?? "";
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddingRight = MediaQuery.of(context).size.width * 0.06;
    final double paddingLeft = MediaQuery.of(context).size.width * 0.06;

    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          SvgPicture.asset(AppConstants.navHomeBackground),

          // App Bar
          AppBar(
            title: Text(
              "Hi ${userName} 👋",
              style: TextStyle(
                color: AppConstants.fontColor,
                fontSize: 14,
                fontFamily: "InterRegular",
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white, // Set the color of the back button
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(AppConstants.profileAvatar),
                ),
              ),
            ],
          ),

          // TabBar
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    EdgeInsets.only(left: paddingLeft, right: paddingRight),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicator: BoxDecoration(), // Remove underline indicator
                  tabs: [
                    _buildTab(
                      'Recommended',
                      Colors.white.withOpacity(0.05),
                      0,
                      AppConstants.recomendedIcon,
                    ),
                    _buildTab(
                      'Category',
                      Colors.white.withOpacity(0.05),
                      1,
                      AppConstants.featuredIcon,
                    ),
                    _buildTab(
                      'Featured',
                      Colors.white.withOpacity(0.05),
                      2,
                      AppConstants.categoryIcon,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //tabbar body
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            right: 0,
            left: 0,
            bottom: 0,
            // Align to the bottom of the screen
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight,
                  // Adjust the height dynamically
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RecommendedScreen(),
                      CategoryView(),
                      FeaturedView(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    String text,
    Color inactiveColor,
    int index,
    String Icon,
  ) {
    return Builder(
      builder: (BuildContext context) {
        final bool isActive = _tabController.index == index;
        return Container(
          height: 86,
          width: 96, // Set the desired width
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      Color(0xFF04D4CB), // Color with 100% opacity
                      Color(0xFFA01ECE), // Color with 100% opacity
                    ],
                    stops: [
                      0.41, // 41% stop
                      1.0, // 50% stop
                    ],
                    begin: Alignment(0.0, -1.0), // From top center
                    end: Alignment(0.0, 1.0), // To bottom center
                  )
                : null,
            color: isActive ? null : inactiveColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Icon, color: isActive ? Colors.white : null),
                SizedBox(
                  height: 8,
                ),
                Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "InterSemiBold",
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RecommendedScreen extends StatefulWidget {
  RecommendedScreen({Key? key});

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carousel Slider
            Consumer<BotProvider>(
              builder: (context, botProvider, child) {
                // Limit to 3 bots
                final selectedBots = botProvider.bots.take(3).toList();

                // Check if selectedBots is empty
                if (selectedBots.isEmpty) {
                  // Return a placeholder widget or loading indicator
                  return SizedBox
                      .shrink(); // You can replace this with a loading indicator if you prefer
                }

                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 230.0,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        autoPlay: true,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                      ),
                      items: selectedBots.map((bot) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                // Use Container with BoxDecoration for gradient background
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF06B8BE),
                                        Color(0xFF7186F4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title and icon
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 16),
                                              child: Text(
                                                bot.botName,
                                                style: TextStyle(
                                                  fontFamily: "InterMedium",
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, right: 8),
                                            child: SvgPicture.asset(
                                                "assets/svg/cardIcon.svg"),
                                          ),
                                        ],
                                      ),
                                      // Subheading
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            bot.shortDescription,
                                            style: TextStyle(
                                              fontFamily: "InterRegular",
                                              fontSize: 11.0,
                                              color: Colors.white,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      // Images and button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(8.0),
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                "${AppConstants.assetBaseUrl}/bots/${bot.image}",
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(Icons
                                                      .error); // Placeholder on error
                                                },
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                FadePageRouteBuilder(
                                                  widget:
                                                      ChatDetailView(bot: bot),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "OPEN",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    DotsIndicator(
                      dotsCount: selectedBots.length,
                      position: currentPage.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.white.withOpacity(0.5),
                        activeColor: Colors.white,
                        size: const Size.square(9.0),
                        activeSize: const Size(12.0, 6.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Consumer<BotProvider>(
              builder: (context, botProvider, child) {
                if (botProvider.isLoading) {
                  // Show a loading indicator while data is being fetched
                  return Center(child: CircularProgressIndicator());
                }

                if (botProvider.bots.isEmpty) {
                  // Show a message if no bots are available
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "No bots found.",
                      style: TextStyle(color: Colors.white),
                    )),
                  );
                }

                return // Inside your GridView.builder for the Recommended section
                    GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: botProvider.bots.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bot = botProvider.bots[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          FadePageRouteBuilder(
                            widget: ChatDetailView(bot: bot),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Color(0xFF092765).withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bot Name and Description
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  bot.botName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppConstants.fontColor,
                                    fontFamily: "JostMedium",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                child: Text(
                                  bot.shortDescription,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppConstants.fontColor,
                                    fontFamily: "InterRegular",
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Spacer(),
                              // Like/Dislike and Image Row
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8, bottom: 10, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Like Button and Count
                                    GestureDetector(
                                      onTap: () async {
                                        final likeDislikeProvider =
                                            Provider.of<LikeDislikeProvider>(
                                                context,
                                                listen: false);

                                        // Trigger the toggle like action, passing the original like count
                                        await likeDislikeProvider.toggleLike(
                                            bot.id.toString(), bot.likes_count);

                                        // Check for errors and display the appropriate message
                                        final errorMessage =
                                            likeDislikeProvider.errorMessage;
                                        if (errorMessage != null) {
                                          if (Platform.isIOS) {
                                            // For iOS, show a CupertinoAlertDialog
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoAlertDialog(
                                                title: Text('Error'),
                                                content: Text(errorMessage),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: Text('OK'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            // For Android and other platforms, show a SnackBar
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(errorMessage),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                          // Clear the error message after displaying it
                                          likeDislikeProvider
                                              .clearErrorMessage();
                                        }
                                        // No need to call setState since the provider notifies listeners
                                      },
                                      child: Row(
                                        children: [
                                          // Like Icon
                                          Consumer<LikeDislikeProvider>(
                                            builder: (context,
                                                likeDislikeProvider, child) {
                                              return SvgPicture.asset(
                                                AppConstants.likeIcon,
                                                color: likeDislikeProvider
                                                        .isLiked(
                                                            bot.id.toString())
                                                    ? Colors.blue // Liked color
                                                    : Colors.white,
                                                // Default color if not liked
                                                height: 20,
                                                width: 20,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 8),
                                          // Adjusted Like Count
                                          Consumer<LikeDislikeProvider>(
                                            builder: (context,
                                                likeDislikeProvider, child) {
                                              int adjustedLikeCount =
                                                  likeDislikeProvider
                                                      .getAdjustedLikeCount(
                                                bot.id.toString(),
                                                bot.likes_count,
                                              );
                                              return Text(
                                                adjustedLikeCount.toString(),
                                                style: TextStyle(
                                                  color: AppConstants.fontColor,
                                                  fontSize: 11,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    // Dislike Icon and Count (if needed)
                                    SvgPicture.asset(
                                      AppConstants.dislikeIcon,
                                      height: 15,
                                      width: 10,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "0",
                                      // Replace with actual dislike count if available
                                      style: TextStyle(
                                        color: AppConstants.fontColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    // Bot Image
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white.withOpacity(0.56),
                                      ),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            "${AppConstants.assetBaseUrl}/bots/${bot.image}",
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Icons
                                                  .error); // Placeholder on error
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

                //   GridView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 3.0,
                //     mainAxisSpacing: 8.0,
                //     childAspectRatio: 1,
                //   ),
                //   itemCount: botProvider.bots.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     final bot = botProvider.bots[index];
                //
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           FadePageRouteBuilder(
                //             widget: ChatDetailView(bot: bot),
                //           ),
                //         );
                //       },
                //       child: Container(
                //         height: 150,
                //         child: Card(
                //           color: Color(0xFF092765).withOpacity(0.6),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Text(
                //                   bot.botName,
                //                   maxLines: 2,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                     color: AppConstants.fontColor,
                //                     fontFamily: "JostMedium",
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding:
                //                     const EdgeInsets.only(right: 8, left: 8),
                //                 child: Text(
                //                   bot.shortDescription,
                //                   maxLines: 3,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                     color: AppConstants.fontColor,
                //                     fontFamily: "InterRegular",
                //                     fontSize: 10,
                //                   ),
                //                 ),
                //               ),
                //               Spacer(),
                //               Padding(
                //                 padding: EdgeInsets.only(
                //                     left: 8, bottom: 10, right: 8),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //
                //                     GestureDetector(
                //                       onTap: () async {
                //                         // Trigger the toggle like action
                //                         await Provider.of<LikeDislikeProvider>(
                //                                 context,
                //                                 listen: false)
                //                             .toggleLike(bot.id.toString());
                //
                //                         // Check for errors and display the appropriate message
                //                         final errorMessage =
                //                             Provider.of<LikeDislikeProvider>(
                //                                     context,
                //                                     listen: false)
                //                                 .errorMessage;
                //                         if (errorMessage != null) {
                //                           if (Platform.isIOS) {
                //                             // For iOS, show a CupertinoAlertDialog
                //                             showCupertinoDialog(
                //                               context: context,
                //                               builder: (context) =>
                //                                   CupertinoAlertDialog(
                //                                 title: Text('Error'),
                //                                 content: Text(errorMessage),
                //                                 actions: [
                //                                   CupertinoDialogAction(
                //                                     child: Text('OK'),
                //                                     onPressed: () =>
                //                                         Navigator.of(context)
                //                                             .pop(),
                //                                   ),
                //                                 ],
                //                               ),
                //                             );
                //                           } else {
                //                             // For Android and other platforms, show a SnackBar
                //                             ScaffoldMessenger.of(context)
                //                                 .showSnackBar(
                //                               SnackBar(
                //                                 content: Text(errorMessage),
                //                                 backgroundColor: Colors.red,
                //                               ),
                //                             );
                //                           }
                //                           // Clear the error message after displaying it
                //                           Provider.of<LikeDislikeProvider>(
                //                                   context,
                //                                   listen: false)
                //                               .clearErrorMessage();
                //                         }
                //                       },
                //                       child: Row(
                //                         children: [
                //                           Consumer<LikeDislikeProvider>(
                //                             builder: (context,
                //                                 likeDislikeProvider, child) {
                //                               return SvgPicture.asset(
                //                                 AppConstants.likeIcon,
                //                                 color: likeDislikeProvider
                //                                         .isLiked(
                //                                             bot.id.toString())
                //                                     ? Colors.blue // Liked color
                //                                     : Colors.white,
                //                                 // Default color if not liked
                //                                 height: 20,
                //                                 width: 20,
                //                               );
                //                             },
                //                           ),
                //                           SizedBox(width: 8),
                //                           Text(
                //                             bot.likes_count.toString(),
                //                             // Replace with actual like count if available
                //                             style: TextStyle(
                //                               color: AppConstants.fontColor,
                //                               fontSize: 11,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //
                //                     Spacer(),
                //                     SvgPicture.asset(
                //                       AppConstants.dislikeIcon,
                //                       // Update as necessary
                //                       height: 15,
                //                       width: 10,
                //                     ),
                //                     SizedBox(width: 8),
                //                     Text(
                //                       "0",
                //                       style: TextStyle(
                //                         color: AppConstants.fontColor,
                //                         fontSize: 11,
                //                       ),
                //                     ),
                //                     SizedBox(width: 8),
                //                     Container(
                //                       height: 55,
                //                       width: 55,
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(8),
                //                         color: Colors.white.withOpacity(0.56),
                //                       ),
                //                       child: Center(
                //                         child: ClipRRect(
                //                           borderRadius:
                //                               BorderRadius.circular(8),
                //                           child: Image.network(
                //                             "${AppConstants.assetBaseUrl}/bots/${bot.image}",
                //                             // Use network image
                //                             height: 45,
                //                             width: 45,
                //                             fit: BoxFit.cover,
                //                             errorBuilder:
                //                                 (context, error, stackTrace) {
                //                               return Icon(Icons
                //                                   .error); // Placeholder on error
                //                             },
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedView extends StatelessWidget {
  FeaturedView({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Consumer<FeaturedBotProvider>(
            builder: (context, featuredBotProvider, child) {
              if (featuredBotProvider.isLoading) {
                // Show a loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              }

              if (featuredBotProvider.featuredBots.isEmpty) {
                // Show a message if no featured bots are available
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "No featured bots found.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              final selectedBots = (featuredBotProvider.featuredBots).toList();

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: selectedBots.length,
                itemBuilder: (BuildContext context, int index) {
                  final bot = selectedBots[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadePageRouteBuilder(widget: PremimumView()),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                      color: Color(0xFF092765).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pro Icon Row
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 8),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset(
                                  AppConstants.proIcon,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          // Bot Image
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: ClipOval(
                                child: Image.network(
                                  height: 40,
                                  width: 40,
                                  "${AppConstants.assetBaseUrl}/bots/${bot.image}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                        Icons.error); // Placeholder on error
                                  },
                                ),
                              ),
                            ),
                          ),
                          // Bot Details
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 16, left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bot.botName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppConstants.fontColor,
                                    fontFamily: "JostMedium",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  bot.shortDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppConstants.fontColor,
                                    fontFamily: "JostMedium",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            if (categoryProvider.isLoading) {
              // Show a loading indicator while data is being fetched
              return Center(child: CircularProgressIndicator());
            }

            if (categoryProvider.categories.isEmpty) {
              // Show a message if no categories are available
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "No categories found.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }

            // At this point, categories are not empty, so we can build the GridView
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1,
              ),
              itemCount: categoryProvider.categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categoryProvider.categories[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        FadePageRouteBuilder(
                            widget: CategoryDetailView(
                                categoryId: category.id.toString(),
                                categoryName: category.name)));
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                    color: Color(0xFF212121).withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 8, right: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "JostMedium",
                              fontSize: 14,
                              color: AppConstants.fontColor,
                            ),
                          ),
                          // Uncomment and adjust if you have a description or title
                          // Text(
                          //   category.description,
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: TextStyle(
                          //     fontFamily: "JostMedium",
                          //     fontSize: 20,
                          //     color: AppConstants.fontColor,
                          //   ),
                          // ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              // Use Image.network if 'image' is a URL
                              // Or use Image.asset if 'image' is an asset path
                              Image.network(
                                '${AppConstants.assetBaseUrl}/category/${category.image}',
                                height: 55,
                                width: 53,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // The image has finished loading
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                    .expectedTotalBytes!)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                // Handle errors during image loading
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Icon(
                                    Icons.error,
                                    size: 55,
                                  );
                                },
                              ),
                              // If using SVG images, use SvgPicture.network or SvgPicture.asset
                              // SvgPicture.network(
                              //   category.image,
                              //   height: 55,
                              //   width: 53,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 3.0,
        //     mainAxisSpacing: 8.0,
        //     childAspectRatio: 1,
        //   ),
        //   itemCount: boatsData.length,
        //   itemBuilder: (BuildContext context, index) {
        //     return Card(
        //       margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
        //       // Adjust margins as needed
        //       color: Color(0xFF212121).withOpacity(0.8),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.only(
        //             top: 16, left: 8, right: 8, bottom: 8),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               boatsData[index]['heading'],
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(
        //                 fontFamily: "JostMedium",
        //                 fontSize: 14,
        //                 color: AppConstants.fontColor,
        //               ),
        //             ),
        //             Text(
        //               boatsData[index]['title'],
        //               maxLines: 2,
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(
        //                 fontFamily: "JostMedium",
        //                 fontSize: 20,
        //                 color: AppConstants.fontColor,
        //               ),
        //             ),
        //             Spacer(),
        //             Row(
        //               children: [
        //                 Spacer(),
        //                 SvgPicture.asset(
        //                   boatsData[index]['icon'],
        //                   height: 55,
        //                   width: 53,
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}

class CategoryDetailView extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryDetailView(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  _CategoryDetailViewState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  @override
  void initState() {
    super.initState();
    // Fetch bots for the selected category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categorizedBotsProvider =
          Provider.of<CategorizedBotsProvider>(context, listen: false);
      categorizedBotsProvider.fetchBotsByCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontFamily: "InterRegular",
            fontSize: 20,
            color: AppConstants.fontColor,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF06B8BE),
      ),
      body: Consumer<CategorizedBotsProvider>(
        builder: (context, categorizedBotsProvider, child) {
          if (categorizedBotsProvider.isLoading) {
            // Show a loading indicator while data is being fetched
            return Center(child: CircularProgressIndicator());
          }

          if (categorizedBotsProvider.bots.isEmpty) {
            // Show a message if no bots are available
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "No bots found.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          // Display the bots in a grid
          return // Inside your GridView.builder for the Detailed Category section
              GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: categorizedBotsProvider.bots.length,
            itemBuilder: (BuildContext context, int index) {
              final bot = categorizedBotsProvider.bots[index];

              return GestureDetector(
                onTap: () {
                  if (bot.isFeatured == "1") {
                    // Navigate to the Pro Feature Screen
                    Navigator.push(
                      context,
                      FadePageRouteBuilder(widget: PremimumView()),
                    );
                  } else {
                    // Navigate to the regular ChatDetailView
                    Navigator.push(
                      context,
                      FadePageRouteBuilder(
                        widget: ChatDetailView(bot: bot),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 150,
                  child: Stack(
                    children: [
                      Card(
                        color: Color(0xFF092765).withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bot Name
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                bot.botName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppConstants.fontColor,
                                  fontFamily: "JostMedium",
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // Bot Short Description
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                bot.shortDescription,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppConstants.fontColor,
                                  fontFamily: "InterRegular",
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Spacer(),
                            // Bot Stats and Image
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 10, right: 8),
                              child: Row(
                                children: [
                                  // Like Button and Count
                                  GestureDetector(
                                    onTap: () async {
                                      final likeDislikeProvider =
                                          Provider.of<LikeDislikeProvider>(
                                              context,
                                              listen: false);

                                      // Trigger the toggle like action, passing the original like count
                                      await likeDislikeProvider.toggleLike(
                                          bot.id.toString(), bot.likes_count);

                                      // Check for errors and display the appropriate message
                                      final errorMessage =
                                          likeDislikeProvider.errorMessage;
                                      if (errorMessage != null) {
                                        if (Platform.isIOS) {
                                          // For iOS, show a CupertinoAlertDialog
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                              title: Text('Error'),
                                              content: Text(errorMessage),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          // For Android and other platforms, show a SnackBar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(errorMessage),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                        // Clear the error message after displaying it
                                        likeDislikeProvider.clearErrorMessage();
                                      }
                                      // No need to call setState since the provider notifies listeners
                                    },
                                    child: Row(
                                      children: [
                                        // Like Icon
                                        Consumer<LikeDislikeProvider>(
                                          builder: (context,
                                              likeDislikeProvider, child) {
                                            return SvgPicture.asset(
                                              AppConstants.likeIcon,
                                              color: likeDislikeProvider
                                                      .isLiked(
                                                          bot.id.toString())
                                                  ? Colors.blue // Liked color
                                                  : Colors.white,
                                              // Default color if not liked
                                              height: 25,
                                              width: 25,
                                            );
                                          },
                                        ),
                                        SizedBox(width: 8),
                                        // Adjusted Like Count
                                        Consumer<LikeDislikeProvider>(
                                          builder: (context,
                                              likeDislikeProvider, child) {
                                            int adjustedLikeCount =
                                                likeDislikeProvider
                                                    .getAdjustedLikeCount(
                                              bot.id.toString(),
                                              bot.likes_count,
                                            );
                                            return Text(
                                              adjustedLikeCount.toString(),
                                              style: TextStyle(
                                                color: AppConstants.fontColor,
                                                fontSize: 11,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  // Dislike Icon and Count
                                  SvgPicture.asset(
                                    AppConstants.dislikeIcon,
                                    height: 15,
                                    width: 10,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "0",
                                    // Replace with actual dislike count if available
                                    style: TextStyle(
                                      color: AppConstants.fontColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Bot Image
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white.withOpacity(0.56),
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          "${AppConstants.assetBaseUrl}/bots/${bot.image}",
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons
                                                .error); // Placeholder on error
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Display the Pro Icon if bot is featured
                      if (bot.isFeatured == "1")
                        Positioned(
                          top: 8,
                          right: 8,
                          child: SvgPicture.asset(
                            AppConstants.proIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
