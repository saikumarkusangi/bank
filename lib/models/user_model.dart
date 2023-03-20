

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.id,
        required this.nickName,
        required this.fullName,
        required this.userName,
        required this.pinNumber,
        required this.mobNumber,
        required this.upiId,
    });

    String id;
    String nickName;
    String fullName;
    String userName;
    String pinNumber;
    String mobNumber;
    String upiId;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        nickName: json["nick_name"],
        fullName: json["full_name"],
        userName: json["user_name"],
        pinNumber: json["pin_number"],
        mobNumber: json["mob_number"],
        upiId: json["upi_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nick_name": nickName,
        "full_name": fullName,
        "user_name": userName,
        "pin_number": pinNumber,
        "mob_number": mobNumber,
        "upi_id": upiId,
    };
}
