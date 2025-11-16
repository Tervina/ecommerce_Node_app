// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
// import 'package:flutter/material.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(),
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 🧭 Breadcrumb
//                 const Text(
//                   'Home / Contact',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 40),

//                 // 🧱 Main Content Row
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Left Info Box
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _contactItem(
//                               icon: Icons.phone_in_talk_rounded,
//                               title: 'Call To Us',
//                               subtitle:
//                                   'We are available 24/7, 7 days a week.\nPhone: +8801611122222',
//                             ),
//                             Divider(color: Colors.grey.shade300, height: 40),
//                             _contactItem(
//                               icon: Icons.email_rounded,
//                               title: 'Write To Us',
//                               subtitle:
//                                   'Fill out our form and we will contact you within 24 hours.\n\nEmails:\ncustomer@exclusive.com\nsupport@exclusive.com',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 40),

//                     // Right Form Box
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Top 3 input fields
//                             Row(
//                               children: [
//                                 Expanded(child: _textField('Your Name *')),
//                                 const SizedBox(width: 16),
//                                 Expanded(child: _textField('Your Email *')),
//                                 const SizedBox(width: 16),
//                                 Expanded(child: _textField('Your Phone *')),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             _textField('Your Message', maxLines: 6),
//                             const SizedBox(height: 24),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       const Color(0xFFE34234), // red
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40, vertical: 18),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   // TODO: send message logic
//                                 },
//                                 child: const Text(
//                                   'Send Message',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const CustomFooter()
//         ],
//       ),
//     );
//   }

//   // 📞 Contact Item Widget
//   Widget _contactItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFECEC),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: const Color(0xFFE34234), size: 26),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 8),
//               Text(subtitle, style: const TextStyle(fontSize: 15)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ✏️ Reusable TextField Widget
//   Widget _textField(String hint, {int maxLines = 1}) {
//     return TextField(
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.grey),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xFFE34234)),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//       ),
//     );
//   }
// }
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🧭 Breadcrumb
                  const Text(
                    'Home / Contact',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  // 🧱 Main Content Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Info Box
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _contactItem(
                                icon: Icons.phone_in_talk_rounded,
                                title: 'Call To Us',
                                subtitle:
                                    'We are available 24/7, 7 days a week.\nPhone: +8801611122222',
                              ),
                              Divider(color: Colors.grey.shade300, height: 40),
                              _contactItem(
                                icon: Icons.email_rounded,
                                title: 'Write To Us',
                                subtitle:
                                    'Fill out our form and we will contact you within 24 hours.\n\nEmails:\ncustomer@exclusive.com\nsupport@exclusive.com',
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),

                      // Right Form Box
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top 3 input fields
                              Row(
                                children: [
                                  Expanded(child: _textField('Your Name *')),
                                  const SizedBox(width: 16),
                                  Expanded(child: _textField('Your Email *')),
                                  const SizedBox(width: 16),
                                  Expanded(child: _textField('Your Phone *')),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _textField('Your Message', maxLines: 6),
                              const SizedBox(height: 24),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFE34234), // red
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: send message logic
                                  },
                                  child: const Text(
                                    'Send Message',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🦶 Footer (no padding)
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  // 📞 Contact Item Widget
  Widget _contactItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xFFFFECEC),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFFE34234), size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ],
    );
  }

  // ✏️ Reusable TextField Widget
  Widget _textField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE34234)),
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
