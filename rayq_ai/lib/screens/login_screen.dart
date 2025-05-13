import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const LoginScreen({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2)); // Simulate login
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final backgroundColor = color.surface;
    final foregroundColor = color.onSurface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Welcome to rayQ.ai',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: foregroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: backgroundColor,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        validator: (value) => value != null && value.length >= 6 ? null : 'Minimum 6 characters',
                      ),
                      const SizedBox(height: 24),
                      _buildButton(
                        label: 'Login',
                        onPressed: _isLoading ? null : _login,
                        loading: _isLoading,
                        backgroundColor: color.primary,
                        foregroundColor: foregroundColor,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: foregroundColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignupScreen(isDarkMode: widget.isDarkMode, toggleTheme: widget.toggleTheme),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: foregroundColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value == null || !emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: color.onSurface),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color.onSurface),
          filled: true,
          fillColor: color.surfaceContainerHighest,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {

    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
