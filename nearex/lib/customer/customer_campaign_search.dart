

// class 

// class CustomerCampaignSearch extends ConsumerWidget {
//   String searchKey;
//   CustomerCampaignSearch({required this.searchKey, super.key});

//   final ScrollController _scrollController = ScrollController();
//   final itemsProvider =
//       StateNotifierProvider<_CampaignStateNotifier, Campaign>((ref) => _CampaignStateNotifier(state));
// //   final itemsProvider =
// //     StateNotifierProvider<PaginationNotifier<Item>, PaginationState<Item>>(
// //         (ref) {
// //   return PaginationNotifier(
// //     itemsPerBatch: 20,
// //     fetchNextItems: (
// //       item,
// //     ) {
// //       return ref.read(databaseProvider).fetchItems(item);
// //     },
// //   )..init();
// // });

//   late double _screenWidth;
//   late TextEditingController _searchKeyController;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     _screenWidth = DimensionValue.getScreenWidth(context);
//     _searchKeyController = TextEditingController(text: searchKey);
//     _scrollController.addListener(() {
//       double maxScroll = _scrollController.position.maxScrollExtent;
//       double currentScroll = _scrollController.position.pixels;
//       double delta = MediaQuery.of(context).size.width * 0.20;
//       if (maxScroll - currentScroll <= delta) {
//         ref.read(itemsProvider.notifier).fetchNextBatch();
//       }
//     });
//     return Scaffold(
//       appBar: AppBar(),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                     width: _screenWidth * 0.75,
//                     child: Form(
//                         child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _searchKeyController,
//                           decoration: const InputDecoration(
//                               hintText: 'Tìm tên sản phẩm',
//                               prefixIcon: Icon(Icons.search)),
//                           // textInputAction: TextInputAction.search,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Vui lòng nhập tên sản phẩm';
//                             }
//                             return null;
//                           },
//                           onFieldSubmitted: (value) => {
//                             Navigate.navigate(
//                                 CustomerCampaignSearch(
//                                     searchKey: _searchKeyController.text),
//                                 context)
//                           },
//                         ),
//                       ],
//                     ))),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: ColorBackground.textColor1,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const FaIcon(
//                       FontAwesomeIcons.sliders,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CampaignStateNotifier extends StateNotifier<Campaign> {
//   _CampaignStateNotifier(): super(0);
// }
