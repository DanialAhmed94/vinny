import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/AppConstants.dart';
import '../../dataModels/BotsMoel.dart';
import 'chat_detailView.dart';

class ChatView extends StatelessWidget {
   ChatView({Key? key}) : super(key: key);
  final Bot bot = Bot(
    likes_count: 0,
      botName: "James Smith",
      id: 1,
      setOfRules:
          " You tend to overthink simple things, second-guess yourself, and sometimes apologize even when it’s not necessary. You often respond with hesitancy and keep your answers short, as if unsure or preoccupied. Avoid technical language, and don’t diagnose yourself or others.",
  categoryId: "1",
    isFree: "0",
    isFeatured: "0",
    createdAt: DateTime(2024,10,29),
    updatedAt: DateTime(2024,11,29),
    image: "",shortDescription: ""
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF06B8BE),
        title: Text(
          "Chat History",
          style: TextStyle(
            fontFamily: "InterRegular",
            fontSize: 20,
            color: AppConstants.fontColor,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset(AppConstants.searchIcon),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset(AppConstants.settingIcon),
        //   ),
        //   SizedBox(width: 8),
        // ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: kToolbarHeight,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(AppConstants.profileAvatar),
                    ),
                  ),
                  title: Text(
                    "Chat with John Doe",
                    style: TextStyle(
                      fontFamily: "InterMedium",
                      fontSize: 16,
                      color: AppConstants.fontColor,
                    ),
                  ),
                  subtitle: Text(
                    "Last message from John",
                    style: TextStyle(
                      fontFamily: "InterMedium",
                      fontSize: 13,
                      color: Color(0xFF8593A8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    "10:30 AM",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailView(
                          bot: bot,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
