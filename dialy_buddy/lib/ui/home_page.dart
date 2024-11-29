import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/home_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color:
                Colors.black.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  'Daily Buddy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/factPage');
                      },
                      child: const Text(
                        'Daily Facts',
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/newsPage');
                      },
                      child: const Text(
                        'Daily News',
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 50), // Add some space at the bottom if needed
            ],
          ),
        ],
      ),
    );
  }
}
