import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/dominio/entities/session_entity.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final SessionEntity session;
  final SessionFormNotifier notifier;

  const SessionForm(this.formKey, this.session, this.notifier, {super.key});

  @override
  ConsumerState<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends ConsumerState<SessionForm> {
  late final TextEditingController _endPageController;
  late final TextEditingController _startPageController;
  late final TextEditingController _minutesController;

  @override
  void initState() {
    super.initState();
    _startPageController = TextEditingController(
      text: widget.session.startPage.toString(),
    );
    _endPageController = TextEditingController(
      text: widget.session.endPage.toString(),
    );
    _minutesController = TextEditingController(
      text: widget.session.minutesRead.toString(),
    );
  }

  @override
  void didUpdateWidget(SessionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.session.endPage != oldWidget.session.endPage) {
      _endPageController.text = widget.session.endPage.toString();
    }
    if (widget.session.startPage != oldWidget.session.startPage) {
      _startPageController.text = widget.session.startPage.toString();
    }
    if (widget.session.minutesRead != oldWidget.session.minutesRead) {
      _minutesController.text = widget.session.minutesRead.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        children: [
          SessionFormPageStart(widget.notifier, _startPageController),
          const SizedBox(height: 20),

          SessionFormPageEnd(
            widget.notifier,
            _endPageController,
            widget.notifier.totalPages,
          ),
          const SizedBox(height: 20),

          SessionFormMinutes(widget.notifier, _minutesController),
          const SizedBox(height: 20),

          SessionFormDate(widget.notifier, widget.session.sessionDate),
        ],
      ),
    );
  }
}
