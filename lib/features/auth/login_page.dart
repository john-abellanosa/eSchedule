import 'package:escheduler/Features/crew/dashboard/crew_dashboard.dart';
import 'package:escheduler/features/auth/forgot_password.dart';
import 'package:escheduler/Features/manager/manager_dashboard.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  bool showErrors = false;
  String? emailError;
  String? passwordError;

  Future<void> refreshPage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      emailController.clear();
      passwordController.clear();
      emailError = null;
      passwordError = null;
      showErrors = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff5f7fa),

        // Pull to refresh
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Professional Logo Display
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.shade200,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/img/eScheduler_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Let’s get started!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Login to continue to your account",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // EMAIL LABEL
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // EMAIL INPUT
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "name@example.com",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: showErrors ? emailError : null,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.blue.shade600,
                            width: 1.8,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.4,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade700,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // PASSWORD LABEL
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // PASSWORD INPUT
                    TextField(
                      controller: passwordController,
                      style: TextStyle(fontSize: 14),
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: showErrors ? passwordError : null,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.blue.shade600,
                            width: 1.8,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.4,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey.shade700,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade700,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 25, 118, 210),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        onPressed: login,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Validation only when pressing login
  void validateAll() {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();

    const emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    setState(() {
      emailError = email.isEmpty
          ? "Please enter your Email Address"
          : !RegExp(emailPattern).hasMatch(email)
          ? "Invalid email format"
          : null;

      passwordError = pass.isEmpty
          ? "Please enter your Password"
          : pass.length < 8
          ? "Password must be at least 8 characters"
          : !RegExp(r"[A-Z]").hasMatch(pass)
          ? "Must contain at least 1 uppercase letter"
          : !RegExp(r"[0-9]").hasMatch(pass)
          ? "Must contain at least 1 number"
          : !RegExp(r"[!@#\$%^&*]").hasMatch(pass)
          ? "Must contain at least 1 special character"
          : null;
    });
  }

  void login() {
    FocusScope.of(context).unfocus();

    setState(() => showErrors = true);
    validateAll();

    if (emailError != null || passwordError != null) return;

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);

      final email = emailController.text.trim().toLowerCase();

      // STATIC LOGIN CREDENTIALS
      if (email == "manager@gmail.com") {
        // Redirect to MANAGER dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ManagerDashboard()),
        );
      } else {
        // Redirect to CREW dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CrewDashboard()),
        );
      }
    });
  }
}
