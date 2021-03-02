<?php
namespace app\index\controller;

use app\admin\model\IdxFeedback;
use app\admin\model\IdxForGotPwd;
use think\facade\Session;
use think\facade\View;
use think\facade\Request;

use app\admin\model\IdxUser;
use app\admin\model\IdxUserData;
use app\admin\model\IdxUserMessage;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxUserMillLease;
use app\admin\model\SysAd;
use app\admin\model\SysSetting;

class Me extends Index{
    public function __construct(){
        parent::__construct();
        View::assign('USDT2CNY', SysSetting::where('sign', 'USDT2CNY')->value('value'));
    }

    public function 我的(){
        $user_mills = IdxUserMill::where('user_id', $this->user_id)->where('剩余周期', '>', 0)->select();
        $user_z_mills = IdxUserMillLease::where('user_id', $this->user_id)->where('剩余周期', '>', 0)->select();
        $总资产 = $this->user->userfund->USDT;
        $收益 = 0;
        foreach($user_mills as $v){
            $总资产 += $v->总价;
            $收益 += $v->每日收益;
        }
        foreach($user_z_mills as $v){
            $总资产 += $v->总价;
            $收益 += $v->每日收益;
        }
        View::assign('zc', $总资产);
        View::assign('sy', $收益);
        return View::fetch();
    }

    public function 个人中心(){
        return View::fetch();
    }

    public function 修改昵称(){
        return View::fetch();
    }

    public function 修改昵称提交(){
        $nickname = Request::instance()->param('nickname', '');
        if($nickname == ''){
            return return_data(2, '', '请添加昵称');
        }
        $this->user->nickname = $nickname;
        $res = $this->user->save();
        return $res ? return_data(1, '', '修改昵称成功', '修改昵称') : return_data(2, '', '修改昵称失败');
    }

    public function 修改头像提交(){
        $photo = Request::instance()->file('photo');
        if($photo){
            $image_res = file_upload($photo, 'via');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $this->user->via = $image_res['file_path'];
            $res = $this->user->save();
            return $res ? return_data(1, '', '修改成功', '修改头像') : return_data(2, '', '修改失败');
        }else{
            return return_data(2, '', '请上传头像');
        }
    }

    public function 修改登录密码(){
        return View::fetch();
    }

    public function 修改登录密码提交(){
        $old_password = Request::instance()->param('old_password', '');
        $password = Request::instance()->param('password', '');
        $password_confirm = Request::instance()->param('password_confirm', '');
        $validate = new \app\index\validate\密码修改;
        if(!$validate->check(['old_password'=> $old_password, 'password'=> $password, 'password_confirm'=> $password_confirm])){
            return return_data(2, '', $validate->getError());
        }
        $this->user->password = md5($password . $this->user->password_salt);
        $res = $this->user->save();
        if($res){
            return return_data(1, '', '登录密码修改成功', '修改登录密码');
        }else{
            return return_data(2, '', '修改失败');
        }
    }

    public function 邀请好友(){
        if($this->user->invite_code == ''){
            $this->user->invite_code = create_captcha(10, 'lowercase+uppercase+figure');
            $this->user->save();
        }
        if($this->user->invite_qrcode == ''){
            $this->user->invite_qrcode = png_erwei('http://' . $_SERVER['HTTP_HOST'] . '/index/login/注册?invite_code=' . $this->user->invite_code, $this->user->phone);
            $this->user->save();
        }
        View::assign('content', SysAd::where('sign', '邀请规则')->value('content'));
        View::assign('image', SysAd::where('sign', '邀请好友页面头部图片')->value('image'));
        View::assign('link', 'http://' . $_SERVER['HTTP_HOST'] . '/index/login/注册?invite_code=' . $this->user->invite_code);
        return View::fetch();
    }

    public function 消息中心(){
        View::assign('msg', IdxUserMessage::where('user_id', $this->user_id)->order('id desc')->limit(100)->select());
        return View::fetch();
    }

    public function 消息详情(){
        $id = Request::instance()->param('id', 0);
        $detail = IdxUserMessage::find($id);
        $detail->is_read = 1;
        $detail->save();
        View::assign('detail', $detail);
        return View::fetch();
    }

    public function 意见反馈(){
        return View::fetch();
    }

    public function 意见反馈提交(){
        $content = Request::instance()->param('content');
        $res = IdxFeedback::create([
            'user_id'=> $this->user_id,
            'user_identity'=> $this->user->phone,
            'content'=> $content,
            'insert_time'=> date("Y-m-d H:i:s", time())
        ]);
        return $res ? return_data(1, '', '提交成功', '提交意见反馈') : return_data(2, '', '提交失败, 请稍后再试');
    }

    public function 设置(){
        return View::fetch();
    }

    public function 实名认证(){
        return View::fetch();
    }

    public function 实名认证提交(){
        $id_card_username = Request::instance()->param('id_card_username', '');
        $id_card_code = Request::instance()->param('id_card_code', '');
        $photo = Request::instance()->file('photo');
        $photo2 = Request::instance()->file('photo2');
        if($id_card_username == ''){
            return return_data(2, '', '请输入真实姓名');
        }
        if($id_card_code == ''){
            return return_data(2, '', '请输入身份证号');
        }
        if($photo){
            $image_res = file_upload($photo, 'card');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $id_card_front_img = $image_res['file_path'];
        }else{
            return return_data(2, '', '请上传身份证正面照片');
        }
        if($photo2){
            $image_res = file_upload($photo2, 'card');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $id_card_verso_img = $image_res['file_path'];
        }else{
            return return_data(2, '', '请上传身份证反面照片');
        }
        $user_data = IdxUserData::find($this->user_id);
        $user_data->id_card_username = $id_card_username;
        $user_data->id_card_code = $id_card_code;
        $user_data->id_card_front_img = $id_card_front_img;
        $user_data->id_card_verso_img = $id_card_verso_img;
        $res = $user_data->save();
        return $res ? return_data(1, '', '实名认证提交成功', '实名认证') : return_data(2, '', '实名认证提交失败, 请稍后再试');
    }

    public function 设置交易密码(){
        return View::fetch();
    }

    public function 设置交易密码提交(){
        $password = Request::instance()->param('password', '');
        $password_confirm = Request::instance()->param('password_confirm', '');
        $rule = "/^\d{6}$/";
        if(preg_match($rule, $password)){
            if($password != $password_confirm){
                return return_data(2, '', '输入的确认交易密码与交易密码不一致');
            }
            $this->user->level_password = $password;
            $res = $this->user->save();
            return $res ? return_data(1, '', '设置交易密码成功', '设置交易密码') : return_data(2, '', '设置交易密码失败, 请稍后重试');
        }else{
            return return_data(2, '', '交易密码必须是6位纯数字');
        }
    }

    public function 找回交易密码(){
        return View::fetch();
    }

    public function 找回交易密码提交(){
        $sms_code = Request::instance()->param('sms_code', '');
        $photo = Request::instance()->file('photo');
        if($sms_code != Session::get('sms_code')){
            return return_data(2, '', '手机验证码错误');
        }
        if($photo){
            $image_res = file_upload($photo, 'card');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $voucher = $image_res['file_path'];
        }else{
            return return_data(2, '', '请上传照片');
        }
        $res = IdxForGotPwd::create([
            'user_id'=> $this->user_id,
            'user_identity'=> $this->user->phone,
            'voucher'=> $voucher,
            'insert_time'=> date("Y-m-d H:i:s", time())
        ]);
        return $res ? return_data(1, '', '找回交易密码申请成功', '找回交易密码申请') : return_data(2, '', '找回交易密码申请失败, 请稍后再试');
    }
}