<?php
namespace app\index\controller;

use think\facade\Session;
use think\facade\View;
use think\facade\Request;
use think\facade\Db;

use app\admin\model\IdxUser;
use app\admin\model\IdxMill;
use app\admin\model\IdxUserCount;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMill;
use app\admin\model\LogUserFund;
use app\admin\model\SysAd;
use app\admin\model\SysSetting;


class Mill extends Index{
    public function 单挖算力(){
        View::assign('mills', IdxMill::select());
        return View::fetch();
    }

    public function 双挖算力(){
        return View::fetch();
    }

    public function 矿机详情(){
        $id = Request::instance()->param('id', '');
        View::assign('mill', IdxMill::find($id));
        View::assign('s', SysAd::where('sign', '算力说明')->value('content'));
        View::assign('f', SysAd::where('sign', '算力风险')->value('content'));
        return View::fetch();
    }

    public function 支付(){
        $id = Request::instance()->param('id', '');
        View::assign('mill', IdxMill::find($id));
        View::assign('xy', SysAd::where('sign', 'IPFS云算力服务销售及托管协议')->value('content'));
        return View::fetch();
    }

    public function 支付提交(){
        $id = Request::instance()->param('id', '');
        $number = Request::instance()->param('number', '');
        $level_password = Request::instance()->param('level_password', '');
        $mill = IdxMill::find($id);
        if(!$mill || $mill->status != 1){
            return return_data(2, '', '当前算力未开放');
        }
        if($level_password != $this->user->level_password){
            return return_data(3, '', '');
        }
        if($mill->剩余算力 < $number){
            return return_data(2, '', '剩余算力不足');
        }
        $user_fund = IdxUserFund::find($this->user_id);
        $all_price = $mill->单份价格 * $number;
        if($user_fund->USDT < $all_price){
            return return_data(2, '', 'USDT不足');
        }
        Db::startTrans();
        $user_fund->USDT -= $all_price;
        $user_fund->save();
        $res = IdxUserMill::create([
            'user_id'=> $this->user_id,
            'user_identity'=> $this->user->phone,
            'mill_id'=> $id,
            'number'=> $number,
            '总价'=> $all_price,
            '剩余周期'=> $mill->合约周期,
            'insert_time'=> date("Y-m-d", time()),
            'operation_time'=> date("Y-m-d", time()),
            '每日收益'=> $mill->日产出 * $number,
            '总算力'=> $mill->单份存力 * $number
        ]);
        if($res){
            LogUserFund::create_data($this->user_id, $all_price, 'USDT', '购买算力', '购买' . $mill->名称 . $number . '份');
            Db::commit();
            return return_data(1, '', '支付成功', '购买算力');
        }else{
            Db::rollback();
            return return_data(2, '', '支付失败, 请稍后再试');
        }
    }

    public function 算力产出(){
        View::assign('mymills', IdxUserMill::where('剩余周期', '>', 0)->order('id desc')->select());
        View::assign('USDT2FIL', SysSetting::where('sign', 'USDT2FIL')->value('value'));
        return View::fetch();
    }

    public function 我的算力(){
        $mymills = IdxUserMill::where('剩余周期', '>', 0)->order('id desc')->select();
        $有效算龄 = 0;
        foreach($mymills as $v){
            $有效算龄 += $v->mill->单份存力 * $v->number;
        }
        $user_count = IdxUserCount::find($this->user_id);
        if($user_count->历史最高算龄 < $有效算龄){
            $user_count->历史最高算龄 = $有效算龄;
            $user_count->save();
        }
        View::assign('yx', $有效算龄);
        View::assign('mymills', $mymills);
        View::assign('max_yx', $user_count->历史最高算龄);
        View::assign('lj', $user_count->累计收益);
        return View::fetch();
    }
}