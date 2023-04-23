class EmpModel {
  String? id;
  String? empName;
  String? empRole;
  String? empfromDate;
  String? empEndDate;
  bool? isDeleted;
  EmpModel(
      {this.empName, this.empEndDate, this.empRole, this.empfromDate, this.id,this.isDeleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'empname': empName,
      'role': empRole,
      'fromDate': empfromDate,
      'toDate': empEndDate,
      'isDeleted': isDeleted
    };
  }

  factory EmpModel.fromMap(Map<String, dynamic> map) {
    return EmpModel(
      isDeleted: map['isDeleted'],
      id: map['id'],
      empName: map['empname'],
      empRole: map['role'],
      empfromDate: map['fromDate'],
      empEndDate: map['toDate']
    );
  }
}
