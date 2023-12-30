import 'dart:math';

import 'package:flame/game.dart';

class Fish {
  final String nameShort;
  final String name;
  final String img;
  final String description;
  final List<List<Vector2>>? tapAreaList;
  final bool isKoi;

  const Fish({
    required this.nameShort,
    required this.name,
    required this.img,
    required this.description,
    required this.isKoi,
    this.tapAreaList,
  });

  static List<Fish> fishList = [
    Fish.koi,
    Fish.funa,
    Fish.nishikiGois,
    Fish.ayu,
    Fish.blackbass,
    Fish.tanago,
    Fish.goldenKoi
  ];

  static Fish getRandomFish() {
    final random = Random();
    return fishList[random.nextInt(fishList.length)];
  }

  static Fish koi = Fish(
    nameShort: 'コイ',
    name: 'コイ: Cyprinus carpio',
    img: 'fish/koi.png',
    description: "比較的流れが緩やかな川や池、沼、湖、用水路などにも広く生息する大型の淡水魚。",
    isKoi: true,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.5, 0.8),
        Vector2(0.95, 0.5),
        Vector2(0.45, 0.2),
      ],
      [
        Vector2(0.7, 0.5),
        Vector2(0.95, 0.7),
        Vector2(0.95, 0.2),
      ],
    ],
  );

  static Fish nishikiGois = Fish(
    nameShort: '錦鯉',
    name: '錦鯉: Cyprinus carpio',
    img: 'fish/nishiki-goi.png',
    description: '観賞魚用に改良したコイの品種の総称。',
    isKoi: true,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.5, 0.8),
        Vector2(0.95, 0.5),
        Vector2(0.45, 0.2),
      ],
      [
        Vector2(0.7, 0.5),
        Vector2(0.95, 0.7),
        Vector2(0.95, 0.2),
      ],
    ],
  );

  static Fish goldenKoi = Fish(
    nameShort: '黄金',
    name: '黄金: Cyprinus carpio',
    img: 'fish/golden-koi.png',
    description: '無地の錦鯉。色には赤、橙、プラチナ、黄、クリーム色など。',
    isKoi: true,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.5, 0.8),
        Vector2(0.95, 0.5),
        Vector2(0.45, 0.2),
      ],
      [
        Vector2(0.7, 0.5),
        Vector2(0.95, 0.7),
        Vector2(0.95, 0.2),
      ],
    ],
  );

  static Fish funa = Fish(
    nameShort: 'フナ',
    name: 'フナ: Carassius carassius',
    img: 'fish/funa.png',
    description: '河川、湖沼、ため池、用水路など、水の流れのゆるい淡水域などに生息。',
    isKoi: false,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.45, 0.82),
        Vector2(0.7, 0.7),
        Vector2(0.95, 0.5),
        Vector2(0.48, 0.18),
        Vector2(0.3, 0.25)
      ],
      [
        Vector2(0.5, 0.5),
        Vector2(0.95, 0.7),
        Vector2(0.95, 0.3),
      ],
    ],
  );

  static Fish ayu = Fish(
    nameShort: 'アユ',
    name: 'アユ: Plecoglossus altivelis',
    img: 'fish/ayu.png',
    description: '川や海などを回遊する魚である。「清流の女王」とも呼ばれている。',
    isKoi: false,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.2, 0.6),
        Vector2(0.8, 0.6),
        Vector2(0.95, 0.5),
        Vector2(0.55, 0.27),
        Vector2(0.2, 0.35),
      ],
      [
        Vector2(0.7, 0.5),
        Vector2(0.95, 0.65),
        Vector2(0.95, 0.35),
      ],
    ],
  );

  static Fish blackbass = Fish(
    nameShort: 'ブラックバス',
    name: 'ブラックバス: Micropterus dolomieu',
    img: 'fish/blackbass.png',
    description: '体の真ん中あたりに薄く黒い線がある、だいたいが緑などで統一されている。',
    isKoi: false,
    tapAreaList: [
      [
        Vector2(0, 0.5),
        Vector2(0.35, 0.75),
        Vector2(0.65, 0.75),
        Vector2(0.95, 0.5),
        Vector2(0.6, 0.2),
        Vector2(0.4, 0.2)
      ],
      [
        Vector2(0.7, 0.5),
        Vector2(0.95, 0.65),
        Vector2(0.95, 0.3),
      ],
    ],
  );

  static Fish tanago = Fish(
    nameShort: 'タナゴ',
    name: 'タナゴ: Acheilognathus melanogaster',
    img: 'fish/tanago.png',
    description: 'コイ目コイ科タナゴ亜科タナゴ属に分類される淡水魚の一種。',
    isKoi: false,
    tapAreaList: [
      [
        Vector2(0, 0.55),
        Vector2(0.55, 0.8),
        Vector2(0.9, 0.5),
        Vector2(0.5, 0.15),
      ],
      [
        Vector2(0.65, 0.5),
        Vector2(0.92, 0.7),
        Vector2(0.92, 0.33),
      ],
    ],
  );
}
