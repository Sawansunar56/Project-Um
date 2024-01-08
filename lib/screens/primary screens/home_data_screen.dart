import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_um/screens/secondary%20screens/add_annoucements.dart';
import 'package:project_um/screens/secondary%20screens/club_screen.dart';
import 'package:project_um/screens/secondary%20screens/faculty_screen.dart';
import 'package:project_um/screens/secondary%20screens/student_board_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../secondary screens/information_screen.dart';
import '../../utils/announcement.dart';
import '../../utils/info_icons.dart';
import '../../utils/next_page_widg.dart';
import '../../utils/recommendations.dart';

class HomeDataScreen extends StatelessWidget {
  HomeDataScreen({super.key});
  final TextEditingController _search = TextEditingController();
  final List items = [
    ['1.png', 'Student Board Information', StudentBoardScreen()],
    ['2.png', 'Faculty Information', FacultyScreen()],
    [
      '3.png',
      'University Information',
      FacultyScreen(),
    ],
    ['4.png', 'Clubs Information', ClubScreen()],
    ['5.png', 'Academic Calendar', ClubScreen()],
  ];

  Stream<QuerySnapshot> getDataStream() {
    return FirebaseFirestore.instance.collection('message').snapshots();
  }

  Stream<QuerySnapshot> getRecommendationStream() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
                hintText: "Find annoucements Information, Clubs Information...",
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
                GestureDetector(
                    onTap: () {
                      if (item[0] == "3.png") {
                        _launchUrl("https://www.dbuniversity.ac.in/");
                      }
                      if (item[0] == "4.png") {
                        _launchUrl("https://www.dbuniversity.ac.in/");
                      }
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => item[2]));
                    },
                    child: InfoIcons(
                        imageName: 'assets/${item[0]}', sectionName: item[1]))
            ],
          ),
          NextPage(title: "Recent Announcements"),
          SizedBox(
            height: 120,
            child: StreamBuilder(
              stream: getDataStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;
                    final messageId = messages[index].reference.id;
                    return Announcements(
                      title: message["title"],
                      content: message["content"],
                    );
                  },
                );
              },
            ),
          ),
          NextPage(title: "New Recommendations"),
          Expanded(
            child: StreamBuilder(
              stream: getRecommendationStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final products = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product =
                        products[index].data() as Map<String, dynamic>;
                    final productId = products[index].reference.id;
                    return GestureDetector(
                      child: Recommendations(product: product),
                      // title: Text("${product['productName']}"),
                      // subtitle: Text("${product['productDescription']}"),
                      // trailing: Text('${product['productCost']}'),
                      onTap: () {
                        // navigate to product details page
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: ((context) => ProductDetailsPage(
                        //         product: product, productId: productId)),
                        //   ),
                        // );
                      },
                    );
                  },
                );
              },
            ),
          ),
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
