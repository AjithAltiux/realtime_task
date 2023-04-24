import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovationstask/DB/DatabaseHelper.dart';
import 'package:realtime_innovationstask/Models/EmpModel.dart';
import 'package:realtime_innovationstask/Screens/EmplList.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmpModel> currentemplist = [];
  List<EmpModel> previousempList = [];
  String selectedDate1 = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  String selectedRole = '';
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      selectedDate1 = selectedDate.toString();
      notifyListeners();
    }
  }

  String selectNextMonday(DateTime selectedDate) {
    final today = selectedDate;
    int daysUntilNextMonday = DateTime.monday - today.weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    final nextMonday = today.add(Duration(days: daysUntilNextMonday));
    print(nextMonday.toString());
    selectedDate1 = nextMonday.toString();
    selectedDate = nextMonday;
    notifyListeners();
    return selectedDate1;
  }

  String selecttoday(DateTime selectDate)
  {
    final today= DateTime.now();
    selectedDate1=today.toString();
    return selectedDate1;
  }

  String selectToday(DateTime selectedDate) {
    final today = selectedDate;
    selectedDate1 = today.toString();
    notifyListeners();
    return selectedDate1;
  }

  String selectNextTuesday(DateTime selectedDate) {
    final today = selectedDate;
    int daysUntilNextTuesday = DateTime.tuesday - today.weekday;
    if (daysUntilNextTuesday <= 0) {
      daysUntilNextTuesday += 7;
    }
    final nextTuesday = today.add(Duration(days: daysUntilNextTuesday));
    selectedDate1 = nextTuesday.toString();
    selectedDate = nextTuesday;
    notifyListeners();
    return selectedDate1;
  }

  String selectAfterOneWeek(DateTime selectedDate) {
    final today = selectedDate;
    final afterOneWeek = today.add(const Duration(days: 7));

    selectedDate1 = afterOneWeek.toString();
    selectedDate = afterOneWeek;
    notifyListeners();
    return selectedDate1;
  }

  Widget getDateRangePicker(DateTime selectedDatee) {
    // selectedDate1=selectedDatee.toString();
    return SizedBox(
        height: 250,
        child: Card(
            child: SfDateRangePicker(
          // initialSelectedDate:DateTime.parse(selectedDate1),
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: selectionChanged,
        )));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDate1 = DateFormat('dd MMM yyyy').format(args.value);
    
    // SchedulerBinding.instance!.addPostFrameCallback((duration) {
    //   setState(() {});
    // });
  }

  void addUser(BuildContext context, EmpModel emp) async {
    //Insert the new user to the db
    final now = DateTime.now().millisecondsSinceEpoch;
    // Generate a random string of length 4
    final random = Random();
    final randString =
        String.fromCharCodes(List.generate(4, (_) => random.nextInt(26) + 65));
    final String userId = 'EMP$now$randString';
    final String id = userId;
    final employeeData = EmpModel(
        id: id,
        empName: emp.empName,
        empfromDate: emp.empfromDate,
        empEndDate: emp.empEndDate,
        empRole: emp.empRole,
        isDeleted: false);
    await DatabaseHelper.instance.insert(employeeData);
    // _authenticatedUser = user;
    nameController.text = "";
    roleController.text = "";

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Employee Sucessfull Registered "),
        backgroundColor: Colors.green,
      ),
    );
    notifyListeners();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const EmployeeListScreen()),
        (route) => false);
    notifyListeners();
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
