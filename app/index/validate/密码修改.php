<?php
namespace app\index\validate;

use think\facade\Session;
use think\Validate;

use app\admin\model\IdxUser;


class 密码修改 extends Validate{
    protected $rule = [
        'old_password'=> 'require|checkOldPassword',
        'password'=> 'require|confirm:password_confirm|checkPassword',
        'password_confirm'=> 'require',
    ];

    protected $message = [
        'old_password.require'=> '请输入旧密码',
        'password.require'=> '请输入新密码',
        'password.confirm'=> '重复密码与输入密码不一致',
    ];

    public function checkOldPassword($value, $rule, $data){
        $user = IdxUser::find(Session::get('user_id'));
        if(md5($value . $user->password_salt) != $user->password){
            return '旧登录密码输入错误';
        }
        return true;
    }

    public function checkPassword($value, $rule, $data){
        $rule = "/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/";
        if(preg_match($rule, $value)){
            return true;
        }else{
            return '输入密码不符合要求，6到20位数字和字母的组合';
        }
    }
}