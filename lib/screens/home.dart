import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'booking.dart';
import 'my_appointments.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final maroon  = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text('Dr Mohamed Esmail Clinic',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
              const SizedBox(height: 48),
              _btn(context, 'دخول', primary, (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const LoginScreen()));
              }),
              const SizedBox(height: 16),
              _btn(context, 'تسجيل جديد', maroon, (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const SignUpScreen()));
              }),
              const SizedBox(height: 32),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const BookingScreen())),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('حجز موعد'),
                  ),
                  OutlinedButton.icon(
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const MyAppointmentsScreen())),
                    icon: const Icon(Icons.event_available),
                    label: const Text('حجوزاتي'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(BuildContext c, String txt, Color color, VoidCallback onTap){
    return SizedBox(
      width: double.infinity, height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: onTap,
        child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
