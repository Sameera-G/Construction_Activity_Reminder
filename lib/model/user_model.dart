class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? homeAddress;
  String? mobileNumber;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.homeAddress,
    this.mobileNumber,
  });

//taking data from firebase
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      homeAddress: map['homeAddress'],
      mobileNumber: map['mobileNumber'],
    );
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'homeAddress': homeAddress,
      'mobileNumber': mobileNumber,
    };
  }
}
