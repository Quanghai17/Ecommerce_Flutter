import 'package:flutter/material.dart';

class Subtotal extends StatelessWidget {
  const Subtotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
      child: const Row(
        children: [
          Text(
            "Tổng tiền ",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "2.000.000 VNĐ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
