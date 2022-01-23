import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;

  const CustomCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Card(
        color: const Color(0xff60eae7).withOpacity(0.8),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              width: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xff1e027a),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              width: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xff1e027a),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
