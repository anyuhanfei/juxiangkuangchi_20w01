<?php
use think\facade\Route;

// 首页模块
Route::get('/', 'user/index/index');

// 登录模块
Route::get('login', 'user/login/login');
Route::post('login/submit', 'user/login/login_submit');
Route::get('login/out', 'user/login/login_out');

Route::rule('app/会员列表', 'user/app/会员列表');
Route::rule('app/会员消息', 'user/app/会员消息');
Route::rule('app/持有单挖算力管理', 'user/app/持有单挖算力管理');
Route::rule('app/持有单挖租赁算力管理', 'user/app/持有单挖租赁算力管理');
Route::rule('app/会员地址管理', 'user/app/会员地址管理');
Route::rule('app/fil算力', 'user/app/fil算力');
Route::rule('app/fil云算力', 'user/app/fil云算力');
Route::rule('app/持有双挖算力管理', 'user/app/持有双挖算力管理');
Route::rule('app/持有双挖租赁算力管理', 'user/app/持有双挖租赁算力管理');