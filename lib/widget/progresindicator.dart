import 'package:flutter/material.dart';

void showProgressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    // Disallow user from tapping outside to close the dialog
    builder: (context) {
      return Dialog(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          padding: const EdgeInsets.all(18.5),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 33,
                  width: 33,
                  child: CircularProgressIndicator(
                    color: Color(0xff0078aa),
                    strokeWidth: 3,
                    backgroundColor: Colors.black12,
                  )),
              SizedBox(height: 20.0),
              Text(
                "Loading...",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}
