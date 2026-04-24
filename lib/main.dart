import 'package:flutter/material.dart';

void main() => runApp(const LuxuryApp());

class LuxuryApp extends StatelessWidget {
  const LuxuryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxury Login',
      home: const WelcomePage(),
    );
  }
}

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Colors.black;
const Color fieldBg = Color(0xFF1A1A1A);

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 100, color: goldColor),
            const SizedBox(height: 30),
            const Text(
              "WELCOME",
              style: TextStyle(
                color: goldColor,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 10),
            const Text("مرحباً بك في عالم الفخامة",
                style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("ابدأ الآن",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  bool _isObscured = true;

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        backgroundColor: goldColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: goldColor)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _loginKey,
          child: Column(
            children: [
              const Icon(Icons.lock_person_outlined,
                  size: 80, color: goldColor),
              const SizedBox(height: 20),
              const Text("تسجيل الدخول",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration:
                    _buildInput("البريد الإلكتروني", Icons.alternate_email),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'يرجى إدخال البريد الإلكتروني';
                  if (!value.contains('@')) return 'صيغة البريد غير صحيحة';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _isObscured,
                style: const TextStyle(color: Colors.white),
                decoration:
                    _buildInput("كلمة المرور", Icons.lock_outline).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: goldColor),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'يرجى إدخال كلمة المرور';
                  if (value.length < 6) return 'يجب أن تكون 6 خانات على الأقل';
                  return null;
                },
              ),
              const SizedBox(height: 50),
              _buildButton("دخول", () {
                if (_loginKey.currentState!.validate()) {
                  _showSuccessMessage('جاري التحقق.. تم تسجيل الدخول بنجاح');
                }
              }),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage())),
                child: const Text("ليس لديك حساب؟ سجل الآن",
                    style: TextStyle(color: goldColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: goldColor)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _signUpKey,
          child: Column(
            children: [
              const Text("إنشاء حساب جديد",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _buildInput("الاسم الكامل", Icons.person_outline),
                validator: (v) => v!.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration:
                    _buildInput("البريد الإلكتروني", Icons.email_outlined),
                validator: (v) =>
                    v!.contains('@') ? null : 'يرجى إدخال بريد صحيح',
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInput("كلمة المرور", Icons.lock_outline),
                validator: (v) =>
                    v!.length < 6 ? 'كلمة المرور قصيرة جداً' : null,
              ),
              const SizedBox(height: 50),
              _buildButton("تأكيد التسجيل", () {
                if (_signUpKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم إنشاء الحساب بنجاح! مرحباً بك',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      backgroundColor: goldColor,
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _buildInput(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey),
    prefixIcon: Icon(icon, color: goldColor),
    filled: true,
    fillColor: fieldBg,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white10)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: goldColor, width: 2)),
    errorStyle: const TextStyle(color: goldColor, fontWeight: FontWeight.bold),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: goldColor)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: goldColor, width: 2)),
  );
}

Widget _buildButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: goldColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(text,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
    ),
  );
}
