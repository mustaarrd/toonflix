import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toonflix/model/Webtoon.dart';
import 'package:toonflix/service/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // @immutable 에러가 발생하면 final로 선언하면 됨.

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  //final Future<String> temp = ApiService.delay(Duration(seconds: 10));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          'Today\'s Webtoon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            SizedBox(
              width: 250,
              child: //  https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent
                  Image.network(
                webtoon.thumb,
                headers: const {
                  'Referer': 'https://comic.naver.com',
                  "User-Agent":
                      "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1",
                },
              ),
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///
/// Stateful example
///
///
///////////////////////////////////////////////////////////////////////////////

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<WebtoonModel> webtoons = [];
//   bool isLoading = true;

//   void waitForWebToons() async {
//     webtoons = await ApiService.getTodaysToons();
//     isLoading = false;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     waitForWebToons();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(webtoons);
//     print(isLoading);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 1,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.green,
//         title: Text(
//           'Today\'s Webtoon',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: Container(),
//     );
//   }
// }
