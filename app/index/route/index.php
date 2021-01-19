<?php
use think\facade\Route;

Route::post('/sms/:phone/:type', 'index/base/sendsms');

Route::rule('/算力收益', 'index/base/算力收益');


// 首页
Route::rule('/', 'index/index/index');
Route::rule('/首页', 'index/index/首页');
Route::rule('/资讯', 'index/index/资讯');
Route::rule('/详情', 'index/index/详情');
Route::rule('/活动', 'index/index/活动');
Route::rule('/活动详情', 'index/index/活动详情');
Route::rule('/帮助', 'index/index/帮助');
Route::rule('/关于我们', 'index/index/关于我们');
Route::rule('/公司介绍', 'index/index/公司介绍');
Route::rule('/协议与声明', 'index/index/协议与声明');
Route::rule('/内容详情', 'index/index/内容详情');


// 登录
Route::rule('/login', 'index/login/login');
Route::rule('/login/密码登录', 'index/login/密码登录');
Route::rule('/login/验证码登录', 'index/login/验证码登录');
Route::rule('/login/登录提交', 'index/login/登录提交');
Route::rule('/login/找回密码1', 'index/login/找回密码1');
Route::rule('/login/找回密码2', 'index/login/找回密码2');
Route::rule('/login/找回密码提交', 'index/login/找回密码提交');
Route::rule('/login/注册', 'index/login/注册');
Route::rule('/login/注册提交', 'index/login/注册提交');
Route::rule('/login/退出登录', 'index/login/退出登录');

//矿机
Route::rule('/mill/单挖算力', 'index/mill/单挖算力');
Route::rule('/mill/双挖算力', 'index/mill/双挖算力');
Route::rule('/mill/矿机详情', 'index/mill/矿机详情');
Route::rule('/mill/支付', 'index/mill/支付');
Route::rule('/mill/支付提交', 'index/mill/支付提交');
Route::rule('/mill/算力产出', 'index/mill/算力产出');
Route::rule('/mill/我的算力', 'index/mill/我的算力');

Route::rule('/mill/租赁矿机详情', 'index/mill/租赁矿机详情');
Route::rule('/mill/租赁矿机支付', 'index/mill/租赁矿机支付');
Route::rule('/mill/租赁矿机支付提交', 'index/mill/租赁矿机支付提交');

//我的
Route::rule('/me', 'index/me/我的');
Route::rule('/me/个人中心', 'index/me/个人中心');
Route::rule('/me/修改昵称', 'index/me/修改昵称');
Route::rule('/me/修改昵称提交', 'index/me/修改昵称提交');
Route::rule('/me/修改头像提交', 'index/me/修改头像提交');
Route::rule('/me/修改登录密码', 'index/me/修改登录密码');
Route::rule('/me/修改登录密码提交', 'index/me/修改登录密码提交');
Route::rule('/me/邀请好友', 'index/me/邀请好友');
Route::rule('/me/消息中心', 'index/me/消息中心');
Route::rule('/me/消息详情', 'index/me/消息详情');
Route::rule('/me/意见反馈', 'index/me/意见反馈');
Route::rule('/me/意见反馈提交', 'index/me/意见反馈提交');
Route::rule('/me/设置', 'index/me/设置');
Route::rule('/me/实名认证', 'index/me/实名认证');
Route::rule('/me/实名认证提交', 'index/me/实名认证提交');
Route::rule('/me/设置交易密码', 'index/me/设置交易密码');
Route::rule('/me/设置交易密码提交', 'index/me/设置交易密码提交');
Route::rule('/me/找回交易密码', 'index/me/找回交易密码');
Route::rule('/me/找回交易密码提交', 'index/me/找回交易密码提交');

//我的资产
Route::rule('/me/资产', 'index/mefund/资产');
Route::rule('/me/充值', 'index/mefund/充值');
Route::rule('/me/提现', 'index/mefund/提现');
Route::rule('/me/提现提交', 'index/mefund/提现提交');