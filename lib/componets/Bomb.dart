import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:game_base/componets/Presente.dart';
import 'package:game_base/componets/PresenteBomba.dart';
import 'package:game_base/main.dart';

const SPEED = 200.0;

class Bomb extends SpriteComponent {
  Offset initialDirection = new Offset(200, 300);
  List<Presente> presenteList;
  List<PresenteBomba> presenteBList;
  bool destroyBomb = false;

  Bomb(this.initialDirection, this.presenteList)
      : super.square(60.0, 'papainoel.png');

  @override
  void update(double t) {
    super.update(t);
    this.y -= t * SPEED;

    if (presenteList.isNotEmpty) {
      presenteList.forEach((presente) {
        if (!presente.remove) {
          bool remove =
              this.toRect().contains(presente.toRect().bottomCenter) ||
                  this.toRect().contains(presente.toRect().bottomLeft) ||
                  this.toRect().contains(presente.toRect().bottomRight);
          if (remove) {
            presente.remove = true;
            destroyBomb = true;
            points += 1;
          }
        }
      });
    } else if (presenteBList.isNotEmpty) {
      presenteBList.forEach((presenteB) {
        if (!presenteB.remove) {
          bool remove =
              this.toRect().contains(presenteB.toRect().bottomCenter) ||
                  this.toRect().contains(presenteB.toRect().bottomLeft) ||
                  this.toRect().contains(presenteB.toRect().bottomRight);
          if (remove) {
            presenteB.remove = true;
            destroyBomb = true;
            points -= 1;
          }
        }
      });
    }
  }

  @override
  bool destroy() {
    return destroyBomb;
  }

  @override
  void resize(Size size) {
    this.x = this.initialDirection.dx - 15;
    this.y = size.height - 80;
  }
}
