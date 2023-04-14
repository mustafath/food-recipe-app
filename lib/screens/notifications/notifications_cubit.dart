import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter/material.dart";

import '../../models/notification.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  List<AppNotification> notifications = [];
}

class NotificationsInitial extends NotificationsState {}

abstract class NotificationsState {}
