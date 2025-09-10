import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr/constant/app_color.dart';
import 'package:hr/views/screens/page_switcher.dart';

import '../widgets/custom_logo_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            // Section 1 - Header
            SizedBox(height: 50),
            const CustomLogoAuth(),
            SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 12),
              child: Text(
                'تسجيل الدخول',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),

            // Section 2 - Form Fields
            // Username
            SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 12),
              child: Text(
                'اسم المستخدم',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            TextFormField(
              controller: _usernameController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسم المستخدم ',
                suffixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.email, color: AppColor.background),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.border, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),

              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال اسم المستخدم';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 12),
              child: Text(
'كلمة المرور',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            // Password
            TextFormField(
              controller: _passwordController,
              obscureText: obscureText,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'كلمة المرور',
                suffixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.lock, color: AppColor.background),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.background,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.border, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),

              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                } else if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),

            // Forgot Password
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 16),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '  نسيت كلمة المرور ؟',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.primary,
                ),
              ),
            ),

            // Sign In Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Submit form
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageSwitcher()),
                  );
                  print("Username: ${_usernameController.text}");
                  print("Password: ${_passwordController.text}");
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'تسجيل الدخول',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
