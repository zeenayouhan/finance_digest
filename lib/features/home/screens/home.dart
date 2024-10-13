import 'package:finance_digest/constants/theme/app_fonts.dart';
import 'package:finance_digest/utils/text_style_helper.dart';
import 'package:flutter/material.dart';

import '../../../components/cards/card.dart';
import '../../../constants/theme/app_colors.dart';
import '../../signup/services/auth_service.dart';
import '../models/news_item.dart';
import '../services/news_service.dart';
import '../../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthService _authService;
  late NewsService _newsService;

  String? name;
  final ScrollController _scrollController = ScrollController();
  List<NewsItem> _newsList = []; // All news items fetched
  List<NewsItem> _displayedNewsList = []; // Items currently displayed
  final int _itemsPerPage = 20; // Number of items to load at a time
  bool _isLoadingMore = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _newsService = NewsService(authService: _authService);
    _getUserName();
    _getNews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore) {
        _loadMoreItems();
      }
    });
  }

  Future<void> _getUserName() async {
    try {
      final userData = await _authService.getMetadata();
      setState(() {
        name = userData.firstName;
      });
    } catch (e) {
      debugPrint('Error fetching user name: $e');
    }
  }

  Future<void> _getNews() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newsList = await _newsService.getNewsList();
      if (newsList != null) {
        setState(() {
          _newsList = newsList;
          _displayedNewsList = _newsList.take(_itemsPerPage).toList();
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong. Please try again later.';
      });
      debugPrint('Error fetching news: $e');
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _loadMoreItems() {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        int currentLength = _displayedNewsList.length;
        int nextLength = currentLength + _itemsPerPage;
        nextLength =
            nextLength > _newsList.length ? _newsList.length : nextLength;

        _displayedNewsList = _newsList.take(nextLength).toList();
        _isLoadingMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final appFonts = Theme.of(context).extension<AppFonts>();

    return Scaffold(
      backgroundColor: appColors?.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(name, appColors, appFonts),
            Expanded(
              child: _buildNewsList(context, appColors, appFonts),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(
      String? name, AppColors? appColors, AppFonts? appFonts) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
      child: Text(
        "Hey ${name ?? 'there'}",
        style: reusableTextStyle(
          fontSize: 32,
          color: appColors?.white,
          fontFamily: appFonts?.otherFont,
          fontWeight: FontWeight.w900,
          context: context,
        ),
      ),
    );
  }

  Widget _buildNewsList(
      BuildContext context, AppColors? appColors, AppFonts? appFonts) {
    if (errorMessage.isNotEmpty) {
      return _buildErrorMessage(appColors, appFonts);
    }

    if (_displayedNewsList.isEmpty && _isLoadingMore) {
      return Center(
          child: CircularProgressIndicator(
        color: appColors?.primary,
      ));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _displayedNewsList.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _displayedNewsList.length) {
          return _buildLoadingIndicator(appColors);
        }
        final newsItem = _displayedNewsList[index];
        final date = formattedDate(newsItem.datetime);
        return CardItem(
          image: newsItem.image,
          date: date,
          source: newsItem.source,
          headline: newsItem.headline,
          url: newsItem.url,
        );
      },
    );
  }

  Widget _buildLoadingIndicator(AppColors? appColors) {
    return Center(
      child: CircularProgressIndicator(
        color: appColors?.primary,
      ),
    );
  }

  Widget _buildErrorMessage(AppColors? appColors, AppFonts? appFonts) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Text(
        errorMessage,
        style: reusableTextStyle(
            context: context,
            color: appColors?.white,
            fontFamily: appFonts?.subFont,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
