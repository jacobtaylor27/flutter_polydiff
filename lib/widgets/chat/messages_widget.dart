import 'package:flutter/material.dart';
import 'package:flutter_polydiff/interfaces/message.dart';
import 'package:flutter_polydiff/utils/datetime_utils.dart';

class OwnMessageWidget extends StatelessWidget {
  final Message message;
  const OwnMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 450),
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                    Text(
                      "${message.sender}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color.fromARGB(255, 143, 143, 143),
                      ),
                    ),
                ),
                Card(
                  color: const Color.fromARGB(255, 63, 42, 252),
                  child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          ),
                        ],
                    ),
                )
              ),
          ],)
        ),
      ),
    );
  }
}

class OtherMessageWidget extends StatelessWidget {
  final Message message;
  const OtherMessageWidget({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 450),
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
              Text(
                    "${message.sender} ${DateTimeUtils().getFormattedDate(message.time!)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color.fromARGB(255, 143, 143, 143),
                    ),
                    ),),
              Card(
                color: const Color.fromARGB(255, 240, 238, 232),
                child: 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        ),
                      ],
                  ),
                )
              ),
          ],)
        ),
      ),
    );
  }
}