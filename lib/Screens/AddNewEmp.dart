import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovationstask/Constants/image-constants.dart';
import 'package:realtime_innovationstask/Provider/EmpProvider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(builder: (context, object, child) {
      return Scaffold(
        backgroundColor: const Color(0XFFF2F2F2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Add Employee Details",
            style: TextStyle(
                fontFamily: "Open Sans",
                fontStyle: FontStyle.normal,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            TextField(
              controller: object.nameController,
              decoration: InputDecoration(
                labelText: 'Employee Name',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    person,
                    fit: BoxFit.fill,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: object.roleController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(work),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(dropdown),
                ),
                labelText: 'Select Role',
                border: const OutlineInputBorder(),
              ),
              onTap: () async {
                setState(() {
                  FocusScope.of(context).unfocus();
                });
                final selectedRole = await showModalBottomSheet<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.builder(
                        itemCount: object.roles.length,
                        itemBuilder: (BuildContext context, int index) {
                          final role = object.roles[index];
                          return ListTile(
                            title: Text(role),
                            onTap: () {
                              setState(() {
                                FocusScope.of(context).unfocus();
                              });
                              Navigator.pop(context, role);
                            },
                          );
                        },
                      ),
                    );
                  },
                );
                if (selectedRole != null) {
                  setState(() {
                    FocusScope.of(context).unfocus();
                  });
                  object.selectedRole = selectedRole;
                  object.roleController.text = object.selectedRole;
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showDateDialog(context, object.startDate!);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(calendar),
                          ),
                          Text(DateFormat('dd MMM yyyy')
                              .format(object.startDate!)
                              .toString())
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  arrowright,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showDateDialog(context, object.endDate!);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(calendar),
                          ),
                          Text(DateFormat('dd MMM yyyy')
                              .format(object.endDate!)
                              .toString())
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  showDateDialog(BuildContext context, DateTime selectedDate) {
    int selectedIndex = 0;

    List<MenuItem> selectmenudayList = [
      MenuItem(name: "Today", isSelected: false),
      MenuItem(name: "Next Monday", isSelected: false),
      MenuItem(name: "Next Tuesday", isSelected: false),
      MenuItem(name: "After 1 week", isSelected: false)
    ];
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<EmployeeProvider>(builder: (context, object, child) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.0,
                        ),
                        itemCount: selectmenudayList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                if (index == 0) {
                                  object.selectedDate1 =
                                      object.selectToday(selectedDate);
                                } else if (index == 1) {
                                  object.selectedDate1 =
                                      object.selectNextMonday(selectedDate);
                                } else if (index == 2) {
                                  object.selectedDate1 =
                                      object.selectNextTuesday(selectedDate);
                                } else {
                                  object.selectedDate1 =
                                      object.selectAfterOneWeek(selectedDate);
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: selectedIndex == index
                                    ? Colors.blue
                                    : const Color(0XFFEDF8FF),
                              ),
                              child: Center(
                                child: Text(
                                  '${selectmenudayList[index].name}',
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    object.getDateRangePicker(selectedDate)
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    SvgPicture.asset(calendar),
                    const SizedBox(
                      width: 05,
                    ),
                    Text(object.selectedDate1 == ""
                        ? ""
                        : DateFormat('dd MMM yyyy')
                            .format(DateTime.parse(object.selectedDate1))
                            .toString()),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }
}

class MenuItem {
  String? name;
  bool? isSelected;
  MenuItem({this.isSelected, this.name});
}
