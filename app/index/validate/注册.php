<?php
namespace app\index\validate;

use think\Validate;
use think\facade\Session;

use app\admin\model\IdxUser;


class 注册 extends Validate{
    protected $rule = [
        'phone'=> 'require|checkPhone',
        'sms_code'=> 'require|checkSmsCode',
        'invite_code'=> 'checkInviteCode',
        'password'=> 'require|confirm:password_confirm|checkPassword',
        'password_confirm'=> 'require'
    ];

    protected $message = [
        'phone.require'=> '请填写手机号',
        'sms_code.require'=> '请填写短信验证码',
        // 'invite_code.require'=> '请填写推荐码',
        'password.require'=> '请填写登录密码',
        'password.confirm'=> '填写确认登录密码与登录密码不一致',
        'password_confirm.require'=> '请填写确认登录密码'
    ];

    public function checkPhone($value, $rule, $data){
        $rule = "/^(?:(?:\+|00)86)?1\d{10}$/";
        if(preg_match($rule, $value)){
            $user = IdxUser::where('phone', $value)->find();
            if($user){
                return '此手机号已被注册';
            }
            return true;
        }else{
            return '手机号格式不正确';
        }
    }

    public function checkSmsCode($value, $rule, $data){
        if(Session::get('sms_phone') != $data['phone']){
            return '短信验证码填写错误';
        }
        if(Session::get('sms_code') != $data['sms_code']){
            return '短信验证码填写错误';
        }
        return true;
    }

    public function checkInviteCode($value, $rule, $data){
        if($value != ''){
            $user = IdxUser::where('invite_code', $value)->find();
            if(!$user){
                return '无效邀请码';
            }
        }
        return true;
    }

    protected function checkPassword($value, $rule, $data){
        $rule = "/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/";
        if(preg_match($rule, $value)){
            return true;
        }else{
            return '输入密码不符合要求，6到20位数字和字母的组合';
        }
    }

    protected function checkLevelPassword($value, $rule, $data){
        $rule = "/^\d{6}$/";
        if(preg_match($rule, $value)){
            return true;
        }else{
            return '输入二级密码不符合要求，二级密码必须是6位纯数字';
        }
    }
}