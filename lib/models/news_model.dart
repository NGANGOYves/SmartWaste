// 📄 news_model.dart — Modèle pour chaque article d’actualité

class NewsModel {
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final DateTime date;

  NewsModel({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
    required this.date,
  });

  static List<NewsModel> allNews() => [
    // NewsModel(
    //   title:
    //       'Gestion des déchets urbains au Cameroun : vers une réforme structurelle',
    //   description:
    //       'La question de l’insalubrité dans les villes camerounaises se pose avec acuité. Ces assises apparaissent comme une opportunité de repenser en profondeur la politique nationale de gestion des déchets.',
    //   link:
    //       'https://ajafe.info/gestion-des-dechets-urbains-au-cameroun-vers-une-reforme-structurelle-du-systeme-actuel/',
    //   imageUrl: 'assets/images/dechet1.jpeg',
    //   date: DateTime(2025, 6, 10),
    // ),
    NewsModel(
      title:
          'Limiter les décharges anarchiques à Yaoundé par le tri à la source',
      description:
          'Environ 96 % des producteurs n’utilisent qu’une seule poubelle. La majorité ignore les techniques de tri. Des mesures comme la pré-collecte porte-à-porte sont envisagées.',
      link: 'https://revue-set.fr/article/view/8142',
      imageUrl: 'assets/images/dechet2.jpeg',
      date: DateTime(2025, 6, 12),
    ),
    NewsModel(
      title: 'Crise des ordures au Cameroun',
      description:
          'Face aux difficultés de collecte, l’élimination doit être le dernier recours. La réduction des déchets en amont est essentielle.',
      link:
          'https://datacameroon.com/crise-des-ordures-au-cameroun-depuis-2016-jen-appelle-a-une-reduction-des-dechets-de-nos-menages/',
      imageUrl: 'assets/images/dechet3.jpeg',
      date: DateTime(2025, 6, 15),
    ),
    // NewsModel(
    //   title: 'Le gouvernement à la recherche de solutions contre l’insalubrité',
    //   description:
    //       'Des tas d’ordures jonchent les trottoirs de Yaoundé. Le gouvernement multiplie les efforts pour endiguer le phénomène.',
    //   link:
    //       'https://album-social.com/2025/04/17/cameroun-solutions-contre-insalubrite/',
    //   imageUrl: 'assets/images/dechet4.jpeg',
    //   date: DateTime(2025, 6, 17),
    // ),
    // NewsModel(
    //   title: 'Salubrité urbaine : L’initiative de Douala',
    //   description:
    //       'Le programme « Douala Clean City! » est désormais opérationnel, visant à rendre la ville plus propre et durable.',
    //   link:
    //       'https://www.formes.ca/territoire/articles/salubrite-urbaine-l-initiative-de-douala-cameroun',
    //   imageUrl: 'assets/images/dechet5.jpeg',
    //   date: DateTime(2025, 6, 19),
    // ),
    NewsModel(
      title: 'Valorisation des déchets au Cameroun : pistes à explorer',
      description:
          'L’économie circulaire propose de transformer les déchets en ressources pour limiter le gaspillage et préserver l’environnement.',
      link:
          'https://leconomie.info/cameroun-quelques-pistes-a-explorer-pour-valoriser-les-dechets/',
      imageUrl: 'assets/images/dechet6.jpeg',
      date: DateTime(2025, 6, 20),
    ),
    NewsModel(
      title: 'LES DÉCHETS : cette mine d’or qui salit nos rues',
      description:
          'Du charbon bio fabriqué à partir de déchets… une solution innovante pour une problématique ancienne.',
      link: 'https://www.greenpeace.org/africa/fr/les-blogs/51887/51887/',
      imageUrl: 'assets/images/dechet7.jpeg',
      date: DateTime(2025, 6, 22),
    ),
    // NewsModel(
    //   title: 'Comment optimiser la gestion des déchets du quotidien ?',
    //   description:
    //       'Chaque citoyen peut agir pour un Cameroun plus propre grâce à des gestes simples et concrets, depuis son foyer.',
    //   link:
    //       'https://eracameroun.org/comment-optimiser-la-gestion-de-vos-dechets-du-quotidien-et-oeuvrer-a-lassainissement-du-cameroun/',
    //   imageUrl: 'assets/images/dechet8.jpeg',
    //   date: DateTime(2025, 6, 24),
    // ),
    NewsModel(
      title:
          'Le Cameroun réfléchit à une stratégie de gestion pérenne des ordures',
      description:
          'Une nouvelle initiative du ministère vise à mieux structurer la gestion des déchets ménagers au Cameroun.',
      link:
          'https://www.stopblablacam.com/societe/2405-12396-le-cameroun-reflechit-a-une-strategie-de-gestion-perenne-des-ordures-menageres',
      imageUrl: 'assets/images/dechet9.jpeg',
      date: DateTime(2025, 6, 26),
    ),
    // NewsModel(
    //   title: 'Gestion des déchets : un levier pour un développement durable',
    //   description:
    //       'La propreté urbaine devient un pilier central du développement durable et inclusif au Cameroun.',
    //   link:
    //       'https://laplumedelaigle.com/gestion-des-dechets-au-cameroun-un-levier-crucial-pour-un-developpement-durable-et-inclusif/',
    //   imageUrl: 'assets/images/dechet10.jpeg',
    //   date: DateTime(2025, 6, 28),
    // ),
    // NewsModel(
    //   title: 'Un Engagement Citoyen : Le Tri Des Déchets',
    //   description:
    //       'Des actions de sensibilisation illustrent les dangers liés aux déchets, notamment ceux relâchés en mer qui menacent la biodiversité.',
    //   link:
    //       'https://globoafrique.com/un-engagement-citoyen-le-tri-des-dechets/',
    //   imageUrl: 'assets/images/dechet11.jpeg',
    //   date: DateTime(2025, 6, 30),
    // ),
  ];
}
