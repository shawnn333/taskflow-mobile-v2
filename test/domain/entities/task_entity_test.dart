import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';

void main() {
  group('TaskEntity serialization', () {
    test('exposes id, title, completed and dates in the serialized output', () {
      final task = TaskEntity.create(title: 'Write docs');
      final json = task.toJson();

      expect(json['id'], isNotEmpty);
      expect(json['title'], 'Write docs');
      expect(json['completed'], false);
      expect(json['createdAt'], isA<String>());
      expect(json['updatedAt'], isA<String>());
    });

    test('round-trips through fromJson', () {
      final original = TaskEntity.create(title: 'Round trip me');
      final restored = TaskEntity.fromJson(original.toJson());

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.completed, original.completed);
    });
  });

  group('TaskEntity validation', () {
    test('throws when title is empty', () {
      expect(() => TaskEntity.create(title: '   '), throwsArgumentError);
    });

    test('throws when constructed with an empty id', () {
      expect(
        () => TaskEntity(
          id: '',
          title: 'Valid title',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        throwsArgumentError,
      );
    });
  });

  group('TaskEntity.toggleComplete', () {
    test('flips completed and bumps updatedAt', () async {
      final task = TaskEntity.create(title: 'Toggle me');
      await Future.delayed(const Duration(milliseconds: 2));
      final toggled = task.toggleComplete();

      expect(toggled.completed, true);
      expect(toggled.updatedAt.isAfter(task.updatedAt), true);
    });
  });
}
