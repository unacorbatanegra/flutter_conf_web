import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  final String? errorMessage;

  const ErrorState({
    super.key,
    required this.onRetry,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1d3a),
              Color(0xFF0B1929),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flutter Logo with error indication
                Opacity(
                  opacity: 0.6,
                  child: Assets.images.fullLogo.svg(
                    height: 100,
                  ),
                ),
                const SizedBox(height: 40),

                // Error Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 30),

                // Error Title
                Text(
                  'Oops! Something went wrong',
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Error Message
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Text(
                    errorMessage ??
                        'We couldn\'t load the conference data. Please check your connection and try again.',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Retry Button
                ElevatedButton.icon(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5983F8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.refresh, size: 20),
                  label: Text(
                    'Try Again',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Contact Information
                Text(
                  'If the problem persists, please contact us',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
