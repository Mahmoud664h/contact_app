import 'package:contact_app/ui/modal/contact_modal.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final double width;
  final double height;
  final ContactModal contact;
  final void Function() deleteContact;
  const ContactCard({
    super.key,
    required this.height,
    required this.width,
    required this.contact,
    required this.deleteContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.6,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Image.file(
                  contact.userImage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  left: width * 0.02,
                  bottom: height * 0.009,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: width * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryColor,
                    ),

                    child: Text(
                      contact.userName,
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.email, color: AppColors.backgroundColor),
                      SizedBox(width: width * 0.01),
                      Text(
                        contact.userEmail,
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, color: AppColors.backgroundColor),
                      SizedBox(width: width * 0.01),
                      Text(
                        contact.userPhone,
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: deleteContact,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        Text('Delete', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
