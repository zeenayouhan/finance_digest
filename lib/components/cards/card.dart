import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance_digest/constants/theme/app_fonts.dart';
import 'package:finance_digest/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/theme/app_colors.dart';

class CardItem extends StatefulWidget {
  final String image;
  final String source;
  final String date;
  final String headline;
  final String url;

  const CardItem({
    super.key,
    required this.image,
    required this.source,
    required this.date,
    required this.headline,
    required this.url,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  //Method to launch the URL in an external site
  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final appFonts = Theme.of(context).extension<AppFonts>();

    return GestureDetector(
      onTap: _launchUrl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSourceAndDate(context, appColors, appFonts),
                  const SizedBox(height: 8),
                  _buildHeadline(context, appColors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: widget.image,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
      placeholder: (context, url) => SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 100,
        width: 100,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  Widget _buildSourceAndDate(
      BuildContext context, AppColors? appColors, AppFonts? appFonts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _buildHeaderText(
            context: context,
            title: widget.source.toUpperCase(),
            appColors: appColors,
            appFonts: appFonts,
          ),
        ),
        const SizedBox(width: 10),
        _buildHeaderText(
          context: context,
          title: widget.date.toUpperCase(),
          appColors: appColors,
          appFonts: appFonts,
        ),
      ],
    );
  }

  Widget _buildHeadline(BuildContext context, AppColors? appColors) {
    return Text(
      widget.headline,
      style: reusableTextStyle(
        context: context,
        color: appColors?.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ).copyWith(height: 1.2),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHeaderText({
    required BuildContext context,
    required String title,
    AppColors? appColors,
    AppFonts? appFonts,
  }) {
    return Text(
      title,
      style: reusableTextStyle(
        context: context,
        fontFamily: appFonts?.subFont,
        color: appColors?.white,
        fontSize: 12,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
