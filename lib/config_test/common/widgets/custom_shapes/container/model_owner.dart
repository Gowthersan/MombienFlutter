import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mombien_test/config_test/common/widgets/shimmers/shimmer.dart';
import 'package:mombien_test/config_test/features/annonces/models/details_annonces.dart';
import 'package:mombien_test/core.dart';

class TModelOwner extends StatelessWidget {
  const TModelOwner({
    super.key,
    required this.onTap,
    required this.dark,
    required this.thumbnail,
    required this.title,
    required this.subTitle,
    required this.details,
    required this.owner,
  });

  final void Function()? onTap;
  final bool dark;
  final String thumbnail;
  final String title;
  final String subTitle;
  final List<TDetailsModel> details;
  final String owner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 138,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(right: 1, top: 12, bottom: 12),
        decoration: BoxDecoration(
            color: dark ? TColors.darkerGrey : TColors.grey,
            borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(TSizes.inputFieldRadius),
                    bottomLeft: Radius.circular(TSizes.inputFieldRadius),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    // color: overlayColor,
                    imageUrl: thumbnail,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const TShimmerEffect(
                                width: double.infinity, height: 70, radius: 12),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .apply(
                                  color: dark ? TColors.white : TColors.black)
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            subTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                                    color: dark ? TColors.white : TColors.black)
                                .copyWith(
                                  fontSize: 11,
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: TCaracteristiquesP(
                        details: details,
                        height: 25,
                        size: 17,
                        showText: true,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Publié par : $owner',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: dark ? TColors.white : TColors.black)
                          .copyWith(
                            fontSize: 10,
                          ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
