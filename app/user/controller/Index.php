<?php
namespace app\user\controller;

use think\facade\View;

use app\user\controller\Admin;

class Index extends Admin{

    public function index(){
        return View::fetch();
    }
}