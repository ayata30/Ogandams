
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => RequestScreenState();
}

class RequestScreenState extends State<RequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedCategory = 'Groceries';

  final List<String> _categories = [
    'Groceries',
    'School Supplies',
    'Transportation',
    'Pet Supplies',
    'Housing',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // For now, this only confirms the form was completed.
    // Later, we'll save the request to Firestore.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Request form completed!'),
      ),
    );

    _formKey.currentState!.reset();

    _titleController.clear();
    _descriptionController.clear();
    _amountController.clear();

    setState(() {
      _selectedCategory = 'Groceries';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Support'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'What do you need help with?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tell us a little about what you need. '
                    'We are here to help connect you with support.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              // Request title
              const Text(
                'Request Title',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Example: Need groceries this week',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a request title';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Category
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              // Description
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Explain what you need and how it would help...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe your request';
                  }
                  if (value.trim().length < 10) {
                    return 'Please provide a little more detail';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Optional amount
              const Text(
                'Estimated Amount (Optional)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Example: 25.00',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }

                  final amount = double.tryParse(value.trim());

                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF245C45),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
