import 'package:flutter/material.dart';
import 'package:realtime_innovationstask/Models/EmpModel.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmpModel> currentemplist = [];
  List<EmpModel> previousempList = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  String selectedRole = '';
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      if (isStartDate) {
        startDate = selectedDate;
      } else {
        endDate = selectedDate;
      }
    }
  }

  final List<String> roles = [
    'Manager',
    'Software Engineer',
    'Product Manager',
    'Designer',
    'Sales Representative',
    'Marketing Manager',
    'Customer Service Representative',
  ];
}
