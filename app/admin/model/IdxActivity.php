<?php
namespace app\admin\model;

use think\Model;


class IdxActivity extends Model{
    protected $table = "idx_activity";
    protected $pk = "id";

    public function getStatusTextAttr($value, $data){
        $res = ['隐藏', '展示', '首页展示'];
        return $res[$data['status']];
    }
}