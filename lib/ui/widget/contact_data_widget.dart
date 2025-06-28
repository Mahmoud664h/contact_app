import 'dart:io';

import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContactDataWidget extends StatelessWidget {
  const ContactDataWidget({
    super.key,
    required this.width,
    required this.height,
    required this.contactImage,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.setModalState,
    required this.pickImage,
  });

  final double width;
  final double height;
  final File? contactImage;
  final String userName;
  final String userEmail;
  final String userPhone;
  final void Function(void Function()) setModalState;
  final Future<void> Function(void Function(void Function()) setModalState)
  pickImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              await pickImage(setModalState);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: width * 0.3,
              height: height * 0.17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
              ),
              child: contactImage == null
                  ? Icon(Icons.image)
                  : Image.file(
                      contactImage!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.01, bottom: height * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isEmpty ? 'user Name' : userName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.018),
                  width: width * 0.6,
                  height: 1,
                  color: AppColors.primaryColor,
                ),
                Text(
                  userEmail.isEmpty ? 'example@email.com' : userEmail,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.018),
                  width: width * 0.6,
                  height: 1,
                  color: AppColors.primaryColor,
                ),
                Text(
                  userPhone.isEmpty ? '+200000000000' : userPhone,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
