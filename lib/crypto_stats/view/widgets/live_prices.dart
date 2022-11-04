part of ui.library;

// ignore: public_member_api_docs
class LivePrices extends StatefulWidget {
  // ignore: public_member_api_docs
  const LivePrices({Key? key}) : super(key: key);

  @override
  _LivePricesState createState() => _LivePricesState();
}

class _LivePricesState extends State<LivePrices> {
  late Stream realDataStream;
  List<double> data = [];
  @override
  @override
  void initState() {
    realDataStream = BlocProvider.of<LivePricesCubit>(context).getRealData();
    super.initState();
  }
// Trade old = Trade("", "", "", "", "");
//   void color (Trade data){
//     if()
//     old = data;

//   }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      const Text('Live Prices', style: TextStyle(fontSize: 17)),
      Container(
          height: 500,
          padding: const EdgeInsets.only(top: 10),
          child: StreamBuilder<dynamic>(
              stream: realDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final realData = Trade.fromJson(
                      jsonDecode(snapshot.data.toString())
                          as Map<String, dynamic>);
                  if (data.length < 10) {
                    data.add(double.parse(realData.price));
                  } else {
                    data.removeAt(0);
                    data.add(double.parse(realData.price));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: tradeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              tradeList
                                  .firstWhere((element) =>
                                      element.symbolId == realData.symbolId)
                                  .price = realData.price;
                              tradeList
                                  .firstWhere((element) =>
                                      element.symbolId == realData.symbolId)
                                  .takerSide = realData.takerSide;

                              return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        width: 250,
                                        height: 230,
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(children: <Widget>[
                                                CircleAvatar(
                                                    backgroundImage:
                                                        tradeList[index].icon),
                                                const SizedBox(width: 20),
                                                Text(tradeList[index].title1,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(tradeList[index].title2,
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                              ]),
                                              Text(
                                                  tradeList[index]
                                                      .price
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(tradeList[index].takerSide,
                                                  style: const TextStyle(
                                                      fontSize: 16))
                                            ])),
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      BlocBuilder<LivePricesCubit, LivePricesState>(
                        builder: (context, state) {
                          return Sparkline(
                            data: data,
                            lineColor: Colors.lightGreen[500]!,
                            fillMode: FillMode.below,
                            fillColor: Colors.lightGreen[200]!,
                            pointsMode: PointsMode.all,
                            pointSize: 5.0,
                            pointColor: Colors.amber,
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }))
    ]);
  }
}
