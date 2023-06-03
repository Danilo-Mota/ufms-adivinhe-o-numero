import 'package:adivinhe_o_numero/play_view_model.dart';
import 'package:flutter/material.dart';

abstract class PlayViewProtocol with ChangeNotifier {
  String get currentValue;
  String get correctAnswers;
  String get wrongAnswers;

  void resetGame();
  void didTapBigger();
  void didTapSmaller();
  void createListOfNumbers();

  void Function()? onLoss;
  void Function()? onWin;
}

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  final PlayViewProtocol viewModel = PlayViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.createListOfNumbers();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: viewModel,
          builder: (_, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: Text(
                    '🏆 Acertos: ${viewModel.correctAnswers}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '🤕 Erros: ${viewModel.wrongAnswers}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    viewModel.currentValue,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: viewModel.didTapSmaller,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.all(16)),
                          child: Text('Menor'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: viewModel.didTapBigger,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.all(16)),
                          child: Text('Maior'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  void _bind() {
    viewModel.onLoss = () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade800,
            title: const Text(
              'Você perdeu 🤕',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            content: const Text(
              'Deseja jogar novamente?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  viewModel.resetGame();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Jogar novamente',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      );
    };

    viewModel.onWin = () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade800,
            title: const Text(
              'Você venceu 🏆🤩💥',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            content: const Text(
              'Deseja jogar novamente?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  viewModel.resetGame();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Jogar novamente',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      );
    };
  }
}
