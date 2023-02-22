import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:chatgpt/network/admob_service_helper.dart';
import 'package:chatgpt/src/pages/chat_page.dart';
import 'package:chatgpt/src/pages/dalle_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';
import 'onboarding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static AdRequest request = const AdRequest(nonPersonalizedAds: true);

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  final BannerAd myBanner = BannerAd(
    adUnitId: AdMobService.bannerAdUnitId ?? '',
    size: AdSize.fullBanner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId ?? '',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            log('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    super.initState();
  //  myBanner.load();
   // _createInterstitialAd();
  }
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IOE Ai',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          SizedBox(height: 70),

          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatPage(),
                    ),
                  );
                },
                child:
              Padding(
                padding: const EdgeInsets.all(6.0),
                child:
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.greenAccent[100],
                child: SizedBox(
                  width: 200,
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green[500],
                          radius: 108,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.callcentrehelper.com/images/stories/2020/10/chat-bot-head-set-760.jpg"), //NetworkImage
                            radius: 100,
                          ), //CircleAvatar
                        ), //CircleAvatar
                        const SizedBox(
                          height: 10,
                        ), //SizedBox
                        Text(
                          'Chat IOE',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.green[900],
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        ), //Text //Text
                        const SizedBox(
                          height: 10,
                        ), //SizedBox

                      ],
                    ), //Column
                  ), //Padding
                ), //SizedBox
              ))),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DallePage(),
                    ),
                  );
                },
                child:
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.greenAccent[100],
                child: SizedBox(
                  width: 200,
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green[500],
                          radius: 108,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://i.guim.co.uk/img/media/ef8492feb3715ed4de705727d9f513c168a8b196/37_0_1125_675/master/1125.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=cb647d991d8897cc8a81d2c33c4406d5"), //NetworkImage
                            radius: 100,
                          ), //CircleAvatar
                        ), //CircleAvatar
                        const SizedBox(
                          height: 10,
                        ), //SizedBox
                        Text(
                          'Gene',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.green[900],
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        ), //Text //Text
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ), //Column
                  ), //Padding
                ), //SizedBox
              ) ),
            ],
          ),
           //Card
          SizedBox(height: 80,),
          Text('IOE - Network, Shenzhen, 2023'),
          Text("All Text Sent Or Received Are 100% Encrypted"),
          Text("Any Question +8613250820813"),

          // buttonWidget("WhatsApp Support", () {
          //   _launchUrl(
          //     Uri.parse(
          //       'http://wa.me/+923055573634?text=hello',
          //     ),
          //   );
          // }),
        ],
      ),
      // bottomNavigationBar: Container(
      //   alignment: Alignment.center,
      //   width: myBanner.size.width.toDouble(),
      //   height: myBanner.size.height.toDouble(),
      //   child: AdWidget(ad: myBanner),
      // ),
    );
  }

  Widget buttonWidget(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 40,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }
}
