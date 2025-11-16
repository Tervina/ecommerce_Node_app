import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // ✅ Stays fixed at top
      body: SingleChildScrollView(
        // ✅ Everything scrolls including footer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== Page Content ======
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Our Story Section
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Our Story',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Launched in 2015, Exclusive is South Asia's premier online shopping marketplace with an active presence in Bangladesh. Supported by a wide range of tailored marketing, data and service solutions, Exclusive has 10,500 sellers and 300 brands and serves 3 million customers across the region.\n\nExclusive has more than 1 Million products to offer, growing at a very fast. Exclusive offers a diverse assortment in categories ranging from consumer.",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Image.asset(
                          'assets/images/about.jpg',
                          height: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Statistics Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatisticCard(
                          Icons.store, '10.5k', 'Sellers active on our site'),
                      _buildStatisticCard(
                          Icons.monetization_on, '33k', 'Monthly Product Sale',
                          isHighlighted: true),
                      _buildStatisticCard(
                          Icons.people, '45.5k', 'Customer active in our site'),
                      _buildStatisticCard(Icons.account_balance_wallet, '25k',
                          'Annual gross sale in our site'),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Team Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTeamMemberCard('assets/images/tom_cruise.jpg',
                          'Tom Cruise', 'Founder & Chairman'),
                      _buildTeamMemberCard('assets/images/emma_watson.jpg',
                          'Emma Watson', 'Managing Director'),
                      _buildTeamMemberCard('assets/images/will_smith.jpg',
                          'Will Smith', 'Product Designer'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      '.....',
                      style: TextStyle(fontSize: 24, letterSpacing: 8),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Services Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildServiceCard(
                          Icons.local_shipping,
                          'FREE AND FAST DELIVERY',
                          'Free delivery for all orders over \$140'),
                      _buildServiceCard(
                          Icons.headset_mic,
                          '24/7 CUSTOMER SERVICE',
                          'Friendly 24/7 customer support'),
                      _buildServiceCard(
                          Icons.verified_user,
                          'MONEY BACK GUARANTEE',
                          'We return money within 30 days'),
                    ],
                  ),
                ],
              ),
            ),

            // ====== Footer ======
            const CustomFooter(), // ✅ No padding — full width
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(IconData icon, String value, String label,
      {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.redAccent : Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon,
              size: 40, color: isHighlighted ? Colors.white : Colors.black),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: isHighlighted ? Colors.white : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(String imageUrl, String name, String role) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        Text(name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(role),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.facebook)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.alternate_email)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.link)),
          ],
        )
      ],
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, size: 40),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(subtitle, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
