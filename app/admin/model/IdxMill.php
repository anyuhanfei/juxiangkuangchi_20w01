<?php
namespace app\admin\model;

use think\Model;


class IdxMill extends Model{
    protected $table = "idx_mill";
    protected $pk = "mill_id";

    public function getStatusTextAttr($value, $data){
        $res = ['下架', '上架'];
        return $res[$data['status']];
    }
}