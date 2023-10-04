import 'package:fpdart/fpdart.dart';
import 'package:todlrtest/core/failure.dart';

/* FutureEither:
it equates a future of type either, where either is a custom type def that returns 
failure response on the left and success on the right. failure type has been custom 
defined to return just the failure message. success type is dependent on developer definition. 
it can be an int, a bool, anything really. */
typedef FutureEither<SuccessType> = Future<Either<Failure, SuccessType>>;

/* simple future of type void returning a custom future either of type void, 
i.e., regular future that returns nothing. */
typedef FutureVoid = FutureEither<void>;

//! an enum for handling the audio state
enum AudioState { playing, paused, done }
