import 'package:fpdart/fpdart.dart';

import '../../../core/core.dart';

typedef ApiResult = Either<Failure, Map<String, dynamic>>;

typedef Result<T> = Either<Failure, T>;
