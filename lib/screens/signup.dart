import 'package:flutter/material.dart';
import 'otp.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override State<SignUpScreen> createState()=> _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('رقم الهاتف', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextField(
              controller: _phone, keyboardType: TextInputType.phone,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '+02 01xxxxxxxxx'),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> OTPScreen(phone: _phone.text)));
            },
            child: const Text('إرسال الكود'),
          )
        ]),
      ),
    );
  }
}
