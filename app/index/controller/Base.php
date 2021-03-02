<?php
namespace app\index\controller;

use think\facade\Session;

use app\admin\model\IdxUser;
use app\admin\model\IdxUserCount;
use app\admin\model\IdxUserFreezeFil;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxUserMillLease;
use app\admin\model\LogUserFund;
use app\admin\model\SysSetting;

class Base{
    public function __construct(){

    }

    public function sendsms($phone, $type){
        $user = IdxUser::where('phone', $phone)->find();
        switch ($type) {
            case 'login':
                if(!$user){
                    return return_data(2, '', '此手机号未被注册');
                }
                break;
            case 'register':
                if($user){
                    return return_data(2, '', '此手机号已被注册');
                }
                break;
            case 'forget':
                if(!$user){
                    return return_data(2, '', '此手机号未被注册');
                }
                break;
            default:
                return return_data(2, '', '非法操作');
        }
        $code = create_captcha(6);
        // 发短信
        $this->send_sms($phone, $code);
        // 保存信息
        Session::set('sms_phone', $phone);
        Session::set('sms_code', $code);
        return return_data(1, '', '发送成功');
    }

    public function send_sms($phone, $code=''){
        $post_data = array();
        $post_data['userid'] = 4485;
        $post_data['account'] = 'qx5189';
        $post_data['password'] = 'jx18280186061';
        $post_data['content'] = '【炬象】您的短信验证码为：' . $code;
        $post_data['mobile'] = $phone;
        $post_data['sendtime'] = date("Y-m-d H:i:s", time());
        $url='http://120.25.105.164:8888/sms.aspx?action=send';
        $o='';
        foreach ($post_data as $k=>$v)
        {
        $o.="$k=".urlencode($v).'&';
        }
        $post_data=substr($o,0,-1);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $res = curl_exec($ch);
    }

    public function 算力收益(){
        //获取当日FIL汇率 USDT:FIL
        $USDT2FIL = SysSetting::where('sign', 'USDT2FIL')->value('value');

        //单挖算力
        //获取所有有效算力
        $mills = IdxUserMill::where('剩余周期', '>', 0)->select();
        //将有效算力以会员id分组
        $user_mills = [];
        foreach($mills as $v){
            $user_mills[$v->user_id][] = $v;
        }
        //所有有效算力扣除一天周期, 更新最后一次收益时间
        foreach($mills as $v){
            $v->剩余周期 -= 1;
            $v->总产出 += $v->每日收益;
            $v->operation_time = date("Y-m-d", time());
            $v->save();
        }
        //循环会员id, 分别向每个会员发放收益
        foreach($user_mills as $k=>$user_mill){
            $user_fund = IdxUserFund::find($k);
            $user_count = IdxUserCount::find($k);
            foreach($user_mill as $v){
                $add_fil = $v->每日收益 * $USDT2FIL;
                $user_fund->FIL += $add_fil * 0.25;
                $user_count->累计收益 += $add_fil * 0.25;
                LogUserFund::create_data($k, $add_fil * 0.25, 'FIL', '算力收益', '算力收益');
                $res = IdxUserFreezeFil::create([
                    'user_id'=> $v->user_id,
                    '冻结总数'=> $add_fil * 0.75,
                    '剩余金额'=> $add_fil * 0.75,
                    'insert_time'=> date("Y-m-d H:i:s", time())
                ]);
            }
            $user_fund->save();
            $user_count->save();
        }

        //单挖租赁
        $mills = IdxUserMillLease::where('剩余周期', '>', 0)->select();
        foreach($mills as $k => $v){
            if(strtotime($v->insert_time) > time()){
                unset($mills[$k]);
            }
        }
        $user_mills = [];
        foreach($mills as $v){
            $user_mills[$v->user_id][] = $v;
        }
        foreach($mills as $v){
            $v->剩余周期 -= 1;
            $v->总产出 += $v->每日收益;
            $v->operation_time = date("Y-m-d", time());
            $v->save();
        }
        foreach($user_mills as $k=>$user_mill){
            $user_fund = IdxUserFund::find($k);
            $user_count = IdxUserCount::find($k);
            foreach($user_mill as $v){
                $add_fil = $v->每日收益 * $USDT2FIL;
                $user_fund->FIL += $add_fil * 0.25;
                $user_count->累计收益 += $add_fil * 0.25;
                LogUserFund::create_data($k, $add_fil * 0.25, 'FIL', '算力收益', '算力收益');
                $res = IdxUserFreezeFil::create([
                    'user_id'=> $v->user_id,
                    '冻结总数'=> $add_fil * 0.75,
                    '剩余金额'=> $add_fil * 0.75,
                    'insert_time'=> date("Y-m-d H:i:s", time())
                ]);
            }
            $user_fund->save();
            $user_count->save();
        }

        # 冻结金额释放
        $freeze_fils = IdxUserFreezeFil::where('释放周期', '<', 180)->where('剩余金额', '>', 0)->select();
        $user_freeze_fils = [];
        foreach($freeze_fils as $v){
            $user_freeze_fils[$v->user_id][] = $v;
        }
        foreach($user_freeze_fils as $k=>$user_freeze_fil){
            $user_fund = IdxUserFund::find($k);
            $user_count = IdxUserCount::find($k);
            foreach($user_freeze_fil as $v){
                $money = $v->冻结总数 / 180;
                $user_fund->FIL += $money;
                $user_count->累计收益 += $money;
                LogUserFund::create_data($k, $money, 'FIL', '冻结FIL释放', '冻结FIL释放');
                $v->剩余金额 = $v->剩余金额 - $money > 0 ? $v->剩余金额 - $money : 0;
                $v->释放周期 += 1;
                $v->save();
            }
            $user_fund->save();
            $user_count->save();
        }
    }
}