import 'package:flutter/material.dart';

class SupportArticle extends StatefulWidget {
  final String articleName;
  final String articleContent;
  const SupportArticle({
    Key? key,
    required this.articleName,
    required this.articleContent,
  }) : super(key: key);

  @override
  State<SupportArticle> createState() => _SupportArticleState();
}

class _SupportArticleState extends State<SupportArticle> {
  int articleHelpful = 0;

  @override
  void dispose() {
    super.dispose();
    articleHelpful = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Support'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Title(
              color: Colors.black,
              child: Text(
                widget.articleName,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.articleContent,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
              height: 90,
            ),
            const Text(
              'Was this article helpful?',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  isSelected: articleHelpful == 1,
                  iconSize: 33,
                  icon: const Icon(Icons.sentiment_very_satisfied),
                  onPressed: () {
                    setState(() {
                      articleHelpful = 1;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your feedback!'),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  isSelected: articleHelpful == 2,
                  iconSize: 33,
                  icon: const Icon(Icons.sentiment_neutral),
                  onPressed: () {
                    setState(() {
                      articleHelpful = 2;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your feedback!'),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  isSelected: articleHelpful == 3,
                  iconSize: 33,
                  icon: const Icon(Icons.sentiment_very_dissatisfied),
                  onPressed: () {
                    setState(() {
                      articleHelpful = 3;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your feedback!'),
                        ),
                      );
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }
}
