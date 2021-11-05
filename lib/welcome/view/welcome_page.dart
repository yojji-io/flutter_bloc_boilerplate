import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                return Column(
                  children: [
                    _AppLogo(),
                    _Title(),
                    _Image(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Logo');
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('title');
  }
}

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('image');
  }
}
