

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinny_ai_chat/view/Navigation_ChatView/boatProfileDetail_view.dart';
import '../../Providers/chat_provider.dart';
import '../../constants/AppConstants.dart';
import '../../helper/transition.dart';


class ChatDetailView extends StatefulWidget {
  final String chatTitle;

  const ChatDetailView({Key? key, required this.chatTitle}) : super(key: key);

  @override
  _ChatDetailViewState createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _onNewMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF06B8BE),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context, FadePageRouteBuilder(widget: BoatprofiledetailView()));
          },
          child: Text(
            widget.chatTitle,
            style: TextStyle(
              fontFamily: "InterRegular",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                final messages = chatProvider.getMessages(widget.chatTitle);
                final reversedMessages = messages.reversed.toList();

                if (reversedMessages.isEmpty) {
                  return Center(
                    child: Text("No messages yet.",style: TextStyle(color: Colors.white),),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: reversedMessages.length,
                  itemBuilder: (context, index) {
                    final message = reversedMessages[index];
                    return ListTile(
                      title: Align(
                        alignment: message["sender"] == "me"
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message["sender"] == "me"
                                ? Colors.blue
                                : Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: message.containsKey("text")
                              ? Text(
                            message["text"],
                            style: TextStyle(color: Colors.white),
                          )
                              : GestureDetector(
                            onTap: () async {
                              if (chatProvider.isPlaying) {
                                await _audioPlayer.pause();
                              } else {
                                await _audioPlayer.setSourceDeviceFile(
                                    message["audio"]);
                                await _audioPlayer.resume();
                              }
                              chatProvider.togglePlaying();
                            },
                            child: Icon(
                              chatProvider.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      subtitle: Align(
                        alignment: message["sender"] == "me"
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (message["sender"] == "me")
                              Icon(
                                Icons.done_all,
                                color: Colors.blue,
                              ),
                            if (message["sender"] == "me") SizedBox(width: 4),
                            Text(
                              message["time"],
                              style: TextStyle(color: Colors.grey),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                    return Visibility(
                      visible: chatProvider.showStar,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                onPressed: () {
                                  chatProvider.selectStar(index + 1);
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: index < chatProvider.selectedStar
                                      ? Colors.yellowAccent
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ),
                          Text(
                            "Rate this chat boat!",
                            style: TextStyle(color: AppConstants.fontColor),
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    if (context.watch<ChatProvider>().showAdditionalIcons)
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.grey),
                            onPressed: () {
                              showSnackbar(context,
                                  'This feature is in development phase!');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.mic, color: Colors.grey),
                            onPressed: () {
                              showSnackbar(context,
                                  'This feature is in development phase!');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.star, color: Colors.grey),
                            onPressed: () {
                              context.read<ChatProvider>().toggleStar();
                            },
                          ),
                        ],
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          shape: BoxShape.circle, // Circular shape
                        ),

                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            context.read<ChatProvider>().showAdditionalIcons1();
                          },
                        ),
                      ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 48.0,
                          maxHeight: 150.0,
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          minLines: 1,
                          onChanged: (text) {
                            context.read<ChatProvider>().setTyping(text.isNotEmpty);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Consumer<ChatProvider>(
                              builder: (context, chatProvider, _) {
                                return chatProvider.isLoading
                                    ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                                    : IconButton(
                                  onPressed: () {
                                    if (_controller.text.isNotEmpty) {
                                      FocusScope.of(context).unfocus();
                                      chatProvider.sendMessage(
                                          widget.chatTitle, _controller.text);
                                      _controller.clear();
                                      _onNewMessage();
                                      chatProvider.setTyping(false);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: chatProvider.isTyping
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                );
                              },
                            ),
                            hintText: "Message",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                        // child: TextField(
                        //   controller: _controller,
                        //   maxLines: null,
                        //   minLines: 1,
                        //   onChanged: (text) {
                        //     context.read<ChatProvider>().setTyping(text.isNotEmpty);
                        //   },
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     suffixIcon: Consumer<ChatProvider>(
                        //       builder: (context, chatProvider, _) {
                        //         return IconButton(
                        //           onPressed: () {
                        //             if (_controller.text.isNotEmpty) {
                        //               chatProvider.sendMessage(
                        //                   widget.chatTitle, _controller.text);
                        //               _controller.clear();
                        //               _onNewMessage();
                        //               chatProvider.setTyping(false);
                        //             }
                        //           },
                        //           icon: Icon(
                        //             Icons.send,
                        //             color: chatProvider.isTyping
                        //                 ? Colors.blue
                        //                 : Colors.grey,
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //     hintText: "Message",
                        //     hintStyle: TextStyle(color: Colors.grey),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 16, vertical: 12),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}








