import "dart:developer";

import "package:flutter_naver_map/flutter_naver_map.dart";
import "package:flutter/material.dart";
import "package:project_heck/naver_map/campusmarker_model.dart";
import "package:project_heck/naver_map/dialog_ui.dart";

const icon = NOverlayImage.fromAssetImage('assets/images/pin2.png');

List<CampusMarker> allMarkers = [
  CampusMarker(
      idNumber: "1", //구두인관
      position: const NLatLng(37.48834872, 126.82502522),
      buildingName: '구두인관',
      buildingDescription: '신학연구원과 구로마을 대학이 존재한다.',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "2", //새천년관
      position: const NLatLng(37.48823757, 126.82539904),
      buildingName: '새천년관',
      buildingDescription: '인문사회건물로 건강증진센터와,인권센터,학식당이 존재한다.',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "3", //학관
      position: const NLatLng(37.4877332, 126.82487129),
      buildingName: '학관',
      buildingDescription: '학생회관으로 동아리실과 학생회실이 존재한다.',
      missionDescription: '다음 정답으로 올바른 것을 고르세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "4", //승연관
      position: const NLatLng(37.48749122, 126.82580057),
      buildingName: '승연관',
      buildingDescription: '대학본부로 교무처와 총무처 등이 존재한다.',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "5", //미가엘+ 이천환
      position: const NLatLng(37.48725603, 126.8265476),
      buildingName: '미가엘관,이천환기념관',
      buildingDescription:
          '미가엘관:밥풀,헬스장,멋짐,기숙사가 존재한다. \n이천환기념관:이공계건물, 실습실이 존재한다.',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "6", //도서관
      position: const NLatLng(37.48814075, 126.82585164),
      buildingName: '중앙도서관',
      buildingDescription: '성공회역사자료관과 세미나실이 존재한다. ',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "7", //월당관
      position: const NLatLng(37.48721646, 126.82607443),
      buildingName: '월당관',
      buildingDescription: '수업지원AS실과 열람실이 존재한다.',
      missionDescription: '퀴즈를 풀어보세요',
      imagePath: 'assets/images/guduin.jpg',
      missionImage: 'assets/images/mission.jpg'),
  CampusMarker(
      idNumber: "8", //일만관
      position: const NLatLng(37.4875581, 126.82613706),
      buildingName: '일만관',
      buildingDescription: '교수연구실과 컴퓨터 실습실이 존재한다.',
      missionDescription: '아래와 같은 구도로 사진을 찍으세요',
      imagePath: '',
      missionImage: 'assets/images/mission.jpg'),
];

Set<NMarker> buildCampusMarkers(BuildContext context) {
  return allMarkers.map((campusmarker) {
    final marker = NMarker(
      id: "marker${campusmarker.idNumber}",
      position: campusmarker.position,
      size: const Size(36, 36),
      icon: icon,
    );

    marker.setOnTapListener((NMarker marker) {
      log("Marker ${campusmarker.buildingName} clicked");
      showMarkerDialog(context, campusmarker);
    });
    return marker;
  }).toSet();
}
