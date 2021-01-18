<?php
namespace app\admin\model;

use think\Model;


class IdxForGotPwd extends Model{
    protected $table = "idx_forgot_pwd";
    protected $pk = "id";

    public function getStatusTextAttr($value, $data){
        $res = ['申请中', '通过', '驳回'];
        return $res[$data['status']];
    }

    public function user(){
        return $this->hasOne('idx_user', 'user_id', 'user_id');
    }
}