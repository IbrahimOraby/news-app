import 'package:flutter/material.dart';
import 'package:iti_day3_session/data/app_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedCategoryIcon = categoryIcons[0];

  bool isLoading = false;
  bool isLoaded = false;

  Future<void> _fetchNews() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Here you'd normally fetch data from your API
    // For example: await fetchNewsFromApi();

    setState(() {
      isLoading = false;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child:
              !isLoaded
                  ? isLoading
                      ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFFF3A44),
                        ),
                      ) // Show loader
                      : ElevatedButton(
                        onPressed: _fetchNews,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF3A44),
                        ),
                        child: Text(
                          'Get News',
                          style: TextStyle(color: Colors.white),
                        ),
                      ) // Show Get News button
                  : buildMainContent(width, height), // Show your full UI
        ),
      ),
    );
  }

  Widget buildMainContent(double width, double height) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    hintText: 'Dogecoin to the Moon...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFFF0F1FA),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              SvgPicture.asset(
                'assets/images/notif_badge.svg',
                width: 33,
                height: 32,
              ),
            ],
          ),
        ),
        // latest news
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest News',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text('See All', style: TextStyle(color: Color(0xFF0080FF))),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 12, color: Color(0xFF0080FF)),
                ],
              ),
            ],
          ),
        ),
        //
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsCards.length,
              itemBuilder:
                  (context, i) => Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 321,
                      height: 240,
                      child: Stack(
                        children: [
                          Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(newsCards[i]['img']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text(
                                  'by ${newsCards[i]['author']}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  newsCards[i]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  newsCards[i]['description'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < categoryIcons.length; i++)
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed:
                          () => setState(() {
                            _selectedCategoryIcon = categoryIcons[i];
                          }),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFFF0F1FA),
                          ),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient:
                              _selectedCategoryIcon == categoryIcons[i]
                                  ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFF3A44),
                                      Color(0xFFFF8086),
                                    ],
                                  )
                                  : null,
                          color:
                              _selectedCategoryIcon == categoryIcons[i]
                                  ? null
                                  : Colors.white,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Text(
                            categoryIcons[i],
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  _selectedCategoryIcon == categoryIcons[i]
                                      ? Colors.white
                                      : const Color(0xFF2E0505),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (int i = 0; i < categoryCards.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    height: 128,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            categoryCards[i]['img'],
                            width: width,
                            height: height,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.28),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryCards[i]['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoryCards[i]['author'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    categoryCards[i]['date'] ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Navigation Bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 48,
          child: Center(
            child: Container(
              width: 289,
              height: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 16,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, color: Color(0xFFFF3A44), size: 24),
                        SizedBox(height: 4),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2E0505),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/heart.svg',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Favorites',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFFA6A6A6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: -12,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 24,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/smile.svg',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFA6A6A6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
