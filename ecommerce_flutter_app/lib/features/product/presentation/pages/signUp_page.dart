// import 'package:ecommerce_flutter_app/features/product/data/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;

//   final AuthService _authService = AuthService();

//   Future<void> _handleSignUp() async {
//     setState(() => _isLoading = true);

//     String name = _nameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     if (name.isEmpty || email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields")),
//       );
//       setState(() => _isLoading = false);
//       return;
//     }

//     String? message = await _authService.signUp(name, email, password);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message ?? "Something went wrong")),
//     );

//     setState(() => _isLoading = false);
//   }

//   Future<void> _signInWithGoogle() async {
//     final supabase = Supabase.instance.client;
//     try {
//       final res = await supabase.auth.signInWithOAuth(
//         OAuthProvider.google,
//         redirectTo: 'http://localhost:5000/api/auth/google/callback',
//       );

//       // This opens browser — Supabase handles OAuth flow
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomAppBar(),

//             // 🧩 Main content
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 🖼️ Left side - image
//                   Expanded(
//                     flex: 1,
//                     child: Image.asset(
//                       'assets/images/signup_image.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(width: 60),

//                   // 📝 Right side - form
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Create an account",
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

//                         _buildTextField("Name", _nameController),
//                         const SizedBox(height: 20),
//                         _buildTextField("Email", _emailController),
//                         const SizedBox(height: 20),
//                         _buildTextField("Password", _passwordController,
//                             isPassword: true),
//                         const SizedBox(height: 30),

//                         // 🔴 Create Account button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _isLoading ? null : _handleSignUp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.redAccent,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                             child: _isLoading
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white)
//                                 : const Text(
//                                     "Create Account",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // 🔵 Sign up with Google
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton.icon(
//                             onPressed: _signInWithGoogle,
//                             icon: Image.asset(
//                               'assets/images/google.png',
//                               height: 24,
//                             ),
//                             label: const Text(
//                               "Sign up with Google",
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.black),
//                             ),
//                             style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               side: const BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // 👤 Already have account
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already have an account? ",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(context, '/login');
//                               },
//                               child: const Text(
//                                 "Log in",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
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

//             const CustomFooter(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String hintText, TextEditingController controller,
//       {bool isPassword = false}) {
//     return TextField(
//       controller: controller,
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
// }import 'package:ecommerce_flutter_app/features/product/data/services/auth_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Listen for OAuth callback
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null && mounted) {
        // User successfully authenticated with Google
        _handleGoogleSignInSuccess(session);
      }
    });
  }

  Future<void> _handleGoogleSignInSuccess(Session session) async {
    try {
      final user = session.user;

      // Extract user information
      final name = user.userMetadata?['full_name'] ??
          user.userMetadata?['name'] ??
          user.email?.split('@')[0] ??
          'User';

      // Send to backend
      final response = await _authService.googleLogin(
        user.id,
        user.email ?? '',
        name,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response ?? "Google sign-in successful!")),
        );

        // Navigate to home page
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error syncing with backend: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSignUp() async {
    setState(() => _isLoading = true);

    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      setState(() => _isLoading = false);
      return;
    }

    String? message = await _authService.signUp(name, email, password);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? "Something went wrong")),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // Use the correct Supabase callback URL
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://ufwatjrtbxpwawbonpjt.supabase.co/auth/v1/callback',
      );

      // The auth listener will handle the rest after user returns
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    child: Image.asset(
                      'assets/images/signup_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Create an account",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter your details below",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField("Name", _nameController),
                        const SizedBox(height: 20),
                        _buildTextField("Email", _emailController),
                        const SizedBox(height: 20),
                        _buildTextField("Password", _passwordController,
                            isPassword: true),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _isLoading ? null : _signInWithGoogle,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                  ),
                            label: const Text(
                              "Sign up with Google",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
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

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
