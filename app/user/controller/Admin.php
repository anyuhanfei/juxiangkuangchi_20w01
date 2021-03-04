<?php
namespace app\user\controller;

use think\facade\View;
use think\facade\Session;
use think\facade\Request;
use think\facade\Cookie;

use app\admin\model\SysCatalog;
use app\admin\model\AdmAdmin;
use app\admin\model\AdmRole;
use app\admin\model\IdxUser;
use app\admin\model\SysModuleAction;

use app\user\controller\Base;
use think\facade\Cache;

class Admin extends Base{
    protected $admin = null;
    protected $middleware = [
        \app\user\middleware\CheckIndex::class,
    ];

    public function __construct(){
        //引用父类初始化方法
        parent::__construct();

        $this->users_id = Cache::get('users_id', '');
        if($this->users_id == ''){
            $users_id = array();
            $queue_down_user = array(Session::get('user_id'));
            while($queue_down_user != array()){
                $top_user_id = array_pop($queue_down_user);
                $users = IdxUser::where('top_id', $top_user_id)->select();
                foreach($users as $user){
                    $queue_down_user[] = $user->user_id;
                    $users_id[] = $user->user_id;
                }
            }
            Cache::set('users_id', $users_id, 1);
            $this->users_id = Cache::get('users_id', '');
        }
    }
}