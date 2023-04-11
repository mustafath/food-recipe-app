import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/models/review.dart';
import 'package:food_recipe_app/screens/service/auth_service.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  TextEditingController commentController = TextEditingController();
  double ratingController = 3;

  Review prepareComment() {
    Review newReview = Review(
        id: Uuid().v4(),
        userId: AuthService.instance.loggedInUser!.id,
        comment: commentController.text,
        rating: ratingController,
        timestamp: DateTime.now());
    return newReview;
  }

  void sendComment(String docId) {
    Review review = prepareComment();
    FirestoreService.instance
        .addItem("reviews", "foods", docId, review.toMap());
  }
}

class ReviewInitial extends ReviewState {}

abstract class ReviewState {}
