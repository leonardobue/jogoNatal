import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_base/componets/Treno.dart';

import 'componets/Bomb.dart';
import 'componets/Presente.dart';
import 'componets/PresenteBomba.dart';
import 'package:flame/gestures.dart';

var game;
var points = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.images.loadAll(
      ['presente_bomba.png', 'presente.png', 'treno.png', 'papainoel.png']);
  var dimensions = await Flame.util.initialDimensions();
  game = JogoBase(dimensions);

  runApp(game.widget);
}

PresenteBomba presenteB;
Presente presente;
bool isTrenoExist = false;
List<Presente> presenteList;
List<PresenteBomba> presenteBList;

class JogoBase extends BaseGame with TapDetector {
  Size dimensions;
  Treno treno;

  JogoBase(this.dimensions) {
    treno = new Treno();
    presenteList = <Presente>[];
    presenteBList = <PresenteBomba>[];
  }

  double creationTimer = 0.0;
  bool isPresente = false;
  @override
  void update(double t) {
    if (!isTrenoExist) {
      add(treno);
      isTrenoExist = true;
    }

    creationTimer += t;
    if (creationTimer >= 1) {
      creationTimer = 0.0;

      if (isPresente) {
        isPresente = false;
        presenteB = new PresenteBomba(dimensions);
        add(presenteB);
      } else {
        presente = new Presente(dimensions);
        presenteList.add(presente);
        add(presente);
        isPresente = true;
      }
    }
    print('Placar: $points');
    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTapDown(TapDownDetails details) {
    print(
        "Tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
    treno.position = details.globalPosition.dx;
    disparo(details.globalPosition);
  }

  @override
  void onTapUp(TapUpDetails details) {
    print(
        "Tap up on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }

  void disparo(Offset position) {
    Bomb bomb = new Bomb(position, presenteList);
    add(bomb);
  }
}
