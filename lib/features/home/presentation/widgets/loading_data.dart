import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade400,
        child: ListView.separated(
              itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            width: 150.w,
                            height: 15.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            width: 50.w,
                            height: 15.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 240,
                        child: ListView.separated(
                            itemBuilder: (context, index) => Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 118.w,
                                      height: 143.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(17.r)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 10.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 10.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                    ),
                                    SizedBox(
                                      height: 9.h,
                                    ),
                                    Container(
                                      height: 10.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                    ),
                                  ],
                                ),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 20.w,
                                ),
                            itemCount: 15),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 3),
      ),
    );
  }
}
