<?php
namespace app\admin\model;

use think\Model;
use think\facade\Env;


class IdxUserMessage extends Model{
    protected $table = "idx_user_message";
    protected $pk = "id";

    public static function create_data($user_id, $title, $content, $insert_time=''){
        $user_identity_set = Env::get('ANER_ADMIN.USER_IDENTITY', 'phone');
        $user_identity = IdxUser::where('user_id', $user_id)->value($user_identity_set);
        $res = self::create([
            'user_id'=> $user_id,
            'user_identity'=> $user_identity,
            'title'=> $title,
            'content'=> $content,
            'insert_time'=> ($insert_time == '' ? date("Y-m-d H:i:s", time()) : $insert_time)
        ]);
    }

    public function getIsReadTextAttr($value, $data){
        $res = ['未读', '已读'];
        return $res[$data['is_read']];
    }
}