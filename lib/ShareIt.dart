import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareWithFriendsPage extends StatelessWidget {
  final String appLink = 'https://your-app-link.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share with Friends'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Share this app with your friends!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _shareAppWithWhatsApp();
              },
              child: Text('Share with WhatsApp'),
            ),
            ElevatedButton(
              onPressed: () {
                _shareAppWithGmail();
              },
              child: Text('Share with Gmail'),
            ),
            ElevatedButton(
              onPressed: () {
                _shareAppWithFacebook();
              },
              child: Text('Share with Facebook'),
            ),
          ],
        ),
      ),
    );
  }

  void _shareAppWithWhatsApp() async {
    String text = 'Check out this awesome app: $appLink';
    await Share.share(text, subject: 'App Sharing');
  }

  void _shareAppWithGmail() async {
    String subject = 'Check out this awesome app!';
    String body = 'Hey, I found this amazing app: $appLink';
    String url = 'mailto:?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch email app.');
    }
  }

  void _shareAppWithFacebook() async {
    String url = 'https://www.facebook.com/sharer/sharer.php?u=$appLink';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch Facebook app.');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ShareWithFriendsPage(),
  ));
}
