import 'package:bl_staff/features/sessions/data/datasources/sessions_local_data_source.dart';
import 'package:bl_staff/utils/shared/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'token_provider_di.dart';
part 'token_provider_impl.dart';

/// Sebuah abstract class untuk me-manage `AuthToken` di seluruh aplikasi.
///
/// class ini penting agar semua request yang dilakukan dapat menggunakan token
/// dari hasil generate BE.
///
/// class ini menyimpan `AuthToken` hasil generate BE pada
/// cached memory atau pada [FlutterSecureStorage].
///
/// gunakan atau panggil class ini menggunakan `Dependencies Injection`,
/// jangan menginisialisasi sendiri class ini.
///
/// [TokenProviderImpl] - Implementasi dari class ini.
abstract class TokenProvider {
  /// Mengambil token aktif dari cache atau storage.
  /// Returns `null` jika belum ada token tersimpan.
  Future<String?> getToken();

  /// Function untuk menyimpan atau memperbaharui `AuthToken`
  /// yang sudah tersimpan.
  ///
  /// Panggil function ini ketika user berhasil login.
  void setToken(String token);

  /// Function untuk menghapus `AuthToken` yang tersimpan.
  ///
  /// Panggil function ini ketika user ingin atau berhasil logout.
  void clearToken();
}
