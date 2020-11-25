import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const ComponentSize = 100.0;
const SPEED = 150.0;

class PresenteBomba extends SpriteComponent {
  Size dimensions;
  Random random = new Random();
  bool remove = false;

  PresenteBomba(this.dimensions)
      : super.square(ComponentSize, 'presente_bomba.png');

  @override
  void update(double t) {
    super.update(t);
    this.y += t * SPEED;
  }

  @override
  bool destroy() {
    return remove;
  }

  @override
  void resize(Size size) {
    var positionX = random.nextDouble();
    print(positionX);

    this.x = positionX * 300;
    this.y = 0;
  }
}
