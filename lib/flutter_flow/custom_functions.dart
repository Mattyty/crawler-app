import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<LatLng>? getLatLngFromGeog(
  List<double>? latList,
  List<double>? lngList,
) {
  if (latList == null || lngList == null) return [];
  List<LatLng> points = [];

  // Pair up the latitudes and longitudes safely
  int length = math.min(latList.length, lngList.length);
  for (int i = 0; i < length; i++) {
    final lat = latList[i];
    final lng = lngList[i];

    if (lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180) {
      points.add(LatLng(lat, lng));
    }
  }
  return points;
}

bool isOfferLive(
  DateTime? currentDateTime,
  List<int>? activeDays,
  String? startTime,
  String? endTime,
) {
  // 1. Safety check for null inputs
  if (currentDateTime == null ||
      activeDays == null ||
      activeDays.isEmpty ||
      startTime == null ||
      endTime == null) {
    return false;
  }

  // 2. Get current day of the week as an integer (Monday = 1, Tuesday = 2 ... Sunday = 7)
  // DateTime.weekday natively returns 1 for Monday through 7 for Sunday
  int currentDayInt = currentDateTime.weekday;

  // 3. Check if today's day number is included in the bar's active_days array
  if (!activeDays.contains(currentDayInt)) {
    return false; // If today isn't in the list, the offer isn't live today
  }

  try {
    // 4. Format current time to 24-hour HH:mm string
    String currentTimeString = DateFormat('HH:mm').format(currentDateTime);

    String startStr = startTime.trim();
    String endStr = endTime.trim();

    // 5. Compare time strings lexicographically
    bool hasStarted = currentTimeString.compareTo(startStr) >= 0;
    bool hasNotEnded = currentTimeString.compareTo(endStr) < 0;

    return hasStarted && hasNotEnded;
  } catch (e) {
    return false;
  }
}

String? getDistanceToBar(
  LatLng? userLocation,
  double? barLat,
  double? barLng,
) {
  // Guardrail: If any location point data is missing, exit safely
  if (userLocation == null || barLat == null || barLng == null) {
    return "-- miles";
  }

  // Convert degrees to radians
  double lat1 = userLocation.latitude * math.pi / 180;
  double lon1 = userLocation.longitude * math.pi / 180;
  double lat2 = barLat * math.pi / 180;
  double lon2 = barLng * math.pi / 180;

  // Earth radius in miles
  double r = 3958.8;

  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  // Haversine calculation
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);

  double c = 2 * math.asin(math.sqrt(a));
  double distance = r * c;

  // Format to 1 decimal place (e.g., 0.6 miles)
  return "${distance.toStringAsFixed(1)} miles";
}
