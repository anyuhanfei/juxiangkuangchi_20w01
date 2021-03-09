<?php
namespace app\admin\model;

use think\Model;


class IdxUserMill extends Model{
    protected $table = "idx_user_mill";
    protected $pk = "mill_id";

    public function user(){
        return $this->hasOne('idx_user', 'user_id', 'user_id');
    }

    public function mill(){
        return $this->hasOne('idx_mill', 'mill_id', 'mill_id');
    }
}