import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/theme.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;

    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<NewsProvider>(context, listen: false).getNews();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: _isLoading != true
            ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "News Daily",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: newsProvider.news.length,
                      itemBuilder: (context, index) {
                        final newsIndex = newsProvider.news[index];
                        final parseDate =
                            DateTime.parse("${newsIndex.publishedAt}");
                        final dateFormat =
                            DateFormat('dd MMM yyyy').format(parseDate);
                        return Container(
                          height: 120,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffDDDDDD)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${newsIndex.urlToImage}",
                                    ),
                                  ),
                                ),
                                height: 90,
                                width: 90,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                    top: 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${newsIndex.title}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style:
                                            mainContent.copyWith(fontSize: 14),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${newsIndex.description}",
                                          style: descContent.copyWith(
                                              fontSize: 10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 8, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${dateFormat}",
                                              style: mainContent.copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                "assets/bookmark.png",
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
