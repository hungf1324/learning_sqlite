import 'package:flutter/material.dart';
import 'package:learning_sqlite/widgets/custom_text.dart';

class StudentForm extends StatelessWidget {
  const StudentForm({
    super.key,
    required this.onPressed,
    required this.nameController,
    required this.addressController,
    required this.phoneController,
  });
  final VoidCallback onPressed;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildTextField(controller: nameController),
              _buildTextField(controller: addressController),
              _buildTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    onSurface: Colors.blue,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const CustomText(text: 'Lưu', size: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField({
    required TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
        ),
      ),
    );
  }
}
