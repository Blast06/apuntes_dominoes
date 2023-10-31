// To parse this JSON data, do
//
//     final appAds = appAdsFromJson(jsonString);

import 'dart:convert';

AppAds appAdsFromJson(String str) => AppAds.fromJson(json.decode(str));

String appAdsToJson(AppAds data) => json.encode(data.toJson());

class AppAds {
    String testIosAppId;
    String testIosOpenAd;
    bool show;
    String prodIosOpenAd;
    String prodIosAppId;

    AppAds({
        required this.testIosAppId,
        required this.testIosOpenAd,
        required this.show,
        required this.prodIosOpenAd,
        required this.prodIosAppId,
    });

    AppAds copyWith({
        String? testIosAppId,
        String? testIosOpenAd,
        bool? show,
        String? prodIosOpenAd,
        String? prodIosAppId,
    }) => 
        AppAds(
            testIosAppId: testIosAppId ?? this.testIosAppId,
            testIosOpenAd: testIosOpenAd ?? this.testIosOpenAd,
            show: show ?? this.show,
            prodIosOpenAd: prodIosOpenAd ?? this.prodIosOpenAd,
            prodIosAppId: prodIosAppId ?? this.prodIosAppId,
        );

    factory AppAds.fromJson(Map<String, dynamic> json) => AppAds(
        testIosAppId: json["test_ios_app_id"],
        testIosOpenAd: json["test_ios_open_ad"],
        show: json["show"],
        prodIosOpenAd: json["prod_ios_open_ad"],
        prodIosAppId: json["prod_ios_app_id"],
    );

    Map<String, dynamic> toJson() => {
        "test_ios_app_id": testIosAppId,
        "test_ios_open_ad": testIosOpenAd,
        "show": show,
        "prod_ios_open_ad": prodIosOpenAd,
        "prod_ios_app_id": prodIosAppId,
    };
}
