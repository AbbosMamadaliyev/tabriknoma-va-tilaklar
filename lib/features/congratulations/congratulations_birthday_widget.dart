import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

class CongratulationsWidget extends StatefulWidget {
  const CongratulationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CongratulationsWidget> createState() => _CongratulationsWidgetState();
}

class _CongratulationsWidgetState extends State<CongratulationsWidget> {
  InterstitialAd? _interstitialAd;

  final _searchController = TextEditingController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTap(CongratulationsModel congratulation, String where, String tableName, int categoryIndex) {
    FocusScope.of(context).unfocus();

    // tabriklar bosilganda provider orqali borib read() qilib keladi
    // keyingi oynaga otganda , bosilganini sezib chiqarib beradi contentni
    context.read<DbServiceProver>().getData(where: where, tableName: tableName);

    void openContent() {
      if (!mounted) return;
      Navigator.of(context).pushNamed(
        MainNavigationNames.content,
        arguments: {
          'id': congratulation.id,
          'tableName': tableName,
          'categoryIndex': categoryIndex,
        },
      );
    }

    // Session: 1-chi kirishda reklama yo'q, keyingilarida bor.
    if (!AdHelper.shouldShowInterstitialThisSession(AdHelper.placementContent)) {
      openContent();
      return;
    }

    final interstitialAd = _interstitialAd;
    _interstitialAd = null;
    AdHelper.showInterstitial(
      ad: interstitialAd,
      onComplete: () {
        _loadInterstitialAd();
        openContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // bu appbar title' uchun
    final categories = context.watch<CategoryModelProvider>().categories(context.locale.languageCode);

    final congratulations = context.watch<DbServiceProver>().congratulations;

    var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var where = args['where'];
    var tableName = args['tableName'];
    var categoryIndex = args['categoryIndex'];

    final query = normalizeForSearch(_search.trim());
    final visible = query.isEmpty
        ? congratulations
        : congratulations.where((c) => normalizeForSearch(c.content).contains(query)).toList();

    final isLoading = congratulations.isEmpty && query.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(categories[categoryIndex].category),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.xs, AppSpace.l, AppSpace.m),
                child: _SearchField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _search = value),
                  onClear: () {
                    _searchController.clear();
                    setState(() => _search = '');
                  },
                ),
              ),
            ),
            if (isLoading)
              SliverList.separated(
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpace.l),
                  child: SkeletonBox(height: 92),
                ),
              )
            else if (visible.isEmpty)
              SliverToBoxAdapter(
                child: AppEmptyState(
                  icon: Icons.search_off_rounded,
                  title: LocaleKeys.nothing_found.tr(),
                  message: LocaleKeys.nothing_found_hint.tr(),
                ),
              )
            else
              SliverList.separated(
                itemCount: visible.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final congratulation = visible[index];
                  return GreetingPreviewCard(
                    content: congratulation.content,
                    saved: congratulation.favourite == 1,
                    onTap: () => _onItemTap(congratulation, where, tableName, categoryIndex),
                  );
                },
              ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpace.xxl)),
          ],
        ),
      ),
      bottomNavigationBar: BottomBannerBar(adUnitId: AdHelper.bannerAdUnitId),
    );
  }

  void _loadInterstitialAd() {
    AdHelper.loadInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId,
      onLoaded: (ad) {
        if (!mounted) {
          ad.dispose();
          return;
        }
        setState(() => _interstitialAd = ad);
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged, required this.onClear});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.tile),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpace.m),
          const Icon(Icons.search_rounded, color: AppColors.inkTertiary, size: 22),
          const SizedBox(width: AppSpace.s),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: AppText.body,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: LocaleKeys.search.tr(),
                border: InputBorder.none,
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox(width: AppSpace.m);
              return IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.cancel_rounded, color: AppColors.inkTertiary, size: 20),
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
              );
            },
          ),
        ],
      ),
    );
  }
}
