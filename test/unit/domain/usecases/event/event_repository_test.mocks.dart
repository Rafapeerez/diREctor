// Mocks generated by Mockito 5.4.4 from annotations
// in director_app_tfg/test/unit/domain/usecases/event/event_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:director_app_tfg/domain/models/event.dart' as _i2;
import 'package:director_app_tfg/domain/models/musician.dart' as _i5;
import 'package:director_app_tfg/domain/repositories/event_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEvent_0 extends _i1.SmartFake implements _i2.Event {
  _FakeEvent_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EventRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventRepository extends _i1.Mock implements _i3.EventRepository {
  MockEventRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Event> saveEvent(_i2.Event? event) => (super.noSuchMethod(
        Invocation.method(
          #saveEvent,
          [event],
        ),
        returnValue: _i4.Future<_i2.Event>.value(_FakeEvent_0(
          this,
          Invocation.method(
            #saveEvent,
            [event],
          ),
        )),
      ) as _i4.Future<_i2.Event>);

  @override
  _i4.Future<List<_i2.Event>> getAllEvents() => (super.noSuchMethod(
        Invocation.method(
          #getAllEvents,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Event>>.value(<_i2.Event>[]),
      ) as _i4.Future<List<_i2.Event>>);

  @override
  _i4.Future<void> deleteEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #deleteEvent,
          [eventId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.Event> confirmAttendance(
    _i5.Musician? musician,
    _i2.Event? event,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmAttendance,
          [
            musician,
            event,
          ],
        ),
        returnValue: _i4.Future<_i2.Event>.value(_FakeEvent_0(
          this,
          Invocation.method(
            #confirmAttendance,
            [
              musician,
              event,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Event>);

  @override
  _i4.Future<bool> hasConfirmed(
    String? email,
    String? eventId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #hasConfirmed,
          [
            email,
            eventId,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Event> updateRepertoire(
    List<String>? repertoire,
    _i2.Event? event,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateRepertoire,
          [
            repertoire,
            event,
          ],
        ),
        returnValue: _i4.Future<_i2.Event>.value(_FakeEvent_0(
          this,
          Invocation.method(
            #updateRepertoire,
            [
              repertoire,
              event,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Event>);

  @override
  _i4.Future<_i2.Event> updateEvent(
    String? eventId,
    _i2.Event? event,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEvent,
          [
            eventId,
            event,
          ],
        ),
        returnValue: _i4.Future<_i2.Event>.value(_FakeEvent_0(
          this,
          Invocation.method(
            #updateEvent,
            [
              eventId,
              event,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Event>);
}
