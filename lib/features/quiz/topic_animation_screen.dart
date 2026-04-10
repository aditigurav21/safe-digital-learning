// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  topic_animation_screen.dart
//  Drop this file into:  lib/features/quiz/topic_animation_screen.dart
//
//  HOW IT WORKS
//  ─────────────
//  • Each topic is a list of AnimScene objects.
//  • Every scene has: tutor speech bubble, student reaction, and an
//    "illustration" drawn with pure Flutter widgets (no images, no video).
//  • Scenes auto-advance with a timer that respects a reading-speed delay.
//  • The user can also tap "Next →" to go faster.
//  • After the last scene, an "onFinished" callback launches the quiz.
//
//  NO NEW pub.dev packages needed — uses only Flutter's built-in animations.
// ─────────────────────────────────────────────────────────────────────────────

// ── Enum used by LevelData.animationKey ──────────────────────────────────────
enum AnimationTopic { banking, phishing, socialMedia, government,fakeWebsite, deepfake}

// ── Public entry screen ───────────────────────────────────────────────────────
class TopicAnimationScreen extends StatefulWidget {
  final AnimationTopic topicKey;
  final Color levelColor;
  final VoidCallback onFinished;

  const TopicAnimationScreen({
    super.key,
    required this.topicKey,
    required this.levelColor,
    required this.onFinished,
  });

  @override
  State<TopicAnimationScreen> createState() => _TopicAnimationScreenState();
}

class _TopicAnimationScreenState extends State<TopicAnimationScreen>
    with TickerProviderStateMixin {
  // scene index
  int _scene = 0;

  // controllers
  late AnimationController _fadeCtrl;   // whole scene fade
  late AnimationController _tutorCtrl;  // tutor bubble slide-in
  late AnimationController _studentCtrl;// student reaction pop
  late AnimationController _illustCtrl; // illustration entrance
  late AnimationController _glowCtrl;   // looping glow on illustration

  late Animation<double> _fadeAnim;
  late Animation<Offset> _tutorSlide;
  late Animation<double> _studentScale;
  late Animation<double> _illustFade;
  late Animation<double> _glowAnim;

  List<AnimScene> get _scenes =>
      AnimSceneLibrary.scenesFor(widget.topicKey, widget.levelColor);

  @override
  void initState() {
    super.initState();
    _initControllers();
    _playScene();
  }

  void _initControllers() {
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _tutorCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _studentCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _illustCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: true);

    _fadeAnim =
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _tutorSlide =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: _tutorCtrl, curve: Curves.easeOutCubic));
    _studentScale =
        CurvedAnimation(parent: _studentCtrl, curve: Curves.elasticOut);
    _illustFade =
        CurvedAnimation(parent: _illustCtrl, curve: Curves.easeOutBack);
    _glowAnim =
        Tween<double>(begin: 0.3, end: 1.0)
            .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
  }

  Future<void> _playScene() async {
    // reset all
    _fadeCtrl.reset();
    _tutorCtrl.reset();
    _studentCtrl.reset();
    _illustCtrl.reset();

    await _fadeCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _illustCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _tutorCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 350));
    _studentCtrl.forward();
  }

  Future<void> _nextScene() async {
    if (_scene >= _scenes.length - 1) {
      widget.onFinished();
      return;
    }
    await _fadeCtrl.reverse();
    setState(() => _scene++);
    _playScene();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _tutorCtrl.dispose();
    _studentCtrl.dispose();
    _illustCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scene = _scenes[_scene];
    final isLast = _scene == _scenes.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(scene),
            _buildProgressDots(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      // ── Illustration stage ──────────────────────────────
                      _IllustrationStage(
                        scene: scene,
                        illustFade: _illustFade,
                        glowAnim: _glowAnim,
                        levelColor: widget.levelColor,
                      ),
                      const SizedBox(height: 16),

                      // ── Classroom row: tutor + student ──────────────────
                      _ClassroomRow(
                        scene: scene,
                        tutorSlide: _tutorSlide,
                        studentScale: _studentScale,
                        levelColor: widget.levelColor,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bottom navigation ──────────────────────────────────────────
            _buildBottomBar(isLast),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(AnimScene scene) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE8EAF0))),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E5EE)),
              ),
              child: const Icon(Icons.close, size: 20, color: Color(0xFF8B95A5)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎬 Watch & Learn',
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.levelColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  scene.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2340),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: widget.levelColor.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: widget.levelColor.withValues(alpha:0.3)),
            ),
            child: Text(
              '${_scene + 1}/${_scenes.length}',
              style: TextStyle(
                  fontSize: 13,
                  color: widget.levelColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_scenes.length, (i) {
          final active = i == _scene;
          final done = i < _scene;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: active ? 26 : 9,
            height: 9,
            decoration: BoxDecoration(
              color: done || active
                  ? widget.levelColor
                  : const Color(0xFFDDE2EE),
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomBar(bool isLast) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8EAF0))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _nextScene,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.levelColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            shadowColor: widget.levelColor.withValues(alpha:0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLast ? '🚀  Start Quiz' : 'Next  →',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (isLast) ...[
                const SizedBox(width: 6),
                const Icon(Icons.quiz_rounded, color: Colors.white, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CLASSROOM ROW  — tutor on left, student on right
// ─────────────────────────────────────────────────────────────────────────────
class _ClassroomRow extends StatelessWidget {
  final AnimScene scene;
  final Animation<Offset> tutorSlide;
  final Animation<double> studentScale;
  final Color levelColor;

  const _ClassroomRow({
    required this.scene,
    required this.tutorSlide,
    required this.studentScale,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ── Tutor column ────────────────────────────────────────────────────
        Expanded(
          flex: 55,
          child: SlideTransition(
            position: tutorSlide,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Speech bubble
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(4),
                    ),
                    border: Border.all(color: levelColor.withValues(alpha:0.35), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: levelColor.withValues(alpha:0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: levelColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('👩‍🏫 Meera',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        scene.tutorSays,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF1A2340),
                          height: 1.55,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                // Tutor character (drawn with widgets)
                _TutorCharacter(levelColor: levelColor),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // ── Student column ──────────────────────────────────────────────────
        Expanded(
          flex: 40,
          child: ScaleTransition(
            scale: studentScale,
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Student reaction bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(4),
                    ),
                    border:
                    Border.all(color: const Color(0xFFCDD5F0), width: 1.5),
                  ),
                  child: Text(
                    scene.studentReacts,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF3D4A6B),
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6),
                // Student character
                _StudentCharacter(emotion: scene.studentEmotion),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Tutor character (teacher avatar drawn with widgets) ──────────────────────
class _TutorCharacter extends StatelessWidget {
  final Color levelColor;
  const _TutorCharacter({required this.levelColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Body
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              width: 52,
              height: 60,
              decoration: BoxDecoration(
                color: levelColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          // Collar/buttons
          Positioned(
            bottom: 30,
            left: 29,
            child: Container(
              width: 6,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.4),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          // Head
          Positioned(
            bottom: 52,
            left: 10,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFFFDBAC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE8B98A), width: 1.5),
              ),
              child: const Center(
                child: Text('👩‍🏫', style: TextStyle(fontSize: 26)),
              ),
            ),
          ),
          // Pointer/stick
          Positioned(
            bottom: 30,
            left: 60,
            child: _AnimatedPointer(color: levelColor),
          ),
        ],
      ),
    );
  }
}

// ── Animated pointer the tutor holds ────────────────────────────────────────
class _AnimatedPointer extends StatefulWidget {
  final Color color;
  const _AnimatedPointer({required this.color});

  @override
  State<_AnimatedPointer> createState() => _AnimatedPointerState();
}

class _AnimatedPointerState extends State<_AnimatedPointer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _rotAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _rotAnim = Tween<double>(begin: -0.15, end: 0.15)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotAnim,
      builder: (_, __) => Transform.rotate(
        angle: _rotAnim.value,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 5,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.color, widget.color.withValues(alpha:0.5)],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

// ── Student character ────────────────────────────────────────────────────────
class _StudentCharacter extends StatelessWidget {
  final StudentEmotion emotion;
  const _StudentCharacter({required this.emotion});

  String get _face {
    switch (emotion) {
      case StudentEmotion.confused:
        return '🤔';
      case StudentEmotion.shocked:
        return '😱';
      case StudentEmotion.nodding:
        return '😊';
      case StudentEmotion.happy:
        return '🙌';
      case StudentEmotion.worried:
        return '😰';
      case StudentEmotion.proud:
        return '💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Body
          Positioned(
            bottom: 0,
            child: Container(
              width: 44,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF5C7AE8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          // Head
          Positioned(
            bottom: 42,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFFDBAC),
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color(0xFFE8B98A), width: 1.5),
              ),
              child: Center(
                child: Text(_face, style: const TextStyle(fontSize: 22)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ILLUSTRATION STAGE  — the "whiteboard" / visual scene above the classroom
// ─────────────────────────────────────────────────────────────────────────────
class _IllustrationStage extends StatelessWidget {
  final AnimScene scene;
  final Animation<double> illustFade;
  final Animation<double> glowAnim;
  final Color levelColor;

  const _IllustrationStage({
    required this.scene,
    required this.illustFade,
    required this.glowAnim,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: illustFade,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 180, maxHeight: 240),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E5EE), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: levelColor.withValues(alpha:0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Subtle grid background (whiteboard feel)
            Positioned.fill(child: _GridBackground()),
            // Actual scene illustration
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: scene.illustration(glowAnim, levelColor),
              ),
            ),
            // Topic pill top-right
            Positioned(
              top: 10,
              right: 10,
              child: AnimatedBuilder(
                animation: glowAnim,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                    levelColor.withValues(alpha:0.1 + glowAnim.value * 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: levelColor.withValues(alpha:0.4)),
                  ),
                  child: Text(
                    scene.illustrationLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: levelColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Dot-grid whiteboard background ──────────────────────────────────────────
class _GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DotGridPainter());
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDE4F5)
      ..strokeWidth = 1;
    const spacing = 18.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
enum StudentEmotion { confused, shocked, nodding, happy, worried, proud }

class AnimScene {
  final String title;
  final String tutorSays;
  final String studentReacts;
  final StudentEmotion studentEmotion;
  final String illustrationLabel;
  // returns the widget drawn on the whiteboard
  final Widget Function(Animation<double> glow, Color accent) illustration;

  const AnimScene({
    required this.title,
    required this.tutorSays,
    required this.studentReacts,
    required this.studentEmotion,
    required this.illustrationLabel,
    required this.illustration,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  SCENE LIBRARY  — one set of scenes per AnimationTopic
// ─────────────────────────────────────────────────────────────────────────────
class AnimSceneLibrary {
  static List<AnimScene> scenesFor(AnimationTopic topic, Color accent) {
    switch (topic) {
      case AnimationTopic.banking:
        return _bankingScenes(accent);
      case AnimationTopic.phishing:
        return _phishingScenes(accent);
      case AnimationTopic.socialMedia:
        return _socialMediaScenes(accent);
      case AnimationTopic.government:
        return _governmentScenes(accent);
      case AnimationTopic.deepfake:
        return _deepfakeScenes(accent);
      case AnimationTopic.fakeWebsite:
        return _deepfakeScenes(accent);
    }
  }

  // ── BANKING / OTP SCENES ──────────────────────────────────────────────────
  static List<AnimScene> _bankingScenes(Color accent) => [
    AnimScene(
      title: 'What is an OTP?',
      tutorSays:
      'Namaste! I am Meera, your safety guide. 🙏\n\nToday we learn about OTPs — the secret codes your bank sends you. An OTP is a 6-digit number that lasts only 2 minutes!',
      studentReacts: 'OTP? I get those on my phone!',
      studentEmotion: StudentEmotion.confused,
      illustrationLabel: '🔐 OTP Explained',
      illustration: (glow, accent) => _OtpIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'The Fake Bank Call',
      tutorSays:
      'A fraudster calls you. They say: "I am from the bank. Your account is blocked. Share your OTP to unblock it NOW!"\n\n⚠️ STOP. Real banks NEVER ask for your OTP on a call.',
      studentReacts: 'Oh no! That sounds scary!',
      studentEmotion: StudentEmotion.shocked,
      illustrationLabel: '📵 Scam Call',
      illustration: (glow, accent) => _ScamCallIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Your OTP = Your Money',
      tutorSays:
      'Think of your OTP as the key to your safe. If you give that key to a stranger — they take everything inside.\n\nHang up the call immediately. Then call your bank yourself using the number on the back of your card.',
      studentReacts: 'I will never share my OTP! 🔒',
      studentEmotion: StudentEmotion.nodding,
      illustrationLabel: '🔑 Keep It Safe',
      illustration: (glow, accent) => _SafeKeyIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Strong Passwords',
      tutorSays:
      'A strong password has LETTERS + NUMBERS + SYMBOLS.\n\n❌ Weak: "Ram1960" or "1234"\n✅ Strong: "Blue@Sky75"\n\nNever use your birthday or name as a password!',
      studentReacts: 'I\'ll change my password today! 💪',
      studentEmotion: StudentEmotion.proud,
      illustrationLabel: '💪 Strong vs Weak',
      illustration: (glow, accent) => _PasswordIllustration(glow: glow, accent: accent),
    ),
  ];

  // ── PHISHING SCENES ───────────────────────────────────────────────────────
  static List<AnimScene> _phishingScenes(Color accent) => [
    AnimScene(
      title: 'What is Phishing?',
      tutorSays:
      'Phishing is like fishing — but the fraudster is fishing for YOUR information!\n\nThey send fake messages pretending to be your bank, post office, or government — to trick you into giving your details.',
      studentReacts: 'So they pretend to be someone else?',
      studentEmotion: StudentEmotion.confused,
      illustrationLabel: '🎣 Phishing Hook',
      illustration: (glow, accent) => _PhishingHookIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Spot a Fake SMS',
      tutorSays:
      'A real bank SMS comes from a code like "AD-SBIBNK". A fake SMS comes from a mobile number like "+91-99XXXXXXXX".\n\nAlso check: Does it ask you to click a link? Does it create URGENCY? These are red flags!',
      studentReacts: 'I\'ll check the sender carefully!',
      studentEmotion: StudentEmotion.nodding,
      illustrationLabel: '📱 Real vs Fake SMS',
      illustration: (glow, accent) => _SmsCompareIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Never Click Unknown Links',
      tutorSays:
      'A fake link looks almost real:\n• sbi-secure.com ❌\n• onlinesbi.sbi ✅ (real)\n\nWhen in doubt — DO NOT CLICK. Open your bank app directly from your phone.',
      studentReacts: 'The fake link looks so real! 😱',
      studentEmotion: StudentEmotion.shocked,
      illustrationLabel: '🔗 Fake vs Real Link',
      illustration: (glow, accent) => _LinkCompareIllustration(glow: glow, accent: accent),
    ),
  ];

  // ── SOCIAL MEDIA SCENES ───────────────────────────────────────────────────
  static List<AnimScene> _socialMediaScenes(Color accent) => [
    AnimScene(
      title: 'Oversharing Online',
      tutorSays:
      'When you post your full birthday, phone number, or home address on Facebook — strangers can see it!\n\nFraudsters collect these details to guess your passwords or trick your family.',
      studentReacts: 'I never thought about that!',
      studentEmotion: StudentEmotion.confused,
      illustrationLabel: '🌐 What You Share',
      illustration: (glow, accent) => _OvershareIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Fake Friend Requests',
      tutorSays:
      'A stranger sends you a friend request. Their profile looks real — but it is FAKE.\n\nOnce they are your "friend", they can see your photos, family details, and send you scam messages.',
      studentReacts: 'I once accepted a strange request 😰',
      studentEmotion: StudentEmotion.worried,
      illustrationLabel: '👤 Fake Profile',
      illustration: (glow, accent) => _FakeProfileIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Privacy Settings',
      tutorSays:
      'Go to Settings → Privacy on Facebook or WhatsApp.\n\nSet "Who can see my posts?" to FRIENDS ONLY.\n\nNever make your phone number or address public!',
      studentReacts: 'I\'ll check my privacy settings now! 🙌',
      studentEmotion: StudentEmotion.happy,
      illustrationLabel: '🔒 Privacy Settings',
      illustration: (glow, accent) => _PrivacySettingsIllustration(glow: glow, accent: accent),
    ),
  ];

  // ── GOVERNMENT SCENES ─────────────────────────────────────────────────────
  static List<AnimScene> _governmentScenes(Color accent) => [
    AnimScene(
      title: 'Fake Government Calls',
      tutorSays:
      'Fraudsters pretend to be from TRAI, Income Tax, CBI, or EPFO.\n\nThey say: "Your SIM will be blocked in 2 hours!" or "You owe tax — pay now or be arrested!"\n\nThis is ALWAYS a scam.',
      studentReacts: 'That would scare anyone! 😰',
      studentEmotion: StudentEmotion.worried,
      illustrationLabel: '📞 Fake Official Call',
      illustration: (glow, accent) => _GovCallIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Real Government Websites',
      tutorSays:
      'Any real government website ends in ".gov.in"\n\n✅ incometax.gov.in (real)\n✅ epfindia.gov.in (real)\n❌ epfo-helpline.com (FAKE!)\n\nAlways check the web address before entering any details.',
      studentReacts: 'So .gov.in means it\'s real?',
      studentEmotion: StudentEmotion.confused,
      illustrationLabel: '🌐 .gov.in = Safe',
      illustration: (glow, accent) => _GovWebsiteIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Digital Arrest Scam',
      tutorSays:
      '"Digital Arrest" is one of the biggest new scams in India.\n\nFraudsters video-call you dressed as police and say you are under "digital arrest".\n\nPolice in India NEVER arrest people over video calls. Hang up and call 1930.',
      studentReacts: 'Police never do video calls for arrest? Good to know!',
      studentEmotion: StudentEmotion.nodding,
      illustrationLabel: '🚫 Digital Arrest = Fake',
      illustration: (glow, accent) => _DigitalArrestIllustration(glow: glow, accent: accent),
    ),
  ];

  // ── DEEPFAKE SCENES ───────────────────────────────────────────────────────
  static List<AnimScene> _deepfakeScenes(Color accent) => [
    AnimScene(
      title: 'What is a Deepfake?',
      tutorSays:
      'A deepfake is a video created by AI where someone\'s face is placed on another person\'s body.\n\nThe video looks VERY real — but it is 100% fake. Fraudsters use deepfakes of famous people to promote fake investments.',
      studentReacts: 'AI can make fake videos? That\'s dangerous!',
      studentEmotion: StudentEmotion.shocked,
      illustrationLabel: '🤖 Real vs AI Face',
      illustration: (glow, accent) => _DeepfakeIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Spot a Deepfake',
      tutorSays:
      'Watch carefully for these signs:\n\n❌ Blurry edges around the face\n❌ Eyes that don\'t blink naturally\n❌ Lips that don\'t match the words\n❌ Unnatural lighting on the face\n\nWhen in doubt — verify on boomlive.in or altnews.in',
      studentReacts: 'I\'ll watch videos more carefully now!',
      studentEmotion: StudentEmotion.nodding,
      illustrationLabel: '🔍 Deepfake Signs',
      illustration: (glow, accent) => _SpotDeepfakeIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'Malicious APK Files',
      tutorSays:
      'If someone sends you an APK file on WhatsApp and asks you to install it — NEVER do it!\n\nAPK files can be malware. Once installed, they can read your OTPs, access your photos, and steal your bank details silently.',
      studentReacts: 'I once got an APK from a "friend"... 😱',
      studentEmotion: StudentEmotion.worried,
      illustrationLabel: '☠️ Dangerous APK',
      illustration: (glow, accent) => _ApkDangerIllustration(glow: glow, accent: accent),
    ),
    AnimScene(
      title: 'You Are Now a Guardian!',
      tutorSays:
      'You have completed all 5 levels! 🏆\n\nYou can now spot phishing, deepfakes, fake calls, and scam links.\n\nShare what you learned with your family. You are their digital guardian!',
      studentReacts: 'I feel ready to protect my family! 🙌',
      studentEmotion: StudentEmotion.happy,
      illustrationLabel: '🛡️ Guardian Badge',
      illustration: (glow, accent) => _GuardianIllustration(glow: glow, accent: accent),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
//  ILLUSTRATION WIDGETS  — all drawn with Flutter widgets, zero images
// ─────────────────────────────────────────────────────────────────────────────

// ── OTP phone sending to bank ────────────────────────────────────────────────
class _OtpIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _OtpIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Phone
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2340),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('📱', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('5 8 2 4 1 9',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text('Your Phone',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF3D4A6B))),
            ],
          ),
          // Arrow with pulse
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: glow.value,
                child: Icon(Icons.arrow_forward_rounded, color: accent, size: 32),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('OTP', style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          // Bank vault
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.withValues(alpha:glow.value * 0.5),
                        blurRadius: 16,
                        spreadRadius: 4),
                  ],
                ),
                child: const Center(
                    child: Text('🏦', style: TextStyle(fontSize: 32))),
              ),
              const SizedBox(height: 6),
              const Text('Your Bank',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF3D4A6B))),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Scam call with red X ─────────────────────────────────────────────────────
class _ScamCallIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _ScamCallIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Phone with call icon
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.red.withValues(alpha:0.5 + glow.value * 0.3),
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withValues(alpha:glow.value * 0.25),
                          blurRadius: 20,
                          spreadRadius: 4),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text('📞', style: TextStyle(fontSize: 36)),
                      const SizedBox(height: 6),
                      const Text('+91-98XXXXXXXX',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('"Share your OTP..."',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.shade700,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.block, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text('HANG UP NOW',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Safe/key illustration ────────────────────────────────────────────────────
class _SafeKeyIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _SafeKeyIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Locked safe
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.withValues(alpha:glow.value * 0.4),
                        blurRadius: 14,
                        spreadRadius: 3),
                  ],
                ),
                child: const Center(
                    child: Text('🔒', style: TextStyle(fontSize: 38))),
              ),
              const SizedBox(height: 6),
              const Text('Your Account\n(SAFE)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.green)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔑', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 4),
              Icon(Icons.arrow_downward_rounded, color: accent, size: 20),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.red, size: 20),
              ),
              const SizedBox(height: 4),
              const Text('YOU only!',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.red)),
            ],
          ),
          // Fraudster blocked
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: const Center(
                      child: Text('🦹', style: TextStyle(fontSize: 38))),
                ),
              ),
              const SizedBox(height: 6),
              const Text('Fraudster\n(BLOCKED)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Password strength illustration ───────────────────────────────────────────
class _PasswordIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _PasswordIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PwRow(label: '❌  Ram1960', strength: 0.15, color: Colors.red, tag: 'WEAK'),
          const SizedBox(height: 10),
          _PwRow(label: '❌  1234', strength: 0.05, color: Colors.red, tag: 'VERY WEAK'),
          const SizedBox(height: 10),
          _PwRow(
              label: '✅  Blue@Sky75',
              strength: glow.value * 0.85 + 0.1,
              color: Colors.green,
              tag: 'STRONG'),
        ],
      ),
    );
  }
}

class _PwRow extends StatelessWidget {
  final String label, tag;
  final double strength;
  final Color color;
  const _PwRow({required this.label, required this.strength, required this.color, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: strength,
                  minHeight: 10,
                  backgroundColor: color.withValues(alpha:0.15),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
              const SizedBox(height: 2),
              Text(tag,
                  style: TextStyle(
                      fontSize: 9,
                      color: color,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Phishing hook ────────────────────────────────────────────────────────────
class _PhishingHookIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _PhishingHookIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Water
            Positioned(
              bottom: 0,
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha:0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.blue.withValues(alpha:0.3), width: 1.5),
                ),
                child: const Center(
                  child: Text('🐠  🐟  🐡',
                      style: TextStyle(fontSize: 22)),
                ),
              ),
            ),
            // Hook + bait
            Positioned(
              top: 10,
              child: Column(
                children: [
                  Text('🎣', style: TextStyle(fontSize: 34)),
                  Container(
                    height: glow.value * 40 + 20,
                    width: 2,
                    color: Colors.brown,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withValues(alpha:glow.value * 0.4),
                            blurRadius: 10,
                            spreadRadius: 2),
                      ],
                    ),
                    child: const Text('"Your account is blocked!"',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── SMS compare: real vs fake ─────────────────────────────────────────────────
class _SmsCompareIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _SmsCompareIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SmsBubble(
            sender: '✅  AD-SBIBNK',
            body: 'Your account balance is ₹12,400.',
            color: Colors.green,
            tag: 'REAL',
            glow: glow.value,
          ),
          const Text('VS',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8B95A5))),
          _SmsBubble(
            sender: '❌  +91-98XXXXXX',
            body: 'Click link to win ₹50,000 NOW!',
            color: Colors.red,
            tag: 'FAKE',
            glow: glow.value,
          ),
        ],
      ),
    );
  }
}

class _SmsBubble extends StatelessWidget {
  final String sender, body, tag;
  final Color color;
  final double glow;
  const _SmsBubble(
      {required this.sender,
        required this.body,
        required this.color,
        required this.tag,
        required this.glow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: color.withValues(alpha:0.4 + glow * 0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha:glow * 0.2),
              blurRadius: 10,
              spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(6)),
            child: Text(tag,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 6),
          Text(sender,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 4),
          Text(body,
              style: const TextStyle(fontSize: 10, color: Color(0xFF3D4A6B))),
        ],
      ),
    );
  }
}

// ── Link compare ─────────────────────────────────────────────────────────────
class _LinkCompareIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _LinkCompareIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LinkRow(
              url: 'sbi-secure-login.com',
              isReal: false,
              glow: glow.value),
          const SizedBox(height: 12),
          _LinkRow(url: 'onlinesbi.sbi', isReal: true, glow: glow.value),
          const SizedBox(height: 12),
          _LinkRow(
              url: 'hdfc-help-center.net',
              isReal: false,
              glow: glow.value),
          const SizedBox(height: 12),
          _LinkRow(
              url: 'hdfcbank.com', isReal: true, glow: glow.value),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  final String url;
  final bool isReal;
  final double glow;
  const _LinkRow({required this.url, required this.isReal, required this.glow});

  @override
  Widget build(BuildContext context) {
    final color = isReal ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: color.withValues(alpha:isReal ? 0.3 + glow * 0.2 : 0.5),
            width: 1.5),
      ),
      child: Row(
        children: [
          Icon(
            isReal ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w700,
                  decoration: isReal
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(6)),
            child: Text(isReal ? 'REAL' : 'FAKE',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

// ── Overshare illustration ───────────────────────────────────────────────────
class _OvershareIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _OvershareIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InfoTag(emoji: '📅', label: 'Birthday: 15 Jan 1960', danger: true, glow: glow.value),
              const SizedBox(width: 8),
              _InfoTag(emoji: '📞', label: '+91-98XXXXXX', danger: true, glow: glow.value),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InfoTag(emoji: '🏠', label: 'Sector 12, Delhi', danger: true, glow: glow.value),
              const SizedBox(width: 8),
              _InfoTag(emoji: '✅', label: 'Just the photo', danger: false, glow: glow.value),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: const Text(
              '🔴 Red info = DON\'T post publicly!',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String emoji, label;
  final bool danger;
  final double glow;
  const _InfoTag({required this.emoji, required this.label, required this.danger, required this.glow});

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : Colors.green;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: color.withValues(alpha:danger ? 0.4 + glow * 0.2 : 0.4),
            width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Fake profile illustration ─────────────────────────────────────────────────
class _FakeProfileIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _FakeProfileIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: Colors.red.withValues(alpha:0.4 + glow.value * 0.3),
                width: 2),
            boxShadow: [
              BoxShadow(
                  color: Colors.red.withValues(alpha:glow.value * 0.2),
                  blurRadius: 14,
                  spreadRadius: 3),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  const Text('👤', style: TextStyle(fontSize: 44)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: const Icon(Icons.warning,
                          color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rahul Sharma',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Color(0xFF1A2340))),
                    const SizedBox(height: 2),
                    Text('743 Mutual Friends',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.cancel, color: Colors.red, size: 14),
                        const SizedBox(width: 4),
                        const Text('Profile created 2 days ago',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const Text('No posts, no photos',
                        style: TextStyle(fontSize: 10, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Privacy settings illustration ────────────────────────────────────────────
class _PrivacySettingsIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _PrivacySettingsIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SettingRow(
              label: 'Who sees my posts?',
              value: 'Friends Only ✅',
              on: true,
              glow: glow.value,
              accent: accent),
          const SizedBox(height: 8),
          _SettingRow(
              label: 'Show phone number?',
              value: 'Nobody ✅',
              on: true,
              glow: glow.value,
              accent: accent),
          const SizedBox(height: 8),
          _SettingRow(
              label: 'Show home address?',
              value: 'Nobody ✅',
              on: true,
              glow: glow.value,
              accent: accent),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label, value;
  final bool on;
  final double glow;
  final Color accent;
  const _SettingRow(
      {required this.label,
        required this.value,
        required this.on,
        required this.glow,
        required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: on
            ? Colors.green.withValues(alpha:0.07 + glow * 0.03)
            : Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: on
                ? Colors.green.withValues(alpha:0.4)
                : Colors.red.withValues(alpha:0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1A2340),
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.green,
                  fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

// ── Government call illustration ─────────────────────────────────────────────
class _GovCallIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _GovCallIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🦹', style: TextStyle(fontSize: 36)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.red.withValues(alpha:0.5 + glow.value * 0.3)),
                        boxShadow: [
                          BoxShadow(
                              color:
                              Colors.red.withValues(alpha:glow.value * 0.2),
                              blurRadius: 8),
                        ],
                      ),
                      child: const Text(
                        '"I am from TRAI.\nYour SIM will be blocked\nin 2 hours!"',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: const Text(
                '✅  TRAI / CBI / Police NEVER call\nto block SIMs or demand payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Government website illustration ──────────────────────────────────────────
class _GovWebsiteIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _GovWebsiteIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LinkRow(url: 'incometax.gov.in', isReal: true, glow: glow.value),
          const SizedBox(height: 8),
          _LinkRow(url: 'epfindia.gov.in', isReal: true, glow: glow.value),
          const SizedBox(height: 8),
          _LinkRow(
              url: 'epfo-helpline.com',
              isReal: false,
              glow: glow.value),
          const SizedBox(height: 8),
          _LinkRow(
              url: 'income-tax-refund.in',
              isReal: false,
              glow: glow.value),
        ],
      ),
    );
  }
}

// ── Digital arrest illustration ───────────────────────────────────────────────
class _DigitalArrestIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _DigitalArrestIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Fake police video call
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.red.withValues(alpha:0.5 + glow.value * 0.4),
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red
                              .withValues(alpha:glow.value * 0.3),
                          blurRadius: 12,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('👮', style: TextStyle(fontSize: 28)),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('LIVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text('FAKE VIDEO CALL',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            // Big X
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: glow.value,
                  child: const Icon(Icons.cancel_rounded,
                      color: Colors.red, size: 48),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: const Text('Call 1930\n(Cyber Helpline)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Deepfake side-by-side ─────────────────────────────────────────────────────
class _DeepfakeIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _DeepfakeIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Real
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                  border: Border.all(
                      color: Colors.green.withValues(alpha:0.3 + glow.value * 0.3),
                      width: 2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green
                            .withValues(alpha:glow.value * 0.2),
                        blurRadius: 10,
                        spreadRadius: 2),
                  ],
                ),
                child: const Center(
                    child: Text('😊', style: TextStyle(fontSize: 40))),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('REAL',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          // vs
          const Text('VS',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8B95A5))),
          // Fake (blurry edges)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red, width: 2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red
                                .withValues(alpha:glow.value * 0.35),
                            blurRadius: 16,
                            spreadRadius: 6),
                      ],
                    ),
                    child: const Center(
                        child: Text('🤖', style: TextStyle(fontSize: 40))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: const Icon(Icons.warning,
                          color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('AI FAKE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Spot deepfake checklist ───────────────────────────────────────────────────
class _SpotDeepfakeIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _SpotDeepfakeIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CheckItem(text: 'Blurry face edges', flag: true, glow: glow.value),
          const SizedBox(height: 6),
          _CheckItem(text: 'Eyes don\'t blink naturally', flag: true, glow: glow.value),
          const SizedBox(height: 6),
          _CheckItem(text: 'Lips don\'t match words', flag: true, glow: glow.value),
          const SizedBox(height: 6),
          _CheckItem(text: 'Person says unlikely things', flag: true, glow: glow.value),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent.withValues(alpha:0.4)),
            ),
            child: Text('Verify on boomlive.in or altnews.in',
                style: TextStyle(
                    fontSize: 11,
                    color: accent,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String text;
  final bool flag;
  final double glow;
  const _CheckItem({required this.text, required this.flag, required this.glow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha:0.06 + glow * 0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha:0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF3D4A6B),
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── APK danger illustration ───────────────────────────────────────────────────
class _ApkDangerIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _ApkDangerIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // WhatsApp-style message
            Container(
              width: 220,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFDCF8C6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.red.withValues(alpha:glow.value * 0.5),
                    width: 2),
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withValues(alpha:glow.value * 0.2),
                      blurRadius: 12,
                      spreadRadius: 3),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('"Install this app!"',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A2340))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_download, color: Colors.red, size: 18),
                        SizedBox(width: 4),
                        Text('community.apk',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_downward, color: Colors.red, size: 20),
                const SizedBox(width: 6),
                const Text('This can steal your OTPs, photos & bank details!',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Guardian badge illustration ───────────────────────────────────────────────
class _GuardianIllustration extends StatelessWidget {
  final Animation<double> glow;
  final Color accent;
  const _GuardianIllustration({required this.glow, required this.accent});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shield badge
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accent.withValues(alpha:0.3 + glow.value * 0.2),
                    accent.withValues(alpha:0.05),
                  ],
                ),
                border: Border.all(
                    color: accent.withValues(alpha:0.5 + glow.value * 0.3),
                    width: 3),
                boxShadow: [
                  BoxShadow(
                      color: accent.withValues(alpha:glow.value * 0.45),
                      blurRadius: 24,
                      spreadRadius: 8),
                ],
              ),
              child: const Center(
                  child: Text('🛡️', style: TextStyle(fontSize: 52))),
            ),
            const SizedBox(height: 12),
            Text(
              'DIGITAL GUARDIAN',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: accent,
                  letterSpacing: 1.5),
            ),
            const SizedBox(height: 6),
            const Text(
              'You can protect yourself & your family!',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF3D4A6B),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
