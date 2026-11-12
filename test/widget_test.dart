import 'package:flutter_test/flutter_test.dart';
import 'package:project_uts/main.dart';

void main() {
  testWidgets('JelajahYuk menampilkan halaman login', (
    WidgetTester tester,
  ) async {
    // Menjalankan aplikasi JelajahYuk
    await tester.pumpWidget(const JelajahYukApp());

    // Memastikan halaman login berhasil ditampilkan
    expect(find.text('Selamat Datang!'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
