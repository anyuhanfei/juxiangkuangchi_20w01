<?php
namespace app\index\controller;

use think\facade\Session;
use think\facade\View;
use think\facade\Request;

use app\admin\model\IdxUser;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxWithdraw;
use app\admin\model\LogUserFund;
use app\admin\model\SysSetting;
use think\facade\Db;

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

    public function 提现提交(){
        $coin_type = Request::instance()->param('coin_type', '');
        $address = Request::instance()->param('address', '');
        $remark = Request::instance()->param('remark', '');
        $number = Request::instance()->param('number', '');
        if($coin_type == '' || $address == '' || $number == ''){
            return return_data(2, '', '请正确填写信息');
        }
        if($number < SysSetting::where('sign', $coin_type . '最小提现额度')->value('value')){
            return return_data(2, '', '未达到最小提现额度');
        }
        $user_fund = IdxUserFund::find($this->user_id);
        if($user_fund->$coin_type < $number){
            return return_data(2, '', '余额不足');
        }
        Db::startTrans();
        $user_fund->$coin_type -= $number;
        $res_one = $user_fund->save();
        $res_two = IdxWithdraw::create([
            'user_id'=> $this->user_id,
            'user_identity'=> $this->user->phone,
            'coin_type'=> $coin_type,
            'address'=> $address,
            'remark'=> $remark,
            'number'=> $number,
            'fee'=> 0,
            'insert_time'=> date("Y-m-d H:i:s", time())
        ]);
        if($res_one && $res_two){
            LogUserFund::create_data($this->user_id, '-' . $number, $coin_type, '提现', '提现');
            Db::commit();
            return return_data(1, '', '提现申请成功', '提现申请');
        }else{
            Db::rollback();
            return return_data(2, '', '提现申请失败, 请稍后重试');
        }
    }
}