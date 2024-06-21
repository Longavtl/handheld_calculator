

import '../../../../core/usecase/usecase.dart';
import '../../../models/basic_response_model.dart';
import '../../../models/user_auth_model.dart';
import '../../http/result_data.dart';

abstract class AccountRemoteDatasource {
  Future<UserAuthModel<ProfileDataModel>> getProfile();

  Future<BasicResponseModel> changePass(ChangePassParams params);

  Future<BasicResponseModel> updateProfile(UpdateProfileParams params);

  Future<BasicResponseModel> linkCardInfo(BasicParams params);

  Future<BasicResponseModel> linkCardInfoConfirm(BasicParams params);

  Future<ResultData> uploadAvatar(UploadAvatarParams params);
}