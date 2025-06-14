import 'package:image_picker/image_picker.dart';

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String sex;
  final String idNumber;
  final String governorate;
  final String city;
  final XFile? avatar;
  final XFile? frontId;
  final XFile? backId;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.sex,
    required this.idNumber,
    required this.governorate,
    required this.city,
    this.avatar,
    this.frontId,
    this.backId,
  });
}
