import 'package:flutter/material.dart';
import 'package:iti_day3_session/data/models/news_models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              news.urlToImage ?? 'https://via.placeholder.com/400',
              fit: BoxFit.cover,
            ),
          ),

          //content
          Positioned.fill(
            top: 352,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15, 88, 15, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      news.title ?? 'No title available',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Content
                    Text(
                      news.content ??
                          news.description ??
                          'No content available',
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //overlay container
          Positioned(
            top: 295,
            left: 32,
            right: 32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),

              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ), // Added blur filter
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.publishedAt ?? 'No Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF2E0505),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        news.description ?? 'No Description',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2E0505),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        news.author ?? 'No Author',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          color: Color(0xFF2E0505),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //back icon
          Positioned(
            top: 52,
            left: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 48),
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 56,
            height: 56,
            child: SvgPicture.asset(
              'assets/images/FAB.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
