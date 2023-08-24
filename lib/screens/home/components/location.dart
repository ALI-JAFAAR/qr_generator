import '/constants.dart';
import 'package:flutter/material.dart';


class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 246, 246),
          border: Border.all(
            color: Colors.black.withOpacity(0.05),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amberAccent,
                  ),
                  child: const Padding(
                    padding:  EdgeInsets.all(2),
                    child: Icon(
                      Icons.location_pin,
                      size: 35,
                      color: kPrimarycolor,
                    ),
                  ),
                ),
              ),
              const Column(
                children: [
                  Text(
                    "Deliver to",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "سبع البور ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.delivery_dining_outlined,
                size: 40,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
