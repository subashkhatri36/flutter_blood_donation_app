import 'package:dartz/dartz.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

abstract class RequestRepo {
  Future<Either<String, RequestModel>> saveRequest(String userId);
  Future<Either<String, String>> updateRequest(RequestModel request);
  Future<Either<String, String>> deleteRequest(String reqId, String userId);
  //  Future<Either<String, RequestModel>> saveRequest(String userId);
  // Future<Either<String, String>> updateRequest(RequestModel request);
  // Future<Either<String, String>> deleteRequest(String reqId, String userId);
}

class RequestRepositories implements RequestRepo {
  @override
  Future<Either<String, String>> deleteRequest(String reqId, String userId) {
    // TODO: implement deleteRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<String, RequestModel>> saveRequest(String userId) {
    // TODO: implement saveRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateRequest(RequestModel request) {
    // TODO: implement updateRequest
    throw UnimplementedError();
  }
}
