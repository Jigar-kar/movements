import 'package:equatable/equatable.dart';

class Slide extends Equatable {
  final String name, img, credit, photo, video, edit;

  const Slide(
      {required this.name,
      required this.img,
      required this.credit,
      required this.photo,
      required this.video,
      required this.edit});

  @override
  // TODO: implement props
  List<Object?> get props => [name, img, credit, photo, video, edit];

  static List<Slide> catgories = [
    Slide(
        name: "Wedding Shoot",
        img: "asset/imges/Slider1.jpg",
        credit: "Credit",
        photo: "Photographer - Jack",
        video: "VideoGrapher - Dinesh",
        edit: "Editer - Akshay"),
    Slide(
        name: "Pre-Wedding",
        img: "asset/imges/Slider2.jpg",
        credit: "Credit",
        photo: "Photographer - Jack",
        video: "VideoGrapher - Dinesh",
        edit: "Editer - Akshay"),
    Slide(
        name: "Birthday Shoot",
        img: "asset/imges/Slider3.jpg",
        credit: "Credit",
        photo: "Photographer - Jack",
        video: "VideoGrapher - Dinesh",
        edit: "Editer - Akshay"),
    Slide(
        name: "Aniversary Shoot",
        img: "asset/imges/Slider4.jpg",
        credit: "Credit",
        photo: "Photographer - Jack",
        video: "VideoGrapher - Dinesh",
        edit: "Editer - Akshay"),
  ];
}
