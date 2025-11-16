import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main row with columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Exclusive
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Exclusive",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text("Subscribe",
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text("Get 10% off your first order",
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.white54),
                                border: InputBorder.none),
                          ),
                        ),
                        Icon(Icons.send, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),

              // Support
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Support",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(height: 8),
                  Text("111 Bijoy sarani, Dhaka,\nDH 1515, Bangladesh.",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text("exclusive@gmail.com",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text("+88015-88888-9999",
                      style: TextStyle(color: Colors.white)),
                ],
              ),

              // Account
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(height: 8),
                  Text("My Account", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Login / Register",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Cart", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Wishlist", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Shop", style: TextStyle(color: Colors.white)),
                ],
              ),

              // Quick Link
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quick Link",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Privacy Policy", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Terms Of Use", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("FAQ", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("Contact", style: TextStyle(color: Colors.white)),
                ],
              ),

              // Download App
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Download App",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text("Save \$3 with App New User Only",
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/qr.png',
                        width: 60,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/google_play.png',
                            width: 100,
                          ),
                          const SizedBox(height: 6),
                          Image.asset(
                            'assets/images/app_store.png',
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.facebook, color: Colors.white),
                      SizedBox(width: 10),
                      // Icon(Icons.twitter, color: Colors.white),
                      SizedBox(width: 10),
                      Icon(Icons.camera_alt,
                          color: Colors.white), // Instagram alt
                      SizedBox(width: 10),
                      Icon(Icons.linked_camera,
                          color: Colors.white), // LinkedIn alt
                    ],
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),

          const Center(
            child: Text(
              "© Copyright Rimel 2022. All right reserved",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
