import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vinny_ai_chat/view/Navigation_ChatView/chat_detailView.dart';

import '../../constants/AppConstants.dart';
import '../../helper/transition.dart';
import '../Navigation_UpgradeView/UpgradeView.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild the widget to reflect active tab changes
    });
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
              "Hi Human 👋",
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
  final List<Map<String, dynamic>> cardData = [
    {
      'images': [
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
      ],
      'icon': AppConstants.cardIcon,
      'text': 'Sarah and Tom - Family Therapiest',
      'subHeading':
          'observe and analyze human behavior, often in real-time or near-real-time settings',
    },
    {
      'images': [
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
      ],
      'icon': AppConstants.cardIcon,
      'text': 'Sarah and Tom - Family Therapy',
      'subHeading':
          'observe and analyze human behavior, often in real-time or near-real-time settings',
    },
    {
      'images': [
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
        AppConstants.profileAvatar,
      ],
      'icon': AppConstants.cardIcon,
      'text': 'Sarah and Tom - Family Therapy',
      'subHeading':
          'observe and analyze human behavior, often in real-time or near-real-time settings',
    },
  ];

  final List<Map<String, dynamic>> boatsData = [
    {
      'image': AppConstants.profileAvatar,
      'likeIcon': AppConstants.likeIcon,
      'dislikeIcon': AppConstants.dislikeIcon,
      'heading': 'John Doe - Anxiety Patient',
      'subHeading':
          'Persistent sadness, lack of energy, loss of interest in activities',
    },
    {
      'image': AppConstants.profileAvatar,
      'likeIcon': AppConstants.likeIcon,
      'dislikeIcon': AppConstants.dislikeIcon,
      'heading': 'Jane Smith - Depression Patient',
      'subHeading':
          'Persistent sadness, lack of energy, loss of interest in activities',
    },
    {
      'image': AppConstants.profileAvatar,
      'likeIcon': AppConstants.likeIcon,
      'dislikeIcon': AppConstants.dislikeIcon,
      'heading': 'John Doe - Anxiety Patient',
      'subHeading':
          'Persistent sadness, lack of energy, loss of interest in activities',
    },
    {
      'image': AppConstants.profileAvatar,
      'likeIcon': AppConstants.likeIcon,
      'dislikeIcon': AppConstants.dislikeIcon,
      'heading': 'Jane Smith - Depression Patient',
      'subHeading':
          'Persistent sadness, lack of energy, loss of interest in activities',
    },
    {
      'image': AppConstants.profileAvatar,
      'likeIcon': AppConstants.likeIcon,
      'dislikeIcon': AppConstants.dislikeIcon,
      'heading': 'John Doe - Anxiety Patient',
      'subHeading':
          'Persistent sadness, lack of energy, loss of interest in activities',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 230.0,
                enlargeCenterPage: true,
                // Enlarge the center card
                viewportFraction: 0.9,
                // Adjust the fraction of the viewport width
                autoPlay: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                // Disable infinite scroll if needed
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
              items: cardData.asMap().entries.map((entry) {
                Map<String, dynamic> data = entry.value;
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
                                Color(0xFF06B8BE), // Color with 100% opacity
                                Color(0xFF7186F4), // Color with 100% opacity
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.0,
                                1.0
                              ], // Stop values 0% and 100%// Optional stops for gradient color distribution
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title and icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 16),
                                      child: Text(
                                        data['text'],
                                        style: TextStyle(
                                          fontFamily: "InterMedium",
                                          fontSize: 16.0,
                                          color: Colors
                                              .white, // Text color on top of gradient
                                        ),
                                        maxLines: 2, // Set max lines to 2
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow with ellipsis if necessary
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, right: 8),
                                    child: SvgPicture.asset(
                                        "assets/svg/cardIcon.svg"),
                                  ),
                                ],
                              ),

                              //subheading
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    data['subHeading'],
                                    style: TextStyle(
                                      fontFamily: "InterRegular",
                                      fontSize: 11.0,
                                      color: Colors
                                          .white, // Text color on top of gradient
                                    ),
                                    maxLines: 3, // Set max lines to 2
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow with ellipsis if necessary
                                  ),
                                ),
                              ),

                              //images and button
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...data['images'].map<Widget>((imagePath) {
                                      return Container(
                                        margin: EdgeInsets.all(8.0),
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){Navigator.push(context, FadePageRouteBuilder(widget: ChatDetailView(chatTitle: data['text'])));},
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
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
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
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
              dotsCount: cardData.length,
              position: currentPage.toDouble(),
              decorator: DotsDecorator(
                color: Colors.white.withOpacity(0.5),
                activeColor: Colors.white,
                // Change to desired color
                size: const Size.square(9.0),
                activeSize: const Size(12.0, 6.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),

            // GridView
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1,
              ),
              itemCount: boatsData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        FadePageRouteBuilder(
                            widget: ChatDetailView(
                                chatTitle: boatsData[index]['heading'])));
                  },
                  child: Container(
                    height: 150,
                    child: Card(
                      color: Color(0xFF092765).withOpacity(0.6),
                      // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${boatsData[index]['heading']}",
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
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Text(
                              "${boatsData[index]['subHeading']}",
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
                          Padding(
                            padding:
                                EdgeInsets.only(left: 8, bottom: 10, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "${boatsData[index]['likeIcon']}",
                                  height: 15,
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "70K",
                                  style: TextStyle(
                                      color: AppConstants.fontColor,
                                      fontSize: 11),
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  "${boatsData[index]['dislikeIcon']}",
                                  height: 15,
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "70K",
                                  style: TextStyle(
                                      color: AppConstants.fontColor,
                                      fontSize: 11),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
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
                                      child: Image.asset(
                                        "${boatsData[index]['image']}",
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
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

  final List<Map<String, dynamic>> boatsData = [
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy. ',
      'subHeading': 'John Doe-Smith',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Depression Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    },
    {
      'image': AppConstants.profileAvatar,
      'proIcon': AppConstants.proIcon,
      'heading': 'Anxiety Patient Persistant lack of energy',
      'subHeading': 'John Doe',
      'activeStatus': 'OFF'
    }
  ];

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: boatsData.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: (){Navigator.push(context, FadePageRouteBuilder(widget: Upgradeview()));},
                child: Card(
                  margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                  // Adjust margins as needed
                  color: Color(0xFF092765).withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Row(
                          children: [
                            Spacer(),
                            SvgPicture.asset(boatsData[index]['proIcon'],
                                height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.asset(boatsData[index]['image']),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 16, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${boatsData[index]['heading']}",
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
                              "${boatsData[index]['subHeading']}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppConstants.fontColor,
                                fontFamily: "JostMedium",
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${boatsData[index]['activeStatus']}",
                              style: TextStyle(
                                color: AppConstants.fontColor,
                                fontFamily: "InterRegular",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final List<Map<String, dynamic>> boatsData = [
    {
      'heading': "Overcoming",
      'title': "Depression",
      'icon': AppConstants.depression
    },
    {'heading': "Tackling", 'title': "Stress", 'icon': AppConstants.stress},
    {'heading': "Managing", 'title': "Anger", 'icon': AppConstants.angerIcon},
    {
      'heading': "Dealing with",
      'title': "Anxiety",
      'icon': AppConstants.anxiety
    },
    {
      'heading': "Thought",
      'title': "Behaviour Circle",
      'icon': AppConstants.behaviourCircle
    },
    {
      'heading': "Adjusting",
      'title': "Negative Thoughts",
      'icon': AppConstants.negativeThoughts
    },
  ];

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1,
          ),
          itemCount: boatsData.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
              // Adjust margins as needed
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
                      boatsData[index]['heading'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "JostMedium",
                        fontSize: 14,
                        color: AppConstants.fontColor,
                      ),
                    ),
                    Text(
                      boatsData[index]['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "JostMedium",
                        fontSize: 20,
                        color: AppConstants.fontColor,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset(
                          boatsData[index]['icon'],
                          height: 55,
                          width: 53,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
