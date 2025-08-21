class NewsData {
  String bgImage;
  String icon; //affichage des details
  String name;
  String auteur; //affichage auteur
  String title;
  String date;
  //String logo;
  //String title
  num score;
  num download;
  num review;
  String description;
  List<String> image;

  NewsData(
    this.bgImage,
    this.icon,
    this.name,
    this.auteur,
    this.title,
    this.date,
    //this.logo,
    this.score,
    this.download,
    this.review,
    this.description,
    this.image,
  );

  // ignore: non_constant_identifier_names
  static List<NewsData> PopularNews() {
    return [
      NewsData(
        'assets/images/dechet4.jpg',
        'assets/images/dechet1.jpg',
        'Les océans suffoquent : la pollution plastique atteint des records',
        'DJiala nelson',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "Selon un rapport de Greenpeace publié en mai 2023, plus de 14 millions de tonnes de plastique sont déversées chaque année dans les océans, affectant gravement la faune marine. Des efforts mondiaux sont nécessaires pour endiguer cette crise.Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean2.webp',
        'assets/images/dechet1.jpg',
        'Chaleur océanique : des vagues marines inédites perturbent les écosystèmes",',
        'Moneze parfait',
        '',
        '12/05/2024',
        4.7,
        226,
        148,
        "Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/bouteille.jpeg',
        'assets/images/legend4.jpg',
        'Une bouteille à la mer : l’impact invisible de nos déchets plastiques',
        'Moneze parfait',
        '',
        '12/05/2024',
        4.7,
        226,
        148,
        "Rayan is a stranger to peril,but when a fateful sun world on the",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      /* NewsData(
        'assets/image/ocean.jpg',
        'assets/image/ocean2.webp',
        'Ori and The Forest',
        'Adventure',
        3,
        382,
        324,
        "Ori is a stranger to peril,but when a ",
        [
          'assets/images/ori2.jpg',
          'assets/images/ori3.jpg',
          'assets/images/ori4.jpg',
        ],
      ),*/
      NewsData(
        'assets/image/ocean2.webp',
        'assets/image/bouteille.jpeg',
        'Une bouteille à la mer : l’impact invisible de nos déchets plastiques',
        'Moneze parfait',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      /*NewsData(
        'assets/image/ocean.jpg',
        'assets/image/ocean2.webp',
        'Ori and The Forest',
        'Adventure',
        4.8,
        382,
        324,
        "Ori is a stranger to peril,but when a ",
        [
          'assets/images/ori2.jpg',
          'assets/images/ori3.jpg',
          'assets/images/ori4.jpg',
        ],
      ),*/
    ];
  }

  // ignore: non_constant_identifier_names
  static List<NewsData> NewestNews() {
    return [
      NewsData(
        'assets/image/ocean2.webp',
        'assets/image/ocean2.webp',
        'Chaleur océanique : des vagues marines ',
        'NELSON',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean.jpg',
        'assets/image/ocean2.webp',
        'Une bouteille à la mer : l’impact invisible',
        'NELSON',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "Une étude de lUniversité de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean2.webp',
        'assets/image/ocean.jpg',
        'Une bouteille à la mer : l’impact invisible',
        'NELSON',
        '',
        '12/05/2024',
        4.7,
        226,
        148,
        "Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean2.webp',
        'assets/image/bouteille.jpeg',
        'Les océans suffoquent : la pollution plastique',
        'NELSON',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "Des chercheurs camerounais alertent sur l’accumulation de bouteilles plastiques dans les rivières du pays. Ces déchets, mal collectés, finissent souvent dans l’océan Atlantique, menaçant les ressources halieutiques locales.Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes. ",
        [
          'assets/images/dechet6.jpeg',
          'assets/images/dechet2.jpeg',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean.jpg',
        'assets/image/ocean2.webp',
        'Une bouteille à la mer : l’impact',
        'NELSON',
        '',
        '12/05/2024',
        4.8,
        382,
        324,
        "OUne étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.i ",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet4.jpg',
        ],
      ),
      NewsData(
        'assets/image/ocean.jpg',
        'assets/image/ocean2.webp',
        'Les océans suffoquent : la pollution plastique',
        'NELSON',
        '',
        '12/05/2024',
        3,
        382,
        324,
        "Une étude de l’Université de Southampton a révélé que la température moyenne des océans a augmenté de 0,8°C depuis 1990. Cela perturbe la reproduction de nombreuses espèces et augmente la fréquence des événements climatiques extrêmes.",
        [
          'assets/images/dechet1.jpg',
          'assets/images/dechet3.webp',
          'assets/images/dechet6.jpeg',
        ],
      ),
    ];
  }
}
