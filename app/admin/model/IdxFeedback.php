<?php
namespace app\admin\model;

use think\Model;


class IdxFeedback extends Model{
    protected $table = "idx_feedback";
    protected $pk = "id";

    public function getStatusTextAttr($value, $data){
        $res = ['未解决', '已解决'];
        return $res[$data['status']];
    }
}