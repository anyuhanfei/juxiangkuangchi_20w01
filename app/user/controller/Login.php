<?php
namespace app\user\controller;

use think\facade\View;
use think\facade\Request;
use think\facade\Session;

use app\user\controller\Base;

use app\admin\model\AdmFreezeIp;
use app\admin\model\LogAdminOperation;
use app\admin\model\AdmAdminLogin;
use app\admin\model\IdxUser;

class Login extends Base{
    /**
     * 登录页面
     *
     * @return void
     */
    public function login(){
        return View::fetch();
    }

    /**
     * 登录操作
     *
     * @return void
     */
    public function login_submit(){
        $phone = Request::instance()->param('account', '');
        $user = IdxUser::where('phone', $phone)->find();
        if(!$user){
            return return_data(2, '', '当前手机号未注册');
        }
        $password = Request::instance()->param('password', '');
        if($user->password != md5($password . $user->password_salt)){
            return return_data(3, '', '');
        }
        Session::set('user_id', $user->user_id);
        return return_data(1, '', '登录成功', '登录');
    }

    public function login_out(){
        Session::delete('user_id');
        return redirect('/user/login');
    }
}