import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceInformation () async{
  Map deviceInfo = (await DeviceInfoPlugin().deviceInfo).data;
  String brand = deviceInfo['brand']??"";
  String model = deviceInfo['model']??"";
  String name = deviceInfo['name']??"";
  String value = "$brand $model $name";
  if(value.length > 50){
    value = "$model";
  }
  return value;
}