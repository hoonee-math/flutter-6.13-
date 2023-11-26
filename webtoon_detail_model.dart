/* #6.12강 (ApiService) detail_screen에 들어갈 요소들의 api 받아오기 */

class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
