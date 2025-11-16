import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_app/features/product/data/services/api_service.dart';
import 'package:ecommerce_flutter_app/features/product/data/datasources/category_remote_data_source.dart';

class SearchBarWithAutocomplete extends StatefulWidget {
  const SearchBarWithAutocomplete({Key? key}) : super(key: key);

  @override
  _SearchBarWithAutocompleteState createState() =>
      _SearchBarWithAutocompleteState();
}

class _SearchBarWithAutocompleteState extends State<SearchBarWithAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final CategoryRemoteDataSource remoteDataSource =
      CategoryRemoteDataSource(Dio(), apiService: ApiService());
  Timer? _debounce;
  List<dynamic> _suggestions = [];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() => _suggestions = []);
        return;
      }
      try {
        final response = await remoteDataSource.searchProducts(query);
        setState(() {
          _suggestions = response.data;
        });
      } catch (e) {
        print('Search failed: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        if (_suggestions.isNotEmpty)
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final product = _suggestions[index];
                return ListTile(
                  title: Text(product['product_name'] ?? ''),
                  subtitle: Text(product['category'] ?? ''),
                  onTap: () {
                    // Option 1: Go to product details
                    // Option 2: Navigate to category or show results
                    print('Selected: ${product['product_name']}');
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
