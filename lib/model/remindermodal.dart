class ReminderModel {
  String? reminderName;
  String? reminderType;
  String? TechnicanN;
  String? TestIdentification;
  String? Location;
  String? DateofTest;
  String? TimeofTest;

  ReminderModel({
    this.reminderName,
    this.reminderType,
    this.TechnicanN,
    this.TestIdentification,
    this.Location,
    this.DateofTest,
    this.TimeofTest,
  });

//taking data from firebase
  factory ReminderModel.fromMap(map) {
    return ReminderModel(
      reminderName: map['reminderName'],
      reminderType: map['reminderType'],
      TechnicanN: map['TechnicanN'],
      TestIdentification: map['TestIdentification'],
      Location: map['Location'],
      DateofTest: map['DateofTest'],
      TimeofTest: map['TimeofTest'],
    );
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'reminderName': reminderName,
      'reminderType': reminderType,
      'TechnicanN': TechnicanN,
      'TestIdentification': TestIdentification,
      'Location': Location,
      'DateofTest': DateofTest,
      'TimeofTest': TimeofTest,
    };
  }
}
