class Landing {
  final String top;
  final String title;
  final String desc;
  final String image;

  Landing({
    this.top = 'G-Chat',
    required this.title,
    required this.desc,
    required this.image,
  });
}

List<Landing> landingContents = [
  Landing(
    title: 'Chat on the Go!',
    desc:
        'Maintaining good relationship should\n be the primary focus of everyone.',
    image: 'assets/images/chatgo.png',
  ),
  Landing(
    title: 'Discuss what matters',
    desc: '24/7 with G-Chat\n  you can talk what matters. Chat now!',
    image: 'assets/images/discussmat.png',
  ),
  Landing(
    title: 'Chat seamlessly',
    desc: 'With amazing inbuilt tools you \n can chat anywhere, anytime.',
    image: 'assets/images/chatseam.png',
  )
];
