import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/dominio/domain.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final String bookId;

  const SessionForm(this.formKey, this.bookId, {super.key});

  @override
  ConsumerState<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends ConsumerState<SessionForm> {
  late final TextEditingController _endPageController;
  late final TextEditingController _startPageController;
  late final TextEditingController _minutesController;
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _startPageController = TextEditingController();
    _endPageController = TextEditingController();
    _minutesController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _endPageController.dispose();
    _startPageController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(
      sessionCreateNotifierProvider(widget.bookId),
    );
    final sessionCreateNotifier = ref.read(
      sessionCreateNotifierProvider(widget.bookId).notifier,
    );

    sessionAsync.whenOrNull(
      data: (session) {
        _syncControllers(session);
      },
    );

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SessionFormPageStart(_startPageController, (value) {
            final parsed = int.tryParse(value) ?? 0;
            sessionCreateNotifier.updateStartPage(parsed);
          }),
          const SizedBox(height: 20),

          SessionFormPageEnd(
            _endPageController,
            sessionCreateNotifier.totalPages,
            (value) {
              final parsed = int.tryParse(value) ?? 0;
              sessionCreateNotifier.updateEndPage(parsed);
            },
          ),
          const SizedBox(height: 20),

          SessionFormMinutes(_minutesController, (value) {
            sessionCreateNotifier.updateMinutesRead(value);
          }),
          const SizedBox(height: 20),

          SessionFormDate(_dateController, (value) {
            sessionCreateNotifier.updateSessionDate(value);
          }),
        ],
      ),
    );
  }

  void _syncControllers(SessionEntity session) {
    if (_startPageController.text != session.startPage.toString()) {
      _startPageController.text = session.startPage.toString();
    }
    if (_endPageController.text != session.endPage.toString()) {
      _endPageController.text = session.endPage.toString();
    }
    if (_minutesController.text != session.minutesRead.toString()) {
      _minutesController.text = session.minutesRead.toString();
    }
    if (_dateController.text != session.sessionDate.toString()) {
      _dateController.text = session.sessionDate.toString();
    }
  }
}
