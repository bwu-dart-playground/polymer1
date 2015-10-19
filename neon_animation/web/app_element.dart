@HtmlImport('app_element.html')
library neon_animation.app_element;

import 'package:web_components/web_components.dart'
    show CustomElementProxy, CustomElementProxyMixin, HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/neon_animatable_behavior.dart';
import 'package:polymer_elements/neon_animation_runner_behavior.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/neon_animation/animations/fade_in_animation.dart';
import 'package:polymer_elements/neon_animation/animations/transform_animation.dart';

/// [PaperInput]
@PolymerRegister('app-element')
class AppElement extends PolymerElement
    with PolymerBase, NeonAnimatableBehavior, NeonAnimationRunnerBehavior {
  AppElement.created() : super.created();

  @property String rotateFrom = '10';
  @property String rotateTo = '100';

  void ready() {
    var squareNode = Polymer.dom(root).querySelector('.square');
    animationConfig = {
      'entry': [
        {
          'name': 'transform-animation',
          'transformFrom': 'scale(.9) translateY(100px)',
          'transformTo': 'scale(1) translateY(0)',
          'node': squareNode
        },
        {'name': 'fade-in-animation', 'node': squareNode}
      ]
    };

    play();
  }

  @reflectable
  void animateMe([_, __]) {
    play();
  }

  void play() {
    updateAnimation();
    playAnimation('entry', null);
  }

  void updateAnimation() {
    var entryAnimation = animationConfig['entry'][0];

    if (rotateFrom != null && rotateFrom != 0) {
      entryAnimation['transformFrom'] = (entryAnimation['transformFrom']
          as String).replaceFirst(new RegExp(r'rotate\(.*\)'), '');
      entryAnimation['transformFrom'] += ' rotate(${rotateFrom}deg)';
    }

    if (rotateTo != null && rotateTo != 0) {
      entryAnimation['transformTo'] = (entryAnimation['transformTo'] as String)
          .replaceFirst(new RegExp(r'rotate\(.*\)'), '');
      entryAnimation['transformTo'] += ' rotate(${rotateTo}deg)';
    }
  }
}
