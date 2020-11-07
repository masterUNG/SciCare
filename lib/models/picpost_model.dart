class PicPostModel {
  String dateTimePost;
  String detailPost;
  String idPost;
  String urlPicPost;

  PicPostModel(
      {this.dateTimePost, this.detailPost, this.idPost, this.urlPicPost});

  PicPostModel.fromJson(Map<String, dynamic> json) {
    dateTimePost = json['dateTimePost'];
    detailPost = json['detailPost'];
    idPost = json['idPost'];
    urlPicPost = json['urlPicPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTimePost'] = this.dateTimePost;
    data['detailPost'] = this.detailPost;
    data['idPost'] = this.idPost;
    data['urlPicPost'] = this.urlPicPost;
    return data;
  }
}
