<?php
namespace app\index\controller;

use think\facade\Session;
use think\facade\View;
use think\facade\Request;

use app\admin\model\IdxUser;
use app\admin\model\SysAd;
use app\admin\model\CmsArticle;
use app\admin\model\IdxActivity;
use app\admin\model\IdxMill;
use app\admin\model\SysSetting;
use app\admin\model\AutoValue;

class Index extends Base{
    protected $user = null;
    protected $middleware = [
        \app\index\middleware\CheckIndex::class,
        \app\index\middleware\LogOperation::class,
    ];

    public function __construct(){
        parent::__construct();
        $this->user_id = Session::get('user_id');
        $this->user = IdxUser::find($this->user_id);
        View::assign('user_id', $this->user_id);
        View::assign('user', $this->user);
    }

    public function index(){
        return redirect('/index/首页');
    }

    public function 首页(){
        //banner
        View::assign('banners', SysAd::where('sign', 'banner')->select());
        //公告
        View::assign('notice', CmsArticle::where('category_id', 1)->order('article_id desc')->value('title'));
        //活动
        View::assign('active', IdxActivity::where('status', 2)->limit(3)->select());
        //算力
        View::assign('mills', IdxMill::where('status', 1)->select());
        //币种价格
        View::assign('USDT2CNY', SysSetting::where('sign', 'USDT2CNY')->value('value'));
        $btc = AutoValue::find(1);
        $eth = AutoValue::find(2);
        $fil = AutoValue::find(3);
        $eos = AutoValue::find(4);
        $trx = AutoValue::find(5);
        View::assign('btc', $btc);
        View::assign('eth', $eth);
        View::assign('fil', $fil);
        View::assign('eos', $eos);
        View::assign('trx', $trx);
        if($btc){
            if(intval($btc->insert_time) < time() - 100){
                exec('python ./python/get_data.py');
            }
        }else{
            exec('python ./python/get_data.py');
        }
        return View::fetch();
    }

    public function 资讯(){
        View::assign('news', CmsArticle::order('article_id desc')->select());
        return View::fetch();
    }

    public function 详情(){
        $id = Request::instance()->param('id', 0);
        View::assign('detail', CmsArticle::find($id));
        return View::fetch();
    }

    public function 活动(){
        View::assign('ac', IdxActivity::where('status', '>=', 1)->order('id desc')->select());
        return View::fetch();
    }

    public function 活动详情(){
        $id = Request::instance()->param('id', 0);
        View::assign('detail', IdxActivity::find($id));
        return View::fetch();
    }

    public function 帮助(){
        return View::fetch();
    }


    public function 关于我们(){
        View::assign('b', SysSetting::where('sign', '版本号')->value('value'));
        return View::fetch();
    }

    public function 公司介绍(){
        View::assign('content', SysAd::where('sign', '公司介绍')->value('content'));
        return View::fetch();
    }

    public function 协议与声明(){
        View::assign('content', SysAd::where('sign', '协议与声明')->value('content'));
        return View::fetch();
    }

    public function 内容详情(){
        $sign = Request::instance()->param('sign', '');
        View::assign('content', SysAd::where('sign', $sign)->value('content'));
        View::assign('sign', $sign);
        return View::fetch();
    }
}