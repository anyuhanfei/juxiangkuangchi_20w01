<?php
namespace app\index\controller;

use think\facade\Session;
use think\facade\View;
use think\facade\Request;
use think\facade\Env;

use app\admin\model\IdxUser;
use app\admin\model\IdxUserFreezeFil;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxUserMillLease;
use app\admin\model\IdxWithdraw;
use app\admin\model\LogUserFund;
use app\admin\model\SysSetting;
use app\admin\model\UserCharge;
use think\facade\Db;

class Mefund extends Index{
    public function 资产(){
        $user_mills = IdxUserMill::where('user_id', $this->user_id)->where('剩余周期', '>', 0)->select();
        $user_mill_leases = IdxUserMillLease::where('user_id', $this->user_id)->where('剩余周期', '>', 0)->select();
        $总资产 = $this->user->userfund->USDT;
        $收益 = 0;
        foreach($user_mills as $v){
            $总资产 += $v->总价;
            $收益 += $v->每日收益;
        }
        foreach($user_mill_leases as $v){
            $总资产 += $v->总价;
            $收益 += $v->每日收益;
        }
        View::assign('zc', $总资产);
        View::assign('sy', $收益);
        View::assign('USDT2CNY', SysSetting::where('sign', 'USDT2CNY')->value('value'));
        View::assign('freeze_fil', IdxUserFreezeFil::where('user_id', $this->user_id)->where('释放周期', '<', 180)->where('剩余金额', '>', 0)->sum('剩余金额'));
        return View::fetch();
    }

    public function 记录(){
        View::assign('list', LogUserFund::where('user_id', $this->user_id)->where('coin_type', 'USDT')->order('id desc')->select());
        return View::fetch();
    }

    public function 充值(){
        if($this->user->address == ''){
            $kuake_ip = Env::get('ANER_ADMIN.KUAKE_IP');
            $url = "http://". $kuake_ip ."/tron/createAddress?userId=" . $this->user_id;
            $opts = array(
                'http'=>array(
                  'method'=>"GET",
                  "header"=> "Content-Type:application/x-www-form-urlencoded"
                )
            );
            $context = stream_context_create($opts);
            $res = json_decode(file_get_contents($url, false, $context));
            if($res->code == 200){
                $this->user->address = $res->data;
                $this->user->address_qrcode = png_erwei($this->user->taddress, $this->user->taddress);
                $this->user->save();
            }
        }
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
        $swift_no = 'sn' . date("YmdHis", time()) . rand(1000, 9999) . substr($this->user->phone, 7, 4);
        $withdraw_address = SysSetting::where('sign', 't_withdraw_address')->value('value');
        $res_two = UserCharge::create([
            'swift_no'=> $swift_no,
            'user_id'=> $this->user_id,
            'code'=> $coin_type,
            'balance'=> $number,
            'charge_type'=> 2,
            'poundage'=> 0,
            'create_time'=> date("Y-m-d H:i:s", time()),
            'coin_type'=> 3,
            'to_addr'=> $address,
            'from_address'=> $withdraw_address,
            'remark'=> $remark
        ]);
        if($res_one && $res_two){
            LogUserFund::create_data($this->user_id, '-' . $number, $coin_type, '提现', '提现');
            Db::commit();
            ######################################################################################
            $withdraw_address_key = SysSetting::where('sign', 'withdraw_address_key')->value('value');
            $withdraw_address = SysSetting::where('sign', 'withdraw_address')->value('value');
            $kuake_ip = Env::get('ANER_ADMIN.KUAKE_IP');
            $url = "http://". $kuake_ip ."/wallet/send?code=".$coin_type."&balance=".$number."&from=".$withdraw_address."&privateKey=".$withdraw_address_key."&to=".$address.'&type=1';
            $opts = array(
                'http'=>array(
                'method'=>"POST",
                )
            );
            $context = stream_context_create($opts);
            $res = json_decode(file_get_contents($url, false, $context));
            if($res->code == 200){
                $withdraw = UserCharge::where('swift_no', $swift_no)->find();
                $withdraw->inspect_time = date("Y-m-d H:i:s", time());
                $withdraw->inspect_status = 1;
                $withdraw->hash = $res->data;
                $withdraw->save();
                return return_data(1, '', '提现申请成功, 自动审核通过, 请稍后查询余额', '提现');
            }else{
                return return_data(1, '', '提现申请成功', '提现');
            }
            ##################################################################################
            # return return_data(1, '', '提现申请成功', '提现申请');
        }else{
            Db::rollback();
            return return_data(2, '', '提现申请失败, 请稍后重试');
        }
    }
}