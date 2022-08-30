import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Api Call/Get_Audio_Data/get_audio_data.dart';
import '../Api Call/Get_News_Data/get_data.dart';
import '../Api Call/Get_video_data/get_video_data.dart';
import '../Widgets/Drawer/navigation_container.dart';
import '../utils/colors.dart';
import 'News_Screens/news_detail_screen.dart';
import 'Social_link_view/website_view_screen.dart';
import 'Video_Play_Screens/video_play_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AudioPlayer advancedPlayer = AudioPlayer();
  late YoutubePlayerController _controller;
  bool isPlaying = false;
  bool isMusicPlay = false;
  int? _currentIndex;

  DateTime TextData(String link) {
    final now = link;
    final time = DateTime.parse(now);
    return time;
  }

  Future<void> RadioOn() {
    isPlaying = true;
    return advancedPlayer.play("http://mehramedia.com:8051/;stream.mp3");
  }

  @override
  void initState() {
    super.initState();

    final videoModel = Provider.of<VideoDataClass>(context, listen: false);
    videoModel.getVideoData();
    RadioOn();
    final AudioModel = Provider.of<AudioDataClass>(context, listen: false);
    AudioModel.getAudioData();

    final newsModel = Provider.of<NewsDataClass>(context, listen: false);
    newsModel.getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    final videoModel = Provider.of<VideoDataClass>(context);
    final AudioModel = Provider.of<AudioDataClass>(context);
    final newsModel = Provider.of<NewsDataClass>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.appRedColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //_scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        centerTitle: true,
        title: Text(
          "Radio Punjab Today",
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 180.h,
            color: Colors.purpleAccent,
            child: Image.asset(
              'assets/images/radio _logo.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                tileColor: Colors.white,
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/images/radio _logo.jpg',
                      width: 50.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    )),
                title: Text(
                  "Radio Punjab Today",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.appRedColor),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (isPlaying == false) {
                      advancedPlayer
                          .play("http://mehramedia.com:8051/;stream.mp3");
                      setState(() {
                        isPlaying = true;
                      });
                    } else if (isPlaying == true) {
                      advancedPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    }
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Video",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) => AlertDialog(
                              alignment: Alignment.center,
                              backgroundColor: Colors.white,
                              title: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 20),
                                child: Text(
                                  "921-641-0666",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              content: Container(
                                height: 60,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red[800],
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final phoneNum = "+112345678";
                                              final url = "tel:${phoneNum}";
                                              if (await canLaunch(url)) {
                                                await launch(
                                                  url,
                                                );
                                              }
                                            },
                                            child: Text(
                                              "CALL",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red[800],
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              titlePadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                            ));
                  },
                  child: Text(
                    "Call Studio",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.appRedColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.appRedColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.appRedColor,
                  ),
                ),
              ],
            ),
          ),
          videoModel.loading
              ? Container(
                  color: Colors.grey,
                )
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: videoModel.videos!.video!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => VideoCategory(
                                        youtubeUrl: videoModel
                                            .videos!.video![index].url
                                            .toString(),
                                        titleTex: videoModel
                                            .videos!.video![index].title
                                            .toString(),
                                      )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 90,
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 100,
                                      child: YoutubePlayer(
                                        controller: YoutubePlayerController(
                                            initialVideoId:
                                                YoutubePlayer.convertUrlToId(
                                                    videoModel.videos!
                                                        .video![index].url
                                                        .toString())!,
                                            flags: YoutubePlayerFlags(
                                                autoPlay: false,
                                                isLive: false,
                                                mute: true,
                                                hideControls: true,
                                                disableDragSeek: true)),
                                        showVideoProgressIndicator: false,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 15,
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "New",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Container(
                                            height: 15,
                                            width: 60,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                videoModel
                                                    .videos!.video![index].title
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Audio",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.appRedColor,
                  ),
                ),
              ],
            ),
          ),
          AudioModel.loading
              ? Container(
                  color: Colors.grey,
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 100.h,
                  child: ListView.builder(
                      itemCount: AudioModel.audios!.audio!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (isMusicPlay == false) //true
                              {
                                advancedPlayer.play(AudioModel
                                    .audios!.audio![index].audioPath!);
                                setState(() {
                                  isMusicPlay = true;
                                  _currentIndex = index;
                                });
                              } else if (isMusicPlay == true) {
                                advancedPlayer.pause();
                                setState(() {
                                  isMusicPlay = false;
                                  _currentIndex = index;
                                });
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Container(
                                  height: 90.h,
                                  width: 90.w,
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Stack(children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Image.network(
                                            AudioModel
                                                .audios!.audio![index].imgPath!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "New",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: AppColors
                                                            .appRedColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMMd().format(
                                                      TextData(AudioModel
                                                          .audios!
                                                          .audio![index]
                                                          .createdAt!),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: _currentIndex == index
                                          ? isMusicPlay
                                              ? Icon(
                                                  Icons.pause,
                                                  size: 50,
                                                  color: Colors.red[800],
                                                )
                                              : Icon(
                                                  Icons.play_arrow,
                                                  size: 50,
                                                  color: Colors.red[800],
                                                )
                                          : Icon(
                                              Icons.play_arrow,
                                              size: 50,
                                              color: Colors.red[800],
                                            ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          )),
                ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "News",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.appRedColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          newsModel.loading
              ? Container(
                  color: Colors.grey,
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => NewsDetailScreen(
                            dataDate: DateFormat.yMMMMd().format(
                              TextData(
                                  newsModel.post!.items![0].datePublished!),
                            ),
                            bodyText: newsModel.post!.items![0].contentText!,
                            imgUrl: newsModel.post!.items![0].image!,
                            titleText: newsModel.post!.items![0].title!,
                            dateTime: DateFormat.jm().format(TextData(
                                newsModel.post!.items![0].datePublished!)))));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 230.h,
                        width: double.maxFinite,
                        child: Stack(children: [
                          Container(
                              height: 230.h,
                              width: double.maxFinite,
                              child: Image.network(
                                newsModel.post!.items![0].image!,
                                fit: BoxFit.cover,
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 80.h,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModel.post!.items![0].title
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat.jm().format(TextData(
                                                newsModel.post!.items![0]
                                                    .datePublished!)),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            DateFormat.yMMMMd().format(
                                              TextData(newsModel.post!.items![0]
                                                  .datePublished!),
                                            ),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ]),
                      ),
                    ),
                  ),
                ),
          newsModel.loading
              ? Container(
                  color: Colors.grey,
                )
              : Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => NewsDetailScreen(
                                  dataDate: DateFormat.yMMMMd().format(
                                    TextData(newsModel
                                        .post!.items![1].datePublished!),
                                  ),
                                  bodyText:
                                      newsModel.post!.items![1].contentText!,
                                  imgUrl: newsModel.post!.items![1].image!,
                                  titleText: newsModel.post!.items![1].title!,
                                  dateTime: DateFormat.jm().format(
                                    TextData(
                                      newsModel.post!.items![1].datePublished!,
                                    ),
                                  ))));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              height: 130.h,
                              width: double.maxFinite,
                              child: Stack(children: [
                                Container(
                                    height: 130.h,
                                    width: double.maxFinite,
                                    child: Image.network(
                                      newsModel.post!.items![1].image!,
                                      fit: BoxFit.fill,
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 45.h,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 20.h,
                                              child: SingleChildScrollView(
                                                child: Center(
                                                  child: Text(
                                                    newsModel
                                                        .post!.items![1].title
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    DateFormat.jm().format(
                                                        TextData(newsModel
                                                            .post!
                                                            .items![1]
                                                            .datePublished!)),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMMd().format(
                                                      TextData(newsModel
                                                          .post!
                                                          .items![1]
                                                          .datePublished!),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ))
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => NewsDetailScreen(
                                  dataDate: DateFormat.yMMMMd().format(
                                    TextData(newsModel
                                        .post!.items![2].datePublished!),
                                  ),
                                  bodyText:
                                      newsModel.post!.items![2].contentText!,
                                  imgUrl: newsModel.post!.items![2].image!,
                                  titleText: newsModel.post!.items![2].title!,
                                  dateTime: DateFormat.jm().format(TextData(
                                      newsModel
                                          .post!.items![2].datePublished!)))));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              height: 130.h,
                              width: double.maxFinite,
                              child: Stack(children: [
                                Container(
                                    height: 130.h,
                                    width: double.maxFinite,
                                    child: Image.network(
                                      newsModel.post!.items![2].image!,
                                      fit: BoxFit.fill,
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 45.h,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 20.h,
                                              child: SingleChildScrollView(
                                                child: Center(
                                                  child: Text(
                                                    newsModel
                                                        .post!.items![2].title
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    DateFormat.jm().format(
                                                        TextData(newsModel
                                                            .post!
                                                            .items![2]
                                                            .datePublished!)),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMMd().format(
                                                      TextData(newsModel
                                                          .post!
                                                          .items![2]
                                                          .datePublished!),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ))
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Social",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.appRedColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => WebSiteView(
                        link: "https://radiopunjabtoday.com/",
                        appBarTitle: "Website",
                      )));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/images.jfif",
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Website",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => WebSiteView(
                        link: "https://m.facebook.com/radiopunjabtoday/",
                        appBarTitle: "facebook",
                      )));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/Facebook-Icon-Large.png",
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "FaceBook",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => WebSiteView(
                        link: "https://youtube.com/c/RadioPunjabtoday",
                        appBarTitle: "Youtube",
                      )));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/YouTube.png",
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "YouTube",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final toEmail = "info@radiopunjabtoday.com";
              final subject = 'Great Radio';
              final message = 'Hello! Radio Punjab';
              final url =
                  "mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}";

              await launch(url);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/email_logo.png",
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Email Us",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 110.h,
          )
        ],
      ),
      bottomSheet: Container(
        height: 95.h,
        color: Colors.white,
        child: Card(
          child: ListTile(
            tileColor: Colors.white,
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  'assets/images/radio _logo.jpg',
                  width: 50.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                )),
            title: Text(
              "Radio Punjab Today",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                if (isPlaying == false) {
                  advancedPlayer.play("http://mehramedia.com:8051/;stream.mp3");
                  setState(() {
                    isPlaying = true;
                  });
                } else if (isPlaying == true) {
                  advancedPlayer.pause();
                  setState(() {
                    isPlaying = false;
                  });
                }
              },
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              color: Colors.grey,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 105.h,
              width: double.maxFinite,
              color: AppColors.appRedColor,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    "Radio Punjab Today",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                InkWell(
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> HomePage() ));
                  },
                  child: NavigationContainer(
                    titleText: "Home",
                    icon: Icons.home_filled,
                  ),
                ),
                InkWell(
                  onTap:(){
                    showDialog(
                        context: context,
                        builder: (builder) => AlertDialog(
                          alignment: Alignment.center,
                          backgroundColor: Colors.white,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20),
                            child: Text(
                              "921-641-0666",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          content: Container(
                            height: 60,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "CANCEL",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final phoneNum = "+112345678";
                                          final url = "tel:${phoneNum}";
                                          if (await canLaunch(url)) {
                                            await launch(
                                              url,
                                            );
                                          }
                                        },
                                        child: Text(
                                          "CALL",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red[800],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                        ));
                  },
                  child: NavigationContainer(
                    titleText: "Call Studio",
                    icon: Icons.call_rounded,
                  ),
                ),
                NavigationContainer(
                  titleText: "Download Audio",
                  icon: Icons.download,
                ),
                Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NavigationContainer(
                      titleText: "Our Team",
                      icon: Icons.supervised_user_circle_rounded,
                    ),
                  ),
                ),
                NavigationContainer(
                  titleText: "Privacy Policy",
                  icon: Icons.privacy_tip,
                ),
                NavigationContainer(
                  titleText: "Terms & Conditions",
                  icon: Icons.file_copy_outlined,
                ),
                NavigationContainer(
                  titleText: "Rate This App!",
                  icon: Icons.star_rate_outlined,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 43.h,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Colors.red[600],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "Version",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Text(
                                "0.1",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
