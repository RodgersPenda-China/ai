import 'package:chatgpt/network/api_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'home_page.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String  email = '';
  String password = '';
  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Colors.red.withOpacity(0.1),
            image: DecorationImage(
                image: NetworkImage( 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    // 'https://assets6.lottiefiles.com/private_files/lf30_ulp9xiqw.json', //shakeing lock
                      'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                      animate: true,
                      height: 120,
                      width: 600),
                  // logo here
                  // Image.asset(
                  //   'assets/images/logo_new.png',
                  //   height: 120,
                  //   width: 120,
                  // ),
                  Text(
                    'Log In/Register Now',
                  ),
                  Text(
                    'Please login/Register to continue using our app',
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: isEmailCorrect! ? 280 : 200,
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            controller: _textEditingController,
                            onChanged: (val) {
                              setState(() {
                                isEmailCorrect = isEmail(val);
                                email = val;
                              });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              hintText: 'your-email@domain.com',
                              labelStyle: TextStyle(color: Colors.purple),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.close,
                              //         color: Colors.purple))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Password",
                                hintText: '*********',
                                labelStyle: TextStyle(color: Colors.purple),
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value!.length < 5) {
                                  return 'Enter a valid password';
                                  {
                                    return null;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isEmailCorrect
                            ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: isEmailCorrect == false
                                    ? Colors.red
                                    : Colors.purple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 131, vertical: 20)
                              // padding: EdgeInsets.only(
                              //     left: 120, right: 120, top: 20, bottom: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                await submitLoginForm(
                                    email: email,
                                    password: password,
                                );
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString('login', 'yes');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  HomePage(),
                                  ),
                                );


                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => loginScreen()));
                            },
                            child: Text(
                              'Log In/Register',
                              style: TextStyle(fontSize: 17),
                            ))
                            : Container(),
                      ],
                    ),
                  ),

                  //this is button
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0)),
                  //         backgroundColor: Colors.purple,
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: MediaQuery.of(context).size.width / 3.3,
                  //             vertical: 20)
                  //         // padding: EdgeInsets.only(
                  //         //     left: 120, right: 120, top: 20, bottom: 20),
                  //         ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => loginScreen()));
                  //     },
                  //     child: Text(
                  //       'Sounds Good!',
                  //       style: TextStyle(fontSize: 17),
                  //     )), //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By Registering Or loggin, You Agree to our',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
