import 'package:firebase_authentication_app/firebase_options.dart';
import 'package:firebase_authentication_app/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInit();

  runApp(const MyApp());
}

void firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.getDeviceToken();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController emailController, passwordController;

  final _formKey = GlobalKey<FormState>();
  bool isValid = false;
  bool isObscure = true;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),

              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Validate and refresh state
                  setState(() {
                    isValid = _formKey.currentState?.validate() ?? false;
                  });
                },
                decoration: InputDecoration(
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 200,
                    minWidth: 60,
                  ),

                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  suffixIcon: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: isValid
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            key: ValueKey('valid'),
                          )
                        : SizedBox(
                            key: ValueKey('invalid'),
                            width: 0,
                            height: 0,
                          ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),

                  errorStyle: TextStyle(
                    color: Colors.red,

                    fontWeight: FontWeight.w400,
                  ),
                  // Reserve space for error
                  helperText: ' ',
                  helperStyle: TextStyle(height: 1.5),

                  focusedErrorBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),

                  hintText: "abc@gmail.com",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 letters';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    isValid = _formKey.currentState?.validate() ?? false;
                  });
                },
                obscureText: isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),

                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  hintText: "Enter password",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.normal,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
