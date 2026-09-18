import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CricketGameScreen(),
    );
  }
}

class CricketGameScreen extends StatefulWidget {
  const CricketGameScreen({super.key});

  @override
  State<CricketGameScreen> createState() => _CricketGameScreenState();
}

class _CricketGameScreenState extends State<CricketGameScreen> {
  int totalRuns = 0;
  int ballsRemaining = 6;
  String currentBallResult = '';
  final Random _random = Random();

  void playBall() {
    if (ballsRemaining > 0) {
      int runsScored = _random.nextInt(7);

      setState(() {
        totalRuns += runsScored;
        ballsRemaining -= 1;

        if (runsScored == 0) {
          currentBallResult = 'No Runs';
        } else {
          currentBallResult = '$runsScored Runs';
        }
      });
    }
  }

  void restartGame() {
    setState(() {
      totalRuns = 0;
      ballsRemaining = 6;
      currentBallResult = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00569E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mini Cricket',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScoreCard(
                    imagePath: 'assets/images/bat.png',
                    fallbackIcon: Icons.sports_cricket,
                    title: 'Runs',
                    value: '$totalRuns',
                  ),
                  _buildScoreCard(
                    imagePath: 'assets/images/ball.png',
                    fallbackIcon: Icons.sports_baseball,
                    title: 'Balls',
                    value: '$ballsRemaining',
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 32,
                child: Text(
                  currentBallResult,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (ballsRemaining > 0)
                ElevatedButton(
                  onPressed: playBall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00569E),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Bat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: restartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard({
    required String imagePath,
    required IconData fallbackIcon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                fallbackIcon,
                size: 70,
                color: Colors.blueAccent,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
