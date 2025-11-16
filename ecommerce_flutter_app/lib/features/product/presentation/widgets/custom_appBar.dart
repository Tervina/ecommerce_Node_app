import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      flexibleSpace: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.black, // Different color than AppBar
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  "🔥 Flash Sale 🔥",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "English",
                      style: TextStyle(color: Colors.white),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize:
            const Size.fromHeight(100), // Height of the widget under AppBar
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text(
                  "Exclusive",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(width: 200),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Home",
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Contact",
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "About",
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                    child: const Text(
                      "About",
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 20),
                SearchBar(
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 10),
                  ),
                  constraints: const BoxConstraints(
                      minWidth: 200, maxWidth: 400, minHeight: 30),
                  onTap: () {},
                  hintText: "What are you looking for?",
                  trailing: const <Widget>[Icon(Icons.search)],
                ),
                const SizedBox(width: 20),

                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_sharp,
                      color: Colors.black87,
                    )),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_4_rounded,
                      color: Colors.black87,
                    ))
                // Add more widgets...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
