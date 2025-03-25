import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Messages',
      home: MessageScreen(),
    );
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey Yoni, Thanks for stopping by. Tap here to continue.',
      'color': Colors.blue
    },
    {'text': 'Tap again', 'color': Colors.green},
    {'text': 'Thanks and again', 'color': Colors.orange},
    {'text': 'Lovely, you get how this works', 'color': Colors.purple},
    {'text': 'This kinda feels like', 'color': Colors.red},
    {'text': 'A WhatsApp status', 'color': Colors.teal},
    {'text': 'Just a lot better', 'color': Colors.yellow},
    {'text': 'Anyway', 'color': Colors.pink},
    {'text': "I wanted", 'color': Colors.indigo},
    {'text': 'To wish you', 'color': Colors.purple},
    {'text': 'A very happy birthday', 'color': Colors.lime},
    {'text': 'You should have', 'color': Colors.deepOrange},
    {'text': 'A lot of hatzlacha', 'color': Colors.amber},
    {'text': 'In everything you do', 'color': Colors.purpleAccent},
    {'text': 'All the brochos', 'color': Colors.brown},
    // {'text': 'BTW turn up the sound', 'color': Colors.lightGreen},
    // {'text': '😅', 'color': Colors.blueAccent},
    {'text': "I hope you're enjoying the present", 'color': Colors.lightBlue},
    {'text': "and this present ation", 'color': Colors.teal},
    {'text': "had to lol", 'color': Colors.greenAccent},
    {
      'text': "Don't worry, I'll take you back to WhatsApp",
      'color': Colors.lightGreen,
      'link':
          "https://wa.me/447709004207?text=Yechiel%20that%20was%20sick!%20wishing%20you%20all%20the%20brochos."
    },
  ];

  int currentIndex = 0;

  void _nextMessage() {
    setState(() {
      currentIndex = (currentIndex + 1) % messages.length;
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentMessage = messages[currentIndex];
    final isLink = currentMessage.containsKey('link');

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: currentMessage['color'],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: GestureDetector(
              onTap: isLink
                  ? () => _launchURL(currentMessage['link'])
                  : _nextMessage,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  currentMessage['text'],
                  key: ValueKey<int>(currentIndex),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
