<?php
namespace app\user\controller;

use think\facade\View;
use think\facade\Session;
use think\facade\Request;
use think\facade\Cookie;
use think\facade\Env;

use app\admin\model\SysCatalog;
use app\admin\model\AdmAdmin;
use app\admin\model\AdmRole;
use app\admin\model\SysModuleAction;

use app\user\controller\Admin;
use app\admin\model\CollectLog;
use app\admin\model\IdxActivity;
use app\admin\model\IdxFeedback;
use app\admin\model\IdxForgotPwd;
use app\admin\model\IdxMill;
use app\admin\model\IdxMillLease;
use app\admin\model\IdxUser;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMessage;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxUserMillLease;
use app\admin\model\IdxWithdraw;
use app\admin\model\LogUserFund;
use app\admin\model\SysSetting;
use app\admin\model\TokenConfig;
use app\admin\model\UserAddr;
use app\admin\model\UserCharge;

class App extends Admin{
    public function 会员列表(){
        $nickname = Request::instance()->param('nickname', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $top_user_identity = Request::instance()->param('top_user_identity', '');
        $user = new IdxUser;
        $user = ($nickname != '') ? $user->where('nickname', 'like', '%' . $nickname . '%') : $user;
        $user = ($user_identity != '') ? $user->where($this->user_identity, 'like', '%'. $user_identity . '%') : $user;
        if($top_user_identity != ''){
            $top_id = IdxUser::where($this->user_identity, 'like', '%' . $top_user_identity . '%')->find();
            if($top_id){
            	$user = $user->where('top_id', $top_id->user_id);
            }
        }
        $list = $user->where('user_id', 'in', $this->users_id)->order('user_id desc')->paginate($this->page_number, false,['query'=>request()->param()]);
        $this->many_assign(['list'=> $list, 'nickname'=> $nickname, 'top_user_identity'=> $top_user_identity, 'search_user_identity'=> $user_identity]);
        View::assign('USDT', IdxUserFund::where('user_id', 'in', $this->users_id)->sum('USDT'));
        View::assign('FIL', IdxUserFund::where('user_id', 'in', $this->users_id)->sum('FIL'));
        View::assign('recharge', UserCharge::where('charge_type', 1)->where('user_id', 'in', $this->users_id)->sum('balance'));
        return View::fetch();
    }

    public function 会员消息(){
        $user_identity = Request::instance()->param('user_identity', '');
        $is_all = Request::instance()->param('is_all', '-1');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMessage;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($is_all != '-1') ? $obj->where('is_全局', $is_all) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->where('user_id', 'in', $this->users_id)->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_identity'=> $user_identity, 'is_all'=> $is_all, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        return View::fetch();
    }

    public function 持有单挖算力管理(){
        $user_identity = Request::instance()->param('user_identity', '');
        $mill_id = Request::instance()->param('mill_id', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMill;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($mill_id != '') ? $obj->where('mill_id', $mill_id) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->where('user_id', 'in', $this->users_id)->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_identity'=> $user_identity, 'mill_id'=> $mill_id, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        View::assign('mills', IdxMill::select());
        View::assign('all', IdxUserMill::where('user_id', 'in', $this->users_id)->sum('总价'));
        return View::fetch();
    }

    public function 持有单挖租赁算力管理(){
        $user_identity = Request::instance()->param('user_identity', '');
        $mill_id = Request::instance()->param('mill_id', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMillLease;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($mill_id != '') ? $obj->where('mill_id', $mill_id) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->where('user_id', 'in', $this->users_id)->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_identity'=> $user_identity, 'mill_id'=> $mill_id, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        View::assign('mills', IdxMillLease::select());
        View::assign('all', IdxUserMill::where('user_id', 'in', $this->users_id)->sum('总价'));
        return View::fetch();
    }

    public function 会员地址管理(){
        $log = new UserAddr;
        $list = $log->where('user_id', 'in', $this->users_id)->where('is_deleted', 0)->order('create_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list]);
        return View::fetch();
    }

    public function fil算力(){
        return View::fetch();
    }

    public function fil云算力(){
        return View::fetch();
    }

    public function 持有双挖算力管理(){
        return View::fetch();
    }

    public function 持有双挖租赁算力管理(){
        return View::fetch();
    }
}