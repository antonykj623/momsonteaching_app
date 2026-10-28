import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/registration.dart';
import 'package:momsonteaching_app/views/teacher/teacher_dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController =
  TextEditingController();

  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  String? selectedUserType;

  final List<String> userTypes = [
    'Super Admin',
    'Admin',
    'Teacher',
    'Parents',
  ];

  void submitLogin() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String userType = selectedUserType!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email: $email\nUser Type: $userType',
          ),
        ),
      );

      if(userType=='Teacher'){

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  TeacherDashboard(),
          ),
        );

      }

      // Add your login API call here.
    }
  }

  void openCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAccount(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/logo.png",width: 301,height: 264,fit: BoxFit.fill,),

                const SizedBox(height: 8),

                const Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Email field
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // User type dropdown
                DropdownButtonFormField<String>(
                  value: selectedUserType,
                  decoration: InputDecoration(
                    labelText: 'User Type',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  hint: const Text('Select user type'),
                  items: userTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUserType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a user type';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: submitLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Create account section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: openCreateAccount,
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Create Account page
