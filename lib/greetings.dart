String getGreetingFromScore(int score) {
  if (score < 20) {
    return greetingList[0];
  } else if (score < 50) {
    return greetingList[1];
  } else if (score < 100) {
    return greetingList[2];
  } else if (score < 150) {
    return greetingList[3];
  } else if (score < 200) {
    return greetingList[4];
  } else if (score < 250) {
    return greetingList[5];
  } else if (score < 300) {
    return greetingList[6];
  } else if (score < 500) {
    return greetingList[7];
  } else if (score < 1000) {
    return greetingList[8];
  } else {
    return greetingList[9];
  }
}

final greetingList = [
  "新年あけました。よい一年を。",
  "あけおめ！良い年にしてね。",
  "明けましておめでとう。今年も頑張って。",
  "新年のご挨拶。素晴らしい一年を！",
  "明けましておめでとうございます。今年も良い年でありますように。",
  "新年あけましておめでとうございます。皆さまの幸せを願っています。",
  "新年の幕開けに当たり、皆さまにとって素敵な年となりますよう心よりお祈り申し上げます。",
  "新春の候、皆様の健康と幸福を心よりお祈りしております。本年も宜しくお願い致します。",
  "新年の訪れを祝し、皆様の益々のご繁栄を心よりお祈り申し上げます。本年もどうぞ宜しくお願い致します。",
  "新春の輝かしい始まりにあたり、皆様のご健康と幸福、並びにご家族の皆様のご繁栄を心からお祈り申し上げます。本年も変わらぬお引き立てを賜りますよう、心よりお願い申し上げます。",
];
