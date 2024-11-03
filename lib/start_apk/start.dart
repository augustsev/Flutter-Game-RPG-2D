import 'package:flutter/material.dart';
import 'package:gamerpg/login/login_page.dart';
import 'dart:async'; // Import Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _progressValue = 0.0; // Variabel untuk nilai progress

  @override
  void initState() {
    super.initState();

    // Inisialisasi Animation Controller dengan durasi yang lebih pendek
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Ubah durasi menjadi 1 detik
      vsync: this,
    );

    // Membuat Animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Memulai animasi dan progress bar
    _controller.forward();

    // Timer untuk memperbarui nilai progress setiap detik
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progressValue >= 1.0) {
        timer.cancel();
        // Navigasi setelah delay
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman tujuan Anda
        );
      } else {
        setState(() {
          _progressValue += 0.020; // Mengatur kecepatan progres
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with fade animation
          FadeTransition(
            opacity: _animation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/loading_screen.jpg'), // Ganti dengan path gambar Anda
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Progress indicator at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Bisa diubah sesuai kebutuhan
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Sesuaikan lebar sesuai keinginan
                child: LinearProgressIndicator(
                  value: _progressValue, // Menggunakan nilai progress yang diperbarui
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                  color: const Color.fromARGB(255, 255, 163, 43),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
