import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/providers/court_group_provider.dart';
import 'package:pickle_ball/models/court_group_model.dart';

class AboutView extends ConsumerWidget {
  final int tournamentId;

  const AboutView({Key? key, required this.tournamentId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courtGroupAsyncValue = ref.watch(courtGroupProvider(tournamentId));

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
        child: courtGroupAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (courtGroup) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              _buildInfoCard(courtGroup),
              SizedBox(height: 20.h),
              Text(
                "Tournament Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: _buildMap(
                  double.tryParse(courtGroup.latitude ?? '') ?? 0,
                  double.tryParse(courtGroup.longitude ?? '') ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(CourtGroup courtGroup) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.grayColor.withOpacity(.3),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (courtGroup.courtGroupName != null)
            Text(
              courtGroup.courtGroupName!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          SizedBox(height: 8.h),
          if (courtGroup.address != null)
            _buildInfoRow(Icons.location_on, courtGroup.address!),
          if (courtGroup.emailContact != null)
            _buildInfoRow(Icons.email, courtGroup.emailContact!),
          if (courtGroup.phoneNumber != null)
            _buildInfoRow(Icons.phone, courtGroup.phoneNumber!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: ColorUtils.grayColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(double latitude, double longitude) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorUtils.grayColor.withOpacity(.3),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude, longitude),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
