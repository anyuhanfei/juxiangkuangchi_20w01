<?php
namespace app\admin\model;

use think\Model;


class IdxWithdraw extends Model{
    protected $table = "idx_withdraw";
    protected $pk = "id";

    public function user(){
        return $this->hasOne('idx_user', 'user_id', 'user_id');
    }

    public function getStatusTextAttr($value, $data){
        $res = ['申请中', '通过', '驳回'];
        return $res[$data['status']];
    }
}