class Category {
  String thumbnail;
  String name;
  String videos;

  Category({
    required this.name,
    required this.videos,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Scratch Garden',
    videos: "11",
    thumbnail: 'assets/images/1.jpeg',
  ),
  Category(
    name: 'Learning Mole',
    videos: "6",
    thumbnail: 'assets/images/2.jpeg',
  ),
  Category(
    name: 'ScratchJr Coding',
    videos: "4",
    thumbnail: 'assets/images/4.jpeg',
  ),
  Category(
    name: 'Kids For Code',
    videos: "4",
    thumbnail: 'assets/images/3.jpeg',
  ),
];
List<Category> shopList = [
  Category(
    name: 'Toy Store',
    videos: "247 EL hegaz St. Helioples",
    thumbnail: 'assets/images/s1.jpeg',
  ),
  Category(
    name: 'The joy of the toy',
    videos: "Mokkatam city, 9 street",
    thumbnail: 'assets/images/s5.jpeg',
  ), Category(
    name: 'Games Egypt',
    videos: "7 wadi el nile street",
    thumbnail: 'assets/images/s6.jpeg',
  ),
  Category(
    name: 'Toy house',
    videos: "3 Mossadek, ad dokki, giza",
    thumbnail: 'assets/images/s2.jpeg',
  ),
  Category(
    name: 'Bingo',
    videos: "Nasr city, 5 street",
    thumbnail: 'assets/images/s4.jpeg',
  ),
  Category(
    name: 'Toy house',
    videos: "Cairo festival city mall",
    thumbnail: 'assets/images/s3.jpeg',
  ),
];
