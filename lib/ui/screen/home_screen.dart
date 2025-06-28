import 'dart:io';

import 'package:contact_app/ui/modal/contact_modal.dart';
import 'package:contact_app/ui/widget/contact_card.dart';
import 'package:contact_app/ui/widget/contact_data_widget.dart';
import 'package:contact_app/ui/widget/custom_text_field.dart';
import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreen = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String userEmail = '';
  String userPhone = '';
  ImagePicker picker = ImagePicker();
  File? contactImage;
  List<ContactModal> contactList = [];

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final userEmailController = TextEditingController();
    final userPhoneController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset('assets/images/route_icon.png'),
      ),
      body: contactList.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                  repeat: true,
                ),
                Text(
                  'There is No Contacts Added Here',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.04,
                mainAxisSpacing: height * 0.02,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ContactCard(
                  height: height,
                  width: width,
                  contact: contactList[index],
                  deleteContact: () {
                    setState(() {
                      contactList.removeLast();
                    });
                  },
                );
              },
              itemCount: contactList.length,
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: contactList.isNotEmpty,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  contactList.removeLast();
                });
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          SizedBox(height: height * 0.01),
          Visibility(
            visible: contactList.length < 6,
            child: FloatingActionButton(
              onPressed: () {
                modalSheet(
                  context,
                  height,
                  width,
                  userNameController,
                  userEmailController,
                  userPhoneController,
                );
              },
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.add, color: AppColors.backgroundColor),
            ),
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  Future<dynamic> modalSheet(
    BuildContext context,
    double height,
    double width,
    TextEditingController userNameController,
    TextEditingController userEmailController,
    TextEditingController userPhoneController,
  ) {
    return showModalBottomSheet(
      backgroundColor: AppColors.backgroundColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.02,
                ),
                width: width,
                height: height * 0.56,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ContactDataWidget(
                      width: width,
                      height: height,
                      contactImage: contactImage,
                      userName: userName,
                      userEmail: userEmail,
                      userPhone: userPhone,
                      setModalState: setModalState,
                      pickImage: (setModalState) async {
                        await pickImage(setModalState);
                      },
                    ),
                    CustomTextField(
                      textHint: 'user Name',
                      inputText: userNameController,
                      text: (textFieldVal) => updateText(
                        textFieldVal,
                        (text) => userName = text,
                        setModalState,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      textHint: 'example@email.com',
                      inputText: userEmailController,
                      text: (textFieldVal) => updateText(
                        textFieldVal,
                        (text) => userEmail = text,
                        setModalState,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      textHint: '+200000000000',
                      inputText: userPhoneController,
                      text: (textFieldVal) => updateText(
                        textFieldVal,
                        (text) => userPhone = text,
                        setModalState,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        addContact(
                          userName: userNameController.text,
                          userEmail: userEmailController.text,
                          userPhone: userPhoneController.text,
                          userImage: contactImage!,
                        );
                        setState(() {});

                        Navigator.pop(context);
                        userNameController.clear();
                        userEmailController.clear();
                        userEmailController.clear();
                        userName = '';
                        userEmail = '';
                        userPhone = '';
                        contactImage = null;
                      },
                      child: const Text('Enter user'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void updateText(
    String textFieldVal,
    void Function(String text) updateCallback,
    StateSetter setModalState,
  ) {
    setModalState(() {
      updateCallback(textFieldVal);
    });
  }

  Future<void> pickImage(setModalState) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setModalState(() {
        contactImage = File(pickedFile.path);
      });
    }
  }

  void addContact({
    required String userName,
    required String userEmail,
    required String userPhone,
    required File userImage,
  }) {
    contactList.add(
      ContactModal(
        userName: userName,
        userEmail: userEmail,
        userPhone: userPhone,
        userImage: userImage,
      ),
    );
  }
}
