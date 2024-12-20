import 'db_helper.dart';
import 'db_base.dart';

class JobSeekersTable extends DBBaseTable {
  @override
  String get db_table => 'job_seekers';  // Table name

  // You can add custom methods for the `job_seekers` table if necessary
}
