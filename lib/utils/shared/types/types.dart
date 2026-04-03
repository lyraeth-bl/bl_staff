import 'package:bl_staff/core/api/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef ApiResult = Either<Failure, Map<String, dynamic>>;

typedef Result<T> = Either<Failure, T>;
