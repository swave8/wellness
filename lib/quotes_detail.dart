import 'package:flutter/material.dart';

class QuotesDetailScreen extends StatefulWidget {
  final String category;

  const QuotesDetailScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuotesDetailScreen> createState() => _QuotesDetailScreenState();
}

class _QuotesDetailScreenState extends State<QuotesDetailScreen> {
  int currentPage = 0;
  late PageController pageController;
  Set<String> likedQuotes = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Map<String, List<Map<String, String>>> quotes = {
    'Feeling Blessed': [
      {
        'quote': 'When you focus on the good, the good gets better',
        'author': 'Abraham Hicks',
      },
      {
        'quote': 'Blessings come in moments. Be ready to notice them',
        'author': 'Unknown',
      },
      {
        'quote': 'What seems to us as bitter trials are often blessings in disguise',
        'author': 'Oscar Wilde',
      },
      {
        'quote': 'Acknowledging the good that you already have in your life is the foundation for all abundance',
        'author': 'Eckhart Tolle',
      },
      {
        'quote': 'Start each day with a grateful heart',
        'author': 'Unknown',
      },
    ],
    'Pride Month': [
      {
        'quote': 'Visibility creates possibility',
        'author': 'Janet Mock',
      },
      {
        'quote': 'Out of the closet and into the streets',
        'author': 'LGBTQ+ Activist Chant',
      },
      {
        'quote': 'You deserve a life filled with pride and free of shame',
        'author': 'Unknown',
      },
      {
        'quote': 'Being different isn’t a problem—it’s your strength',
        'author': 'Jazz Jennings',
      },
    ],
    'Self-worth': [
      {
        'quote': 'No one can make you feel inferior without your consent',
        'author': 'Eleanor Roosevelt',
      },
      {
        'quote': 'You are not a drop in the ocean. You are the entire ocean in a drop',
        'author': 'Rumi',
      },
      {
        'quote': 'Don’t shrink to fit places you’ve outgrown',
        'author': 'Unknown',
      },
      {
        'quote': 'You owe yourself the love you so freely give to others',
        'author': 'Unknown',
      },
    ],
    'Love': [
      {
        'quote': 'True love begins when nothing is looked for in return',
        'author': 'Antoine de Saint-Exupéry',
      },
      {
        'quote': 'Love is composed of a single soul inhabiting two bodies',
        'author': 'Aristotle',
      },
      {
        'quote': 'To be fully seen by somebody, then, and be loved anyhow – this is a human offering that can border on miraculous',
        'author': 'Elizabeth Gilbert',
      },
      {
        'quote': 'Love recognizes no barriers. It jumps hurdles, leaps fences, penetrates walls to arrive at its destination full of hope',
        'author': 'Maya Angelou',
      },
    ],
  };


  @override
  Widget build(BuildContext context) {
    //getting quote list for current category
    final List<Map<String, String>> currentQuotes = quotes[widget.category] ?? [];

    return Scaffold(
      // extendBodyBehindAppBar: false, //preventing the body from rendering behind the app bar
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 16, 2, 16),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          widget.category,
          style: TextStyle(
            fontSize: 23
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${currentPage + 1}/${quotes[widget.category]?.length ?? 0}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: PageView.builder( //allows us to scroll
          controller: pageController,
          scrollDirection: Axis.vertical, //vertical
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemCount: currentQuotes.length, //telling the pageview how many pages/quotes to render
          itemBuilder: (context, index) {
            final quote = currentQuotes[index]; //index is used to get the quote from the list
            final quoteText = quote['quote']!;
            final isLiked = likedQuotes.contains(quoteText);
        
            return Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(79, 77, 77, 0.737)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          //
                        },
                        icon: Icon(Icons.volume_up, size: 25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 160),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"${quote['quote']}"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '- ${quote['author']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                  //scroll up gesture animation (using Lottie)
                  Icon(Icons.back_hand),
                  const Text(
                    'Swipe up',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 85),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (isLiked) {
                              likedQuotes.remove(quoteText);
                            } else {
                              likedQuotes.add(quoteText);
                            }
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_outline,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.paste, size: 40),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}