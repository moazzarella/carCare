import 'package:car_care/cubit/app_state.dart';
import 'package:car_care/cubit/cubit.dart';
import 'package:car_care/screens/worker/worker_login_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/default_button.dart';
import '../../shared/components/form_field.dart';
import '../main_screens/home_screen.dart';
import '../sing_up/sing_up._screen.dart';

class WorkerRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var idNumberController = TextEditingController();
  bool isHide = true;
  bool isHideConfirm = true;

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {
        if (state is WorkerRegisterSuccessState) {
          if (state.workerRegisterModel.status == 'success') {
            print(state.workerRegisterModel.name);
            Fluttertoast.showToast(
                msg: 'welcome you in our application',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            navigateAndFinish(context, HomeScreen());
          } else {
            print('${state.workerRegisterModel.message}');
            Fluttertoast.showToast(
                msg: state.workerRegisterModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
        builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Stack(
              children: [
                backGround(),
                if (isKeyboard) backGroundu(),
                SizedBox(height: 320),
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 280 + MediaQuery.of(context).padding.top),
                          Text('Email',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: emailController,
                              typeOfInput: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct email';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Name',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: nameController,
                              typeOfInput: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct name';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Phone Number',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: phoneController,
                              typeOfInput: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct phone number';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Location',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: locationController,
                              typeOfInput: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct Location';
                                }
                                return null;
                              }),
                          Text('Id Number',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: idNumberController,
                              typeOfInput: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct id';
                                }
                                return null;
                              }),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        label: Text('password'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(16),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                        label: Text('confirm password'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(16),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // Spacer(),
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! WorkerRegisterLoadingState,
                              builder: (context) => defaultButton(
                                  width: 150,
                                  color: Colors.black,
                                  colorText: Colors.white,
                                  text: 'Register',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      AppCubit.get(context).workerRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword: confirmPasswordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        idNumber: idNumberController.text,
                                        location: locationController.text,
                                      );
                                    } //navigateTo(context, HomeScreen());
                                  }),
                              fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red)),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    'or',
                                    style: TextStyle(fontSize: 20),
                                  )),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account ?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 70,
                                height: 30,
                                child: TextButton(
                                    onPressed: () {
                                      navigateTo(context, WorkerLoginScreen());
                                    },
                                    child: Text(
                                      'LOG IN',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
        },
    );
  }
}









Widget backGround() => Container(
    width: double.infinity,
    height: double.infinity,
    child: Image(
      image: AssetImage('assets/images/3.png'),
      fit: BoxFit.cover,
    ));

Widget defaultText({required String text}) => Text(text,
    style: TextStyle(
      color: Colors.grey[500],
      fontSize: 16,
    ));
Widget buildLogo({final urlLogo = 'assets/images/logo.png'}) => Container(
  width: double.infinity,
  height: 150,
  child: Image(
    image: AssetImage(urlLogo),
    fit: BoxFit.cover,
  ),
);