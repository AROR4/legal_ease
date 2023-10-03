import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() => runApp(MaterialApp(home: HelpPage()));

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  double userRating = 0; // Track user's selected rating
  List<ChatMessage> messages = []; // Store chat messages

  // Added the new question
  List<QuestionAnswer> predefinedQuestions = [
    QuestionAnswer(
      question: "How do I reset my password?",
      answer: "To reset your password, go to the 'Forgot Password' page...",
    ),
    QuestionAnswer(
      question: "Where can I find the user manual?",
      answer: "You can download the user manual from our website...",
    ),
    QuestionAnswer(
      question: "Rate our app",
      answer: "RateDialog", // Special keyword to handle showing rating dialog
    ),
  ];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
     
      setState(() {
        showScrollToBottomButton = false;
      });
    } else {
      // User is not at the bottom of the chat
      // Show the scroll-to-bottom button
      setState(() {
        showScrollToBottomButton = true;
      });
    }
  }

  bool showScrollToBottomButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // iconTheme: IconThemeData.fallback(),
        // backgroundColor: Color.fromARGB(255, 52, 103, 255),
        title: Text(
          "Help & Support",
          style: TextStyle(
            // fontFamily: "Roboto Mono",
            // fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      // backgroundColor: Color.fromARGB(255, 241, 243, 247),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach ScrollController
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message.isFromUser;
                final cardColor = isUserMessage ? Colors.blue : Colors.green;

                return Container(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Card(
                    elevation: 2, // Add elevation for a slight shadow effect
                    color: cardColor, // Set card color based on sender
                    shape: RoundedRectangleBorder(
                      borderRadius: isUserMessage
                          ? BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                              bottomLeft: Radius.circular(
                                  16.0), // Circular edges for user message
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                              bottomRight: Radius.circular(
                                  16.0), // Circular edges for bot message
                            ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ).py12().px4(),
                );
              },
            ),
          ),
          if (showScrollToBottomButton)
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: scrollToBottom,
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                itemCount: predefinedQuestions.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16.0), // Circular edges for predefined questions
                    ),
                    child: ListTile(
                      title: Text(predefinedQuestions[index].question),
                      onTap: () {
                        final question = predefinedQuestions[index].question;
                        final answer = predefinedQuestions[index].answer;
                        addMessage("User: $question", true);
                        if (answer == "RateDialog") {
                          showRatingDialog(context);
                        } else {
                          addMessage("Bot: $answer", false);
                        }
                        scrollToBottom(); // Scroll to bottom after adding a message
                      },
                    ),
                  ).py1();
                },
              ),
            ).px8(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (message) {
                      sendMessage(message);
                    },
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Implement logic to send the message
                    final message = "User: ${messages.last.text}";
                    sendMessage(message);
                    scrollToBottom(); // Scroll to bottom after sending a message
                  },
                ),
              ],
            ),
          ),
        ],
      ).py(32),
    );
  }

  // Function to send a message
  void sendMessage(String message) {
    addMessage("User: $message", true);
    if (message.toLowerCase().contains("help")) {
      addMessage("Bot: Here is some help...", false);
    } else if (message.toLowerCase().contains("support")) {
      addMessage(
          "Bot: For support, please contact us at support@example.com", false);
    } else {
      addMessage("Bot: I'm sorry, I don't understand.", false);
    }
  }

  // Function to add a message to the chat
  void addMessage(String text, bool isFromUser) {
    setState(() {
      messages.add(ChatMessage(text: text, isFromUser: isFromUser));
    });
  }

  // Function to scroll to the bottom of the chat
  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // Function to show the rating dialog
  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate Our App").centered(),
          content: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: userRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 36, // Adjust the size as needed
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        userRating = rating;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (userRating >= 4) {
                  addMessage("Bot: Thank you for your 5-star rating!", false);
                } else {
                  addMessage(
                      "Bot: We'll work on improving. Thanks for the feedback!",
                      false);
                }
                scrollToBottom();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}

class ChatMessage {
  final String text;
  final bool isFromUser;

  ChatMessage({required this.text, required this.isFromUser});
}