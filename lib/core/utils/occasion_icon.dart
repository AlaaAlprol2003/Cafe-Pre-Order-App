import 'package:flutter/material.dart';

IconData getOccasionIcon(String occasion) {
  switch (occasion) {
    case "Birthday":
      return Icons.cake;
    case "Engagement":
      return Icons.favorite;
    case "Graduation":
      return Icons.school;
    case "Meeting":
      return Icons.work;
    case "Football match":
      return Icons.sports_soccer;
    default:
      return Icons.event;
  }
}