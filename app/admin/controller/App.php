<?php
namespace app\admin\controller;

use think\facade\View;
use think\facade\Session;
use think\facade\Request;
use think\facade\Cookie;

use app\admin\model\SysCatalog;
use app\admin\model\AdmAdmin;
use app\admin\model\AdmRole;
use app\admin\model\SysModuleAction;

use app\admin\controller\Admin;
use app\admin\model\IdxActivity;
use app\admin\model\IdxFeedback;
use app\admin\model\IdxForGotPwd;
use app\admin\model\IdxMill;
use app\admin\model\IdxMillLease;
use app\admin\model\IdxUser;
use app\admin\model\IdxUserFund;
use app\admin\model\IdxUserMessage;
use app\admin\model\IdxUserMill;
use app\admin\model\IdxUserMillLease;
use app\admin\model\IdxWithdraw;
use app\admin\model\LogUserFund;

class App extends Admin{
    public function 活动(){
        $activity = new IdxActivity;
        $list = $activity->order('status desc')->order('id desc')->paginate($this->page_number, false,['query'=>request()->param()]);
        $this->many_assign(['list'=> $list]);
        return View::fetch();
    }

    public function 活动内容(){
        $id = Request::instance()->param('id', '');
        $activity = IdxActivity::find($id);
        if($activity){
            return return_data(1, $activity->内容, '');
        }else{
            return return_data(2, '', '');
        }
    }

    public function 活动添加(){
        return View::fetch();
    }

    public function 活动添加提交(){
        $标题 = Request::instance()->param('标题', '');
        $副标题 = Request::instance()->param('副标题', '');
        $活动时间 = Request::instance()->param('活动时间', '');
        $内容 = Request::instance()->param('内容', '');
        $列表图 = Request::instance()->file('列表图');
        if($标题 == '' && $活动时间 == '' && $内容 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $data = [];
        if($列表图){
            $image_res = file_upload($列表图, 'article');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $data['列表图'] = $image_res['file_path'];
        }else{
            return return_data(2, '', '请上传图片');
        }
        $data['首页图'] = '';
        $data['标题'] = $标题;
        $data['副标题'] = $副标题;
        $data['活动时间'] = $活动时间;
        $data['内容'] = $内容;
        $data['insert_time'] = date("Y-m-d H:i:s", time());
        $data['status'] = 0;
        $res = IdxActivity::create($data);
        if($res){
            return return_data(1, '', '添加成功', '活动添加：'.$标题);
        }else{
            if($data['列表图'] != ''){
                delete_image($data['列表图']);
            }
            if($data['首页图'] != ''){
                delete_image($data['首页图']);
            }
            return return_data(2, '', '添加失败，请联系管理员');
        }
    }

    public function 活动修改(){
        $id = Request::instance()->param('id', 0);
        $activity = IdxActivity::find($id);
        $has_data = "true";
        if(!$activity){
            $has_data = "false";
        }
        View::assign('has_data', $has_data);
        View::assign('detail', $activity);
        return View::fetch();
    }

    public function 活动修改提交(){
        $id = Request::instance()->param('id', 0);
        $标题 = Request::instance()->param('标题', '');
        $副标题 = Request::instance()->param('副标题', '');
        $活动时间 = Request::instance()->param('活动时间', '');
        $内容 = Request::instance()->param('内容', '');
        $列表图 = Request::instance()->file('列表图');
        if($标题 == '' && $活动时间 == '' && $内容 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $activity = IdxActivity::find($id);
        if(!$activity){
            return return_data(2, '', '非法操作');
        }
        if($列表图){
            $image_res = file_upload($列表图, 'article');
            if($image_res['status'] == 2){
                return return_data(2, '', $image_res['error']);
            }
            $activity->列表图 = $image_res['file_path'];
        }
        $activity->标题 = $标题;
        $activity->副标题 = $副标题;
        $activity->活动时间 = $活动时间;
        $activity->内容 = $内容;
        $activity->insert_time = date("Y-m-d H:i:s", time());
        $res = $activity->save();
        if($res){
            return return_data(1, '', '活动修改成功', '修改活动信息, 活动id为:' . $id);
        }else{
            return return_data(2, '', '活动修改失败');
        }
    }

    public function 活动状态(){
        $id = Request::instance()->param('id', 0);
        $status = Request::instance()->param('status', -1);
        if($status == -1){
            return return_data(2, '', '非法操作');
        }
        $activity = IdxActivity::find($id);
        if(!$activity){
            return return_data(2, '', '非法操作');
        }
        $activity->status = $status;
        $res = $activity->save();
        if($res){
            return return_data(1, $activity->status_text, '活动状态修改成功', '修改活动状态, 活动id为:' . $id);
        }else{
            return return_data(2, '', '活动状态修改失败');
        }
    }

    public function 意见反馈(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxFeedback;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        return View::fetch();
    }

    public function 意见反馈回复(){
        $id = Request::instance()->param('id', 0);
        $content = Request::instance()->param('content', '');
        if($content == ''){
            return return_data(2, '', '请输入回复内容');
        }
        $意见反馈 = IdxFeedback::find($id);
        if(!$意见反馈){
            return return_data(2, '', '非法操作');
        }
        $意见反馈->reply .= '<br/>' . $content;
        $res = $意见反馈->save();
        if($res){
            IdxUserMessage::create_data($意见反馈->user_id, '意见反馈回复', $content);
            return return_data(1, $意见反馈->reply, '回复成功', '意见反馈回复, 意见反馈id为:' . $id);
        }else{
            return return_data(2, '', '回复失败');
        }
    }

    public function 意见反馈状态(){
        $id = Request::instance()->param('id', 0);
        $意见反馈 = IdxFeedback::find($id);
        if(!$意见反馈){
            return return_data(2, '', '非法操作');
        }
        $意见反馈->status = 1;
        $res = $意见反馈->save();
        return $res ? return_data(1, '', '意见反馈设置为已解决成功', '意见反馈设置为已解决, 意见反馈id为:' . $id) : return_data(2, '', '意见反馈设置为已解决失败');
    }

    public function 会员消息(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $is_all = Request::instance()->param('is_all', '-1');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMessage;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($is_all != '-1') ? $obj->where('is_全局', $is_all) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'is_all'=> $is_all, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        return View::fetch();
    }

    public function 发送消息(){
        $title = Request::instance()->param('title', '');
        $content = Request::instance()->param('content', '');
        $user_id = Request::instance()->param('user_id', '');
        if($title == '' || $content == ''){
            return return_data(2, '', '消息标题和消息内容必须填写');
        }
        if($user_id == ''){
            //全局
            $users = IdxUser::field('user_id, phone')->select();
            foreach($users as $user){
                IdxUserMessage::create([
                    'user_id'=> $user->user_id,
                    'user_identity'=> $user->phone,
                    'title'=> $title,
                    'content'=> $content,
                    'insert_time'=> date("Y-m-d H:i:s", time()),
                    'is_全局'=> 1
                ]);
            }
        }else{
            //单人
            $user = IdxUser::find($user_id);
            if(!$user){
                return return_data(2, '', '此会员不存在');
            }
            IdxUserMessage::create_data($user_id, $title, $content);
        }
        return return_data(1, '', '发送成功');
    }

    public function 找回交易密码(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxForgotPwd;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        return View::fetch();
    }

    public function 找回交易密码审核(){
        $id = Request::instance()->param('id', '');
        $status = Request::instance()->param('status', '');
        $content = Request::instance()->param('content', '');
        $obj = IdxForGotPwd::find($id);
        if(!$obj){
            return return_data(2, '', '无此申请数据');
        }
        if($status == 1){
            //通过
            IdxUserMessage::create_data($obj->user_id, '找回交易密码申请通过', '管理员已审核通过了您的找回交易密码的申请, 您的交易密码为' . $obj->user->level_password . '。为保证您的密码安全, 请及时更新密码。');
        }else{
            //驳回
            if($content == ''){
                return return_data(2, '', '请填写驳回消息');
            }
            IdxUserMessage::create_data($obj->user_id, '找回交易密码申请驳回', $content);
        }
        $obj->status = $status;
        $res = $obj->save();
        return $res ? return_data(1, '', '操作成功', '找回交易密码审核, 数据ID为:' . $id) : return_data(2, '', '操作失败');
    }

    public function 提现(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxWithdraw;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        return View::fetch();
    }

    public function 提现审核(){
        $id = Request::instance()->param('id', '');
        $status = Request::instance()->param('status', '');
        $obj = IdxWithdraw::find($id);
        if(!$obj){
            return return_data(2, '', '无此申请数据');
        }
        if($status == 1){
            //打款
        }else{
            //返钱
            $user_fund = IdxUserFund::find($obj->user_id);
            $coin_type = $obj->coin_type;
            $user_fund->$coin_type += $obj->number;
            LogUserFund::create_data($obj->user_id, $obj->number, $obj->coin_type, '提现驳回', '提现申请被驳回');
        }
        $obj->status = $status;
        $res = $obj->save();
        if($res){
            return return_data(1, '', '操作成功', '提现申请审核, 数据ID为' . $id);
        }else{
            return return_data(2, '', '操作失败');
        }
    }

    public function mill(){
        View::assign('list', IdxMill::select());
        return View::fetch();
    }

    public function mill_add(){
        return View::fetch();
    }

    public function mill_add_submit(){
        $名称 = Request::instance()->param('名称', '');
        $单份存力 = Request::instance()->param('单份存力', '');
        $单份价格 = Request::instance()->param('单份价格', '');
        $合约周期 = Request::instance()->param('合约周期', '');
        $预计产出回报率 = Request::instance()->param('预计产出回报率', '');
        $日产出 = Request::instance()->param('日产出', '');
        $全周期收益 = Request::instance()->param('全周期收益', '');
        $剩余算力 = Request::instance()->param('剩余算力', '');
        if($名称 == '' && $单份存力 == '' && $单份价格 == '' && $合约周期 == '' && $预计产出回报率 == '' && $日产出 == '' && $剩余算力 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $data = [];
        $data['名称'] = $名称;
        $data['单份存力'] = $单份存力;
        $data['单份价格'] = $单份价格;
        $data['合约周期'] = $合约周期;
        $data['预计产出回报率'] = $预计产出回报率;
        $data['日产出'] = $日产出;
        $data['全周期收益'] = $全周期收益;
        $data['剩余算力'] = $剩余算力;
        $data['status'] = 0;
        $res = IdxMill::create($data);
        if($res){
            return return_data(1, '', '添加成功', '算力添加：'.$名称);
        }else{
            return return_data(2, '', '添加失败，请联系管理员');
        }
    }

    public function mill_update(){
        $id = Request::instance()->param('id', 0);
        $mill = IdxMill::find($id);
        $has_data = "true";
        if(!$mill){
            $has_data = "false";
        }
        View::assign('has_data', $has_data);
        View::assign('detail', $mill);
        return View::fetch();
    }

    public function mill_update_submit(){
        $id = Request::instance()->param('id', '');
        $名称 = Request::instance()->param('名称', '');
        $单份存力 = Request::instance()->param('单份存力', '');
        $单份价格 = Request::instance()->param('单份价格', '');
        $合约周期 = Request::instance()->param('合约周期', '');
        $预计产出回报率 = Request::instance()->param('预计产出回报率', '');
        $日产出 = Request::instance()->param('日产出', '');
        $全周期收益 = Request::instance()->param('全周期收益', '');
        $剩余算力 = Request::instance()->param('剩余算力', '');
        if($名称 == '' && $单份存力 == '' && $单份价格 == '' && $合约周期 == '' && $预计产出回报率 == '' && $日产出 == '' && $剩余算力 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $mill = IdxMill::find($id);
        if(!$mill){
            return return_data(2, '', '非法操作');
        }
        $mill->名称 = $名称;
        $mill->单份存力 = $单份存力;
        $mill->单份价格 = $单份价格;
        $mill->合约周期 = $合约周期;
        $mill->预计产出回报率 = $预计产出回报率;
        $mill->日产出 = $日产出;
        $mill->全周期收益 = $全周期收益;
        $mill->剩余算力 = $剩余算力;
        $res = $mill->save();
        if($res){
            return return_data(1, '', '算力修改成功', '修改算力信息, 算力id为:' . $id);
        }else{
            return return_data(2, '', '算力修改失败');
        }
    }

    public function mill_status(){
        $id = Request::instance()->param('id', 0);
        $status = Request::instance()->param('status', -1);
        if($status == -1){
            return return_data(2, '', '非法操作');
        }
        $mill = IdxMill::find($id);
        if(!$mill){
            return return_data(2, '', '非法操作');
        }
        $mill->status = $status;
        $res = $mill->save();
        if($res){
            return return_data(1, $mill->status_text, '算力状态修改成功', '修改算力状态, 算力id为:' . $id);
        }else{
            return return_data(2, '', '算力状态修改失败');
        }
    }

    public function 会员算力(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $mill_id = Request::instance()->param('mill_id', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMill;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($mill_id != '') ? $obj->where('mill_id', $mill_id) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'mill_id'=> $mill_id, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        View::assign('mills', IdxMill::select());
        return View::fetch();
    }

    public function mill租赁(){
        View::assign('list', IdxMillLease::select());
        return View::fetch();
    }

    public function mill租赁_add(){
        return View::fetch();
    }

    public function mill租赁_add_submit(){
        $名称 = Request::instance()->param('名称', '');
        $单份存力 = Request::instance()->param('单份存力', '');
        $单份价格 = Request::instance()->param('单份价格', '');
        $合约周期 = Request::instance()->param('合约周期', '');
        $开挖时间 = Request::instance()->param('开挖时间', '');
        $日产出展示 = Request::instance()->param('日产出展示', '');
        $日产出计算 = Request::instance()->param('日产出计算', '');
        $分币比例 = Request::instance()->param('分币比例', '');
        $剩余算力 = Request::instance()->param('剩余算力', '');
        if($名称 == '' && $单份存力 == '' && $单份价格 == '' && $合约周期 == '' && $开挖时间 == '' && $日产出展示 == '' && $日产出计算 == '' && $剩余算力 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $data = [];
        $data['名称'] = $名称;
        $data['单份存力'] = $单份存力;
        $data['单份价格'] = $单份价格;
        $data['合约周期'] = $合约周期;
        $data['开挖时间'] = $开挖时间;
        $data['日产出展示'] = $日产出展示;
        $data['日产出计算'] = $日产出计算;
        $data['分币比例'] = $分币比例;
        $data['剩余算力'] = $剩余算力;
        $data['status'] = 0;
        $res = IdxMillLease::create($data);
        if($res){
            return return_data(1, '', '添加成功', '算力添加：'.$名称);
        }else{
            return return_data(2, '', '添加失败，请联系管理员');
        }
    }

    public function mill租赁_update(){
        $id = Request::instance()->param('id', 0);
        $mill = IdxMillLease::find($id);
        $has_data = "true";
        if(!$mill){
            $has_data = "false";
        }
        View::assign('has_data', $has_data);
        View::assign('detail', $mill);
        return View::fetch();
    }

    public function mill租赁_update_submit(){
        $id = Request::instance()->param('id', '');
        $名称 = Request::instance()->param('名称', '');
        $单份存力 = Request::instance()->param('单份存力', '');
        $单份价格 = Request::instance()->param('单份价格', '');
        $合约周期 = Request::instance()->param('合约周期', '');
        $开挖时间 = Request::instance()->param('开挖时间', '');
        $日产出展示 = Request::instance()->param('日产出展示', '');
        $日产出计算 = Request::instance()->param('日产出计算', '');
        $分币比例 = Request::instance()->param('分币比例', '');
        $剩余算力 = Request::instance()->param('剩余算力', '');
        if($名称 == '' && $单份存力 == '' && $单份价格 == '' && $合约周期 == '' && $开挖时间 == '' && $日产出展示 == '' && $日产出计算 == '' && $剩余算力 == ''){
            return return_data(2, '', '有必填信息未填写');
        }
        $mill = IdxMillLease::find($id);
        if(!$mill){
            return return_data(2, '', '非法操作');
        }
        $mill->名称 = $名称;
        $mill->单份存力 = $单份存力;
        $mill->单份价格 = $单份价格;
        $mill->合约周期 = $合约周期;
        $mill->开挖时间 = $开挖时间;
        $mill->日产出展示 = $日产出展示;
        $mill->日产出计算 = $日产出计算;
        $mill->分币比例 = $分币比例;
        $mill->剩余算力 = $剩余算力;
        $res = $mill->save();
        if($res){
            return return_data(1, '', '算力修改成功', '修改算力信息, 算力id为:' . $id);
        }else{
            return return_data(2, '', '算力修改失败');
        }
    }

    public function mill租赁_status(){
        $id = Request::instance()->param('id', 0);
        $status = Request::instance()->param('status', -1);
        if($status == -1){
            return return_data(2, '', '非法操作');
        }
        $mill = IdxMillLease::find($id);
        if(!$mill){
            return return_data(2, '', '非法操作');
        }
        $mill->status = $status;
        $res = $mill->save();
        if($res){
            return return_data(1, $mill->status_text, '算力状态修改成功', '修改算力状态, 算力id为:' . $id);
        }else{
            return return_data(2, '', '算力状态修改失败');
        }
    }

    public function 会员租赁算力(){
        $user_id = Request::instance()->param('user_id', '');
        $user_identity = Request::instance()->param('user_identity', '');
        $mill_id = Request::instance()->param('mill_id', '');
        $start_time = Request::instance()->param('start_time', '');
        $end_time = Request::instance()->param('end_time', '');
        $obj = new IdxUserMillLease;
        $obj = ($user_id != '') ? $obj->where('user_id', $user_id) : $obj;
        $obj = ($user_identity != '') ? $obj->where('user_identity', $user_identity) : $obj;
        $obj = ($mill_id != '') ? $obj->where('mill_id', $mill_id) : $obj;
        $obj = $this->where_time($obj, $start_time, $end_time);
        $list = $obj->order('insert_time desc')->paginate(['list_rows'=> $this->page_number, 'query'=>Request()->param()]);
        $this->many_assign(['list'=> $list, 'user_id'=> $user_id, 'user_identity'=> $user_identity, 'mill_id'=> $mill_id, 'start_time'=> $start_time, 'end_time'=> $end_time]);
        View::assign('mills', IdxMillLease::select());
        return View::fetch();
    }
}