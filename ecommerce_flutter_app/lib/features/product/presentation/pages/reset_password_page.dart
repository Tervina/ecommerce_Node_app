// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_appBar.dart';
// import 'package:ecommerce_flutter_app/features/product/presentation/widgets/custom_footer.dart';

// class ResetPasswordPage extends StatefulWidget {
//   final String? email; // coming from previous OTP screen

//   const ResetPasswordPage({super.key, this.email});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final _emailController = TextEditingController();

//   final _passwordController = TextEditingController();
//   final _confirmController = TextEditingController();

//   bool loading = false;
//   final dio = Dio();

//   Future<void> resetPassword() async {
//     if (_passwordController.text != _confirmController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Passwords do not match!")),
//       );
//       return;
//     }

//     if (widget.email == null || widget.email!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Email is missing! Cannot reset.")),
//       );
//       return;
//     }

//     setState(() => loading = true);

//     try {
//       final response = await dio.post(
//         "http://localhost:3000/auth/reset-password",
//         data: {
//           "email": widget.email,
//           "newPassword": _passwordController.text,
//         },
//       );

//       setState(() => loading = false);

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Password updated successfully!")),
//         );
//         Navigator.pushReplacementNamed(context, "/login");
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
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
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image side
//                   Expanded(
//                     flex: 1,
//                     child: Image.asset('assets/images/signup_image.png'),
//                   ),

//                   const SizedBox(width: 60),

//                   // Reset password form
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Reset Your Password",
//                           style: TextStyle(
//                               fontSize: 32, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Updating password for: ${widget.email ?? "Unknown"}",
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 40),
//                         _buildTextField("Email", _emailController),
//                         const SizedBox(height: 20),
//                         _buildTextField("New Password", _passwordController,
//                             isPassword: true),
//                         const SizedBox(height: 20),
//                         _buildTextField("Confirm Password", _confirmController,
//                             isPassword: true),
//                         const SizedBox(height: 30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ElevatedButton(
//                               onPressed: loading ? null : resetPassword,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.redAccent,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 60, vertical: 16),
//                               ),
//                               child: loading
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white)
//                                   : const Text("Reset Password",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 18)),
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

//   Widget _buildTextField(String hint, TextEditingController controller,
//       {bool isPassword = false}) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: const InputDecoration(
//         border: UnderlineInputBorder(),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.black),
//         ),
//       ).copyWith(hintText: hint),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? email;

  const ResetPasswordPage({super.key, this.email});
  // const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _loading = false;

  Future<void> resetPassword() async {
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await Dio().post(
        "http://localhost:5000/api/auth/reset-password",
        data: {
          "email": _emailController.text.trim(),
          "newPassword": _passwordController.text.trim(),
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data["message"] ?? "Success!")),
      );
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => _loading = false);
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "RESET NEW PASSWORD",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // EMAIL FIELD
                _buildTextField("Email", _emailController),

                // NEW PASSWORD
                _buildTextField("New Password", _passwordController,
                    isPassword: true),

                // CONFIRM PASSWORD
                _buildTextField("Confirm Password", _confirmController,
                    isPassword: true),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _loading ? null : resetPassword,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text("Reset", style: TextStyle(fontSize: 18)),
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
