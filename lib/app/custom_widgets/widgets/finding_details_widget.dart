import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';

class FindingDetailsWidget extends StatelessWidget {
  const FindingDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600',
                    fit: BoxFit.cover,
                  )),
              Spacing.hStandard,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Area',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                '31/6/23',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(bottom: 100),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Spacing.vSmall,
              const Center(
                child: Text(
                  'Engro Maintenance Report',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ),
              Spacing.vExtraLarge,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(87, 130, 243, 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'AS-01',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Workshop',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(3, 155, 16, 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Stationary',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacing.vExtraLarge,
              const Text(
                'Equipment Description',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Spacing.vStandard,
              const Text(
                "Vestibulum facilisis aliquam tellus eget ultricies. Fusce maximus vitae dolor at porta.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Problem Statement: What happened?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Spacing.vStandard,
              const Text(
                "Donec condimentum dictum tincidunt. In condimentum urna vitae gravida aliquam. Praesent eget condimentum tellus. Praesent quis tortor eget turpis dignissim bibendum. Donec cursus tempor ligula, ut dignissim augue commodo eu. A posuere massa nisl mollis odio.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Key Findings: Why it happened?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Spacing.vStandard,
              const Text(
                "Nullam varius erat in mi auctor, vel euismod urna pellentesque. Nullam non felis laoreet, malesuada elit quis, facilisis augue. Etiam aliquet accumsan lectus, ut cursus enim dignissim sit amet. Pellentesque luctus tellus enim, id ornare felis mattis eget.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Solution: How was it rectified?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Spacing.vStandard,
              const Text(
                "Nullam varius erat in mi auctor, vel euismod urna pellentesque. Nullam non felis laoreet, malesuada elit quis, facilisis augue. Etiam aliquet accumsan lectus, ut cursus enim dignissim sit amet. Pellentesque luctus tellus enim, id ornare felis mattis eget.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Prevention: How to avoid it in future?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              Spacing.vStandard,
              const Text(
                "Vivamus fermentum neque in libero semper blandit. Vivamus mattis quam ac neque aliquet, eget condimentum urna malesuada. Ut laoreet tellus in pretium condimentum.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Area GL',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          "Vestibulum",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created by',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          "abc@gmail.com",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
