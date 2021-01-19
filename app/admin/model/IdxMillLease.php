<?php
namespace app\admin\model;

use think\Model;


class IdxMillLease extends Model{
    protected $table = "idx_mill_lease";
    protected $pk = "mill_id";

    public function getStatusTextAttr($value, $data){
        $res = ['下架', '上架'];
        return $res[$data['status']];
    }
}