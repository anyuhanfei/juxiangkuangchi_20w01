<?php
namespace app\index\controller;

use think\facade\View;
use think\facade\Request;
use think\facade\Session;

use app\index\controller\Base;

use app\admin\model\IdxUser;
use app\admin\model\SysAd;

class Login extends Base{
    public function __construct(){
        View::assign('detail', SysAd::where('sign', '注册协议')->value('content'));
    }

    public function login(){
        return redirect('/index/login/密码登录');
    }

    public function 密码登录(){
        return View::fetch();
    }

    public function 验证码登录(){
        return View::fetch();
    }

    public function 登录提交(){
        $type = Request::instance()->param('type', '');
        if($type != '密码登录' && $type != '验证码登录'){
            return return_data(2, '', '非法操作');
        }
        $phone = Request::instance()->param('phone', '');
        $user = IdxUser::where('phone', $phone)->find();
        if(!$user){
            return return_data(2, '', '当前手机号未注册');
        }
        if($type == '密码登录'){
            $password = Request::instance()->param('password', '');
            if($user->password != md5($password . $user->password_salt)){
                return return_data(3, '', '');
            }
        }elseif($type == '验证码登录'){
            $sms_code = Request::instance()->param('sms_code', '');
            if($sms_code != Session::get('sms_code') || $phone != Session::get('sms_phone')){
                return return_data(2, '', '手机验证码错误');
            }
        }
        Session::set('user_id', $user->user_id);
        return return_data(1, '', '登录成功', '登录');
    }

    public function 找回密码1(){
        return View::fetch();
    }

    public function 找回密码2(){
        return View::fetch();
    }

    public function 找回密码提交(){
        $type = Request::instance()->param('type', '');
        if($type != '找回密码1' && $type != '找回密码2'){
            return return_data(2, '', '非法操作');
        }
        if($type == '找回密码1'){
            $phone = Request::instance()->param('phone', '');
            $user = IdxUser::where('phone', $phone)->find();
            if(!$user){
                return return_data(2, '', '当前手机号未注册');
            }
            $sms_code = Request::instance()->param('sms_code', '');
            if($sms_code != Session::get('sms_code') || $phone != Session::get('sms_phone')){
                return return_data(2, '', '手机验证码错误');
            }
            Session::set('forget_password_phone', $phone);
            return return_data(1, '', '验证成功, 进入下一步');
        }else{
            $phone = Session::get('forget_password_phone');
            $user = IdxUser::where('phone', $phone)->find();
            if(!$user){
                return return_data(2, '', '当前手机号未注册');
            }
            $password = Request::instance()->param('password', '');
            $password_confirm = Request::instance()->param('password', '');
            if($password != $password_confirm){
                return return_data(2, '', '确认密码与密码不一致');
            }
            $user->password = md5($password . $user->password_salt);
            $res = $user->save();
            return $res ? return_data(1, '', '密码修改成功') : return_data(2, '', '操作失败, 请稍后重试');
        }
    }

    public function 注册(){
        $invite_code = Request::instance()->param('invite_code', '');
        View::assign('invite_code', $invite_code);
        return View::fetch();
    }

    public function 注册提交(){
        $phone = Request::instance()->param('phone', '');
        $sms_code = Request::instance()->param('sms_code', '');
        $password = Request::instance()->param('password', '');
        $password_confirm = Request::instance()->param('password_confirm', '');
        $invite_code = Request::instance()->param('invite_code', '');
        $validate = new \app\index\validate\注册();
        if(!$validate->check(['phone'=> $phone, 'sms_code'=> $sms_code, 'invite_code'=> $invite_code, 'password'=> $password, 'password_confirm'=> $password_confirm])){
            return return_data(2, '', $validate->getError());
        }
        $top_id = $invite_code != '' ? IdxUser::where('invite_code', $invite_code)->value('user_id') : 0;
        $res = IdxUser::create_data($phone, $password, $top_id, '', '');
        Session::delete('sms_phone');
        Session::delete('sms_code');
        if($res){
            return return_data(1, '', '注册成功');
        }else{
            return return_data(2, '', '注册失败');
        }
    }

    public function 退出登录(){
        Session::delete('user_id');
        return redirect('/');
    }
}