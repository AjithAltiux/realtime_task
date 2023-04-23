import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovationstask/Constants/image-constants.dart';
import 'package:realtime_innovationstask/Provider/EmpProvider.dart';
import 'package:realtime_innovationstask/Screens/AddNewEmp.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key, }) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<EmployeeProvider>(builder: (context, object, child) {
      return Scaffold(
        backgroundColor: const Color(0XFFF2F2F2),
        appBar: AppBar(
          title: const Text(
            "Employee List",
            style: TextStyle(
                fontFamily: "Open Sans",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewEmployee()));
          },
          shape: const RoundedRectangleBorder(),
          child: const Icon(Icons.add),
        ),
        body: object.currentemplist.isEmpty || object.previousempList.isEmpty
            ? Center(
                child: SvgPicture.asset(noempimg),
              )
            : ListView(
                children: [
                  headingtab("Current employees"),
                  SizedBox(
                    height: size.height / 3.5,
                    child: ListView.builder(
                        itemCount: object.currentemplist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red[700],
                              alignment: AlignmentDirectional.centerEnd,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {});
                            },
                            child: listtabs(
                                object.currentemplist[index].empName!,
                                object.currentemplist[index].empRole!,
                                "From ${object.currentemplist[index].empfromDate!}"),
                          );
                        }),
                  ),
                  headingtab("Previous employees"),
                  SizedBox(
                    height: size.height / 3.5,
                    child: ListView.builder(
                        itemCount: object.previousempList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red[700],
                              alignment: AlignmentDirectional.centerEnd,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {});
                            },
                            child: listtabs(
                                object.previousempList[index].empName!,
                                object.previousempList[index].empRole!,
                                "From ${object.previousempList[index].empfromDate!}"),
                          );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Swipe left to delete",
                      style: TextStyle(
                          color: Color(0XFF949C9E),
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
      );
    });
  }

  Widget listtabs(String name, String role, String date) {
    return ListTile(
      tileColor: const Color(0XFFFFFFFF),
      contentPadding: const EdgeInsets.only(top: 4, left: 16, bottom: 4),
      title: Text(
        name,
        style: const TextStyle(
            fontFamily: "Open Sans",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 2),
            child: Text(role),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2),
            child: Text(date),
          ),
        ],
      ),
    );
  }

  Widget headingtab(String headingText) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16),
      child: Text(
        headingText,
        style: const TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
