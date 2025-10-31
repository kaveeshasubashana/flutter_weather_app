import 'package:flutter/material.dart';
import 'weather_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(134, 9, 32, 159),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 //image
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                                'assets/image.jpg',
                                  height: 200,                    
                              ),
                     ),
          
                  const SizedBox(height: 110),
                
                //wellcome text
                const Text(
                  "Daily Weather",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //wellcome text
                const Text(
                  'Check today’s weather anywhere, anytime',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
          
               
                 
          
          
          
          
                //button
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to weather screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const WeatherScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,         
                        foregroundColor: Colors.white,         
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), 
                        shape: RoundedRectangleBorder(        
                        borderRadius: BorderRadius.circular(20),
                          ),
                             elevation: 5,                          
                        ),
                      child: const Text(
                               "Get Started",
                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
      
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
