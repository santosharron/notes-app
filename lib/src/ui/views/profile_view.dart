import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/src/models/note.dart';
import 'package:notes_app/src/ui/providers/note_provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _header(context),
        SizedBox(height: 10),
        _profile(context),
        SizedBox(height: 30),
        _totalNotesCreated(context),
        SizedBox(height: 7),
        _totalWordsTyped(context),
        SizedBox(height: 7),
        _totalCharactersTyped(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CantonBackButton(
        isClear: true,
      ),
      Text(
        'Profile',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
      CantonHeaderButton(
        backgroundColor: CantonColors.transparent,
        icon: Container(),
        onPressed: () {},
      ),
    ]);
  }

  Widget _profile(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundImage: new NetworkImage("https://i.imgur.com/xEiiVCX.png"), radius: 50),
        SizedBox(height: 7),
        Text('Unknown', style: Theme.of(context).textTheme.headline4),
      ],
    );
  }

  Widget _totalNotesCreated(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total Notes Created',
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(),
            Consumer(
              builder: (context, watch, child) {
                final repo = watch(noteProvider);
                return Text(repo.length.toString(),
                    style: Theme.of(context).textTheme.headline5);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalWordsTyped(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total Words Typed',
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(),
            Consumer(
              builder: (context, watch, child) {
                final repo = watch(noteProvider);
                int totalWords = 0;
                for (Note note in repo) {
                  totalWords += note.content
                      .trim()
                      .replaceAll(new RegExp(r'\s+'), ' ')
                      .split(' ')
                      .length;
                }
                return Text(
                  totalWords.toString(),
                  style: Theme.of(context).textTheme.headline5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalCharactersTyped(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        child: Row(
          children: [
            Text(
              'Total Characters Typed',
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(),
            Consumer(
              builder: (context, watch, child) {
                final repo = watch(noteProvider);
                int totalCharacters = 0;
                for (Note note in repo) {
                  totalCharacters += note.content
                      .trim()
                      .replaceAll(new RegExp(r'\s+'), ' ')
                      .split('')
                      .length;
                }
                return Text(
                  totalCharacters.toString(),
                  style: Theme.of(context).textTheme.headline5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
