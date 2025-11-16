// import 'package:flutter/material.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         // ✅ Make the whole page scrollable
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ Your custom app bar at the top
//             const CustomAppBar(),

//             // ✅ Main content area
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 📱 Left side image
//                   Expanded(
//                     flex: 1,
//                     child: Image.asset(
//                       'assets/images/signup_image.png', // use same or different image
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   const SizedBox(width: 60),

//                   // 📝 Right side form
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Log in to Exclusive",
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           "Enter your details below",
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 40),

//                         // Email or phone
//                         _buildTextField("Email"),
//                         const SizedBox(height: 20),

//                         // Password
//                         _buildTextField("Password", isPassword: true),
//                         const SizedBox(height: 30),

//                         // 🔴 Login button + Forgot password
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Login button
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Add your login logic here
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.redAccent,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 60, vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Log In",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),

//                             // Forgot Password
//                             InkWell(
//                               onTap: () {
//                                 // Navigate to forgot password page
//                               },
//                               child: const Text(
//                                 "Forget Password?",
//                                 style: TextStyle(
//                                   color: Colors.redAccent,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ✅ Your custom footer at the bottom
//             const CustomFooter(),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Reusable text field widget
//   Widget _buildTextField(String hintText, {bool isPassword = false}) {
//     return TextField(
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: const UnderlineInputBorder(),
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/auth_service.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Future<void> _handleLogin() async {
  //   setState(() => _isLoading = true);

  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();

  //   if (email.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please fill all fields")),
  //     );
  //     setState(() => _isLoading = false);
  //     return;
  //   }

  //   String? message = (await _authService.login(email, password)) as String?;

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message ?? "Something went wrong")),
  //   );

  //   setState(() => _isLoading = false);

  //   if (message == "Login successful!") {
  //     // Navigate to home or dashboard
  //     Navigator.pushNamed(context, '/home');
  //   }
  // }
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      setState(() => _isLoading = false);
      return;
    }

    final result = await _authService.login(email, password);

    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(content: Text(result?['message'] ?? "Something went wrong")),
      SnackBar(content: Text("${result['message'] ?? "Something went wrong"}")),
    );

    setState(() => _isLoading = false);

    if (result!['success'] == true) {
      // ✅ Navigate and remove login screen from stack
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/images/signup_image.png'),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Log in to Exclusive",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter your details below",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField("Email", _emailController),
                        const SizedBox(height: 20),
                        _buildTextField("Password", _passwordController,
                            isPassword: true),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 16),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text("Log In",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/reset-password');
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
