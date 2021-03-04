<?php
namespace app\user\controller;

use think\facade\Env;
use think\facade\Session;
use think\facade\View;


class Base{
    public function __construct(){
        //列表分页每页数据量
        $this->page_number = Env::get('ANER_ADMIN.PAGE_DATA_NUMBER');

        /*会员*/
        //会员标识，用于会员与其他表之间的关联标识（user_id是计算机识别的关联标识，此设置为会员识别的关联标识）
        $this->user_identity = Env::get('ANER_ADMIN.USER_IDENTITY');
        View::assign('user_identity', $this->user_identity);
        //会员唯一标识说明
        $this->user_identity_text = Env::get('ANER_ADMIN.USER_IDENTITY_TEXT');
        View::assign('user_identity_text', $this->user_identity_text);
        //会员资金种类，key为资金类型说明，value为字段名
        $this->user_fund_type = $this->env_array('USER_FUND_TYPE');
        View::assign("user_fund_type", $this->user_fund_type);
        //会员删除操作的开关
        $this->user_delete_onoff = boolval(Env::get('ANER_ADMIN.USER_DELETE_ONOFF'));
    }

    /**
     * 处理 env 文件中的类似数组的配置
     *
     * @param [type] $name 配置名称
     * @return void
     */
    public function env_array($name){
        $set_str =  Env::get('ANER_ADMIN.' . $name);
        $temp = explode(', ', $set_str);
        $res_array = [];
        foreach($temp as $v){
            $temp_v = explode('=> ', $v);
            $res_array[$temp_v[0]] = $temp_v[1];
        }
        return $res_array;
    }

    /**
     * 多数据渲染
     *
     * @param array $assign_array
     * @return void
     */
    public function many_assign($assign_array = array()){
        foreach($assign_array as $k => $v){
            View::assign($k, $v);
        }
    }

    /**
     * 时间检索
     *
     * @param [type] $model 模型实例化对象
     * @param [type] $start_time 检索起始时间
     * @param [type] $end_time 检索结束时间
     * @return void
     */
    public function where_time($model, $start_time, $end_time, $time_field='insert_time'){
        if($start_time != '' && $end_time == ''){
            $model = $model->where($time_field, '>= time', $start_time);
        }elseif($start_time == '' && $end_time != ''){
            $model = $model->where($time_field, '<= time', $end_time);
        }elseif($start_time != '' && $end_time != ''){
            $model = $model->where($time_field, 'between time', [$start_time, $end_time]);
        }
        return $model;
    }
}