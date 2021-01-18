<?php
namespace app\index\controller;

use think\facade\Session;
use think\facade\View;

use app\admin\model\IdxUser;
use app\admin\model\IdxUserMill;
use app\admin\model\SysSetting;


class Mefund extends Index{
    public function 资产(){
        $user_mills = IdxUserMill::where('user_id', $this->user_id)->where('剩余周期', '>', 0)->select();
        $总资产 = $this->user->userfund->USDT;
        $收益 = 0;
        foreach($user_mills as $v){
            $总资产 += $v->总价;
            $收益 += $v->每日收益;
        }
        View::assign('zc', $总资产);
        View::assign('sy', $收益);
        View::assign('USDT2CNY', SysSetting::where('sign', 'USDT2CNY')->value('value'));
        return View::fetch();
    }

    public function 充值(){
        return View::fetch();
    }

    public function 提现(){
        return View::fetch();
    }
}