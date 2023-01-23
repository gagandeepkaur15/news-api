import 'package:flutter/material.dart';
import 'package:news/news_class.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

class _FeedState extends State<Feed> {
  dataClass model = dataClass();
  bool circular = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<dataClass>> getData() async {
    const url = "https://api.dev.agrishots.in/articles?page=1&perPage=758";
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    var jsonArray = jsonData['data'];

    List<dataClass> postList = []; //countries
    for (var i in jsonArray) {
      dataClass data = dataClass(title: i['title']); //country
      postList.add(data);
    }
    print(postList);
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final PageController controller = PageController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<dataClass>>(
        future: getData(),
        builder: (context, snapshot) {
          // return const Center(
          //   child: Text("NO DATA"),
          // );
          if (snapshot.hasData) {
            print(snapshot.data!.length);
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: controller,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: size.height * 2,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(2.5.h, 6.h, 2.5.h, 2.h),
                          child: Row(
                            children: [
                              Text(
                                'Agri',
                                style: GoogleFonts.merriweather(
                                  color: const Color.fromARGB(255, 28, 207, 3),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'shots',
                                style: GoogleFonts.merriweather(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 30.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data!
                                    .elementAt(index)
                                    .mediaslug
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: Text(
                            snapshot.data!.elementAt(index).title.toString(),
                            style: GoogleFonts.merriweather(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 2.5.h,
                            ),
                            Text(
                              snapshot.data!.elementAt(index).author.toString(),
                              style: TextStyle(
                                shadows: const [
                                  Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    const Color.fromARGB(255, 28, 207, 3),
                                decorationThickness: 1,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 2.h,
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 2.h,
                            ),
                            Container(
                              height: 2.7.h,
                              width: 5.5.h,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 28, 207, 3),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(0.5.h),
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 3.h,
                              ),
                              const Icon(
                                Icons.bookmark_border_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2.h, 0.h, 1.5.h, 0.h),
                          child: Text(
                            snapshot.data!
                                .elementAt(index)
                                .description
                                .toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
