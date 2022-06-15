import 'package:booking100/users/sidebar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CourtDetail extends StatefulWidget {
  const CourtDetail({Key? key}) : super(key: key);

  @override
  State<CourtDetail> createState() => _CourtDetailState();
}

class _CourtDetailState extends State<CourtDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
        children: const [
          ImageSlider(),
          CourtDesc(),
        ],
      )
      ),
      ),
      drawer: const NavigationDrawer()
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

final List<String> imgList = [
  'https://i.guim.co.uk/img/media/62b645060ff895a9f3a19c2056bd40e474512bf3/0_204_4189_2514/master/4189.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=d4470d9acc40d85ee5256e24bdb55d79',
  'https://img.olympicchannel.com/images/image/private/t_social_share_thumb/f_auto/primary/h94gddwhlapg9x5i4dqe',
  'https://www.lequipe.fr/_medias/img-photo-jpg/landry-n-gala-et-l-equipe-de-france-de-futsal-ont-ete-accroches-par-la-georgie-ce-mardi-4-4-a-m/1500000001423924/0:0,1998:1332-828-552-75/36221.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4VCZaQUvDPa28BnQEfZYXtmywL43u3nE26HdZeuCkik7MPp8imWP9zAfkYr9IG7vngjM&usqp=CAU',
  // 'https://scontent.fjhb2-1.fna.fbcdn.net/v/t1.6435-9/72830696_143623853699924_1467462562651045888_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=a26aad&_nc_ohc=9eKvTvHKpRoAX-SPvSv&_nc_ht=scontent.fjhb2-1.fna&oh=00_AT8_0A1Wfn7hmVYdX1QnPJzMxwk7S6O7fzNHtKPWV8vT3Q&oe=62A8DD3C',
  // 'https://scontent.fjhb2-1.fna.fbcdn.net/v/t1.6435-9/75223851_143582860370690_965873634461614080_n.jpg?_nc_cat=107&ccb=1-6&_nc_sid=a26aad&_nc_ohc=9XgkxxrxzDUAX-Csmxu&_nc_ht=scontent.fjhb2-1.fna&oh=00_AT8zncGprCaNuV6TD1Aakdx7Xc-a3cWVWrnOat8FVoNxZQ&oe=62A769F9'
];

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
      items: imageSliders,
    );
  }
}

class CourtDesc extends StatefulWidget {
  const CourtDesc({Key? key}) : super(key: key);

  @override
  State<CourtDesc> createState() => _CourtDescState();
}

class _CourtDescState extends State<CourtDesc> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text("Court Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)
                  ),
                ),
                Text(
                  "RM 100.00/hour",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset("assets/court.png",
        ),
      ),
      const Text(
        "Court Flooring Type: PP Interlocking Tiles",
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
      ),
      Padding(
        padding: const EdgeInsets.all(0),
        child: Image.asset("assets/tiles.jpg",
        height: 250,
        width: 300,
        ),
      ),
      const SizedBox(height: 15.0)
    ]);
  }
}