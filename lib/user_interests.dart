import 'package:flutter/material.dart';
import 'dashboard.dart';

class UserInterestsScreen extends StatefulWidget {
  const UserInterestsScreen({super.key});

  @override
  State<UserInterestsScreen> createState() => _UserInterestsScreenState();
}

class _UserInterestsScreenState extends State<UserInterestsScreen> {
  final List<String> allInterests = [
    'Hard Times', 'Working Out', 'Productivity', 'Self-esteem', 'Achieving Goals', 'Inspiration',
    'Letting Go', 'Love', 'Relationships', 'Faith & Spirituality', 'Positive Thinking', 'Stress & Anxiety'
  ];
  final Set<String> selectedInterests = {};

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      }
      else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'Select all topics that\nmotivates you.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                child: GridView.count(
                  crossAxisCount: 2, //2 columns per row
                  mainAxisSpacing: 16, //vertical spacing between rows
                  crossAxisSpacing: 16, //horizontal spacing between columns
                  childAspectRatio: 3, //width to height ratio of each button
                  shrinkWrap: true, //making the grid take only as much vertical space as needed by its children
                  physics: const NeverScrollableScrollPhysics(), //disabling scroll inside column
                  children: allInterests.map((interest) {
                    final isSelected = selectedInterests.contains(interest);
                    return TextButton(
                      onPressed: () => toggleInterest(interest),
                      style: TextButton.styleFrom(
                        backgroundColor: isSelected ? Colors.lightGreenAccent : Colors.grey[700],
                        foregroundColor: isSelected ? Colors.black : Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18), //padding inside buttons
                      ),
                      child: Text(
                        interest,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 200,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}