import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isAttendingEvent;


  const CustomCard({
    super.key,
    required this.title,
    this.description = "",
    this.image = "",
    required this.isAttendingEvent
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => context.go(),
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          margin: const EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              children: <Widget>[
                image != "" ? Image.asset(image) : const SizedBox(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      isAttendingEvent ? _DecitionAttendingButton() : const SizedBox(height: 5)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}


class _DecitionAttendingButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
          onPressed: (){}, 
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          child: const Text('Asisto'),
        )
      ],
    );
  }
}
