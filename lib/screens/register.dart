import 'package:flutter/material.dart';
import 'package:mid_term/database/authentication.dart'; // Assuming this contains Firebase logic

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Đăng ký"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/jack.jpg',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Trở thành đom đóm ngay",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Đăng ký tài khoản để trở thành fan của J97",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                  Icons.person, "Tên của bạn", false, _nameController),
              const SizedBox(height: 20),
              _buildTextField(Icons.email, "Email", false, _emailController),
              const SizedBox(height: 20),
              _buildTextField(
                  Icons.lock, "Password", true, _passwordController),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  ValidateEmailAndPassword validate = ValidateEmailAndPassword(
                    emailController: _emailController.text,
                    passwordController: _passwordController.text,
                    context: context,
                    key: _formKey,
                    state: false,
                  );
                  await validate.userSignInAndSighnUp();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "wow bạn thật tuyệt khi là fan của J97",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hintText, bool isPassword,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (isPassword) {
          return validatePassword(value);
        } else if (hintText == "Email") {
          return validateEmail(value);
        }
        return null;
      },
    );
  }
}
