import 'package:escheduler/features/auth/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  bool isLoading = false;
  bool showErrors = false;
  String? emailError;

  Future<void> refreshPage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      emailController.clear();
      emailError = null;
      showErrors = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff5f7fa),
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

                    // Logo
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

                    // Title
                    const Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      "Enter your email address and we'll send you a verification code to reset your password",
                      textAlign: TextAlign.center,
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
                    TextField(
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

                    const SizedBox(height: 30),

                    // RESET BUTTON
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
                        onPressed: resetPassword,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    // After the Submit button
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remembered your password? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 25, 118, 210),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  void validateEmail() {
    final email = emailController.text.trim();
    const emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    setState(() {
      emailError = email.isEmpty
          ? "Please enter your Email Address"
          : !RegExp(emailPattern).hasMatch(email)
          ? "Invalid email format"
          : null;
    });
  }

  void resetPassword() async {
    FocusScope.of(context).unfocus();
    setState(() => showErrors = true);
    validateEmail();

    if (emailError != null) return;

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = false);

    // Show SnackBar instead of Flushbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Verification code sent successfully. Check your inbox.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
