import 'package:flutter/material.dart';
import '../secondary screens/information_screen.dart';
import '../../utils/announcement.dart';
import '../../utils/info_icons.dart';
import '../../utils/next_page_widg.dart';
import '../../utils/recommendations.dart';

class HomeDataScreen extends StatelessWidget {
  HomeDataScreen({super.key});
  final TextEditingController _search = TextEditingController();
  final List items = [
    ['1.png', 'Student Board Information'],
    ['2.png', 'Faculty Information'],
    ['3.png', 'University Information'],
    ['4.png', 'Clubs Information'],
    ['5.png', 'Academic Calendar'],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "Find Teachers Information, Clubs Information...",
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                contentPadding:
                    EdgeInsets.only(top: 12.0, bottom: 5.0, right: 10.0),
              ),
              controller: _search,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InformationScreen()));
            },
            child: NextPage(title: "Information"),
          ),
          Row(
            children: [
              for (var item in items)
                InfoIcons(imageName: 'assets/${item[0]}', sectionName: item[1])
            ],
          ),
          NextPage(title: "Recent Announcements"),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Announcements(),
                Announcements(),
              ],
            ),
          ),
          NextPage(title: "New Recommendations"),
          Expanded(
              child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 260,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20),
            itemBuilder: (context, int index) {
              return Recommendations();
            },
          )),
          // Expanded(
          //     child: GridView.count(
          //   crossAxisCount: 2,
          //   children: [
          //     Recommendations(),
          //   ],
          // ))
          // Expanded(
          //     child: ListView(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Recommendations(),
          //         Recommendations(),
          //       ],
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Recommendations(),
          //         Recommendations(),
          //       ],
          //     ),
          //   ],
          // )),
        ],
      ),
    );
  }
}
