<?php
use think\facade\Route;


//活动
Route::rule('app/活动', '/admin/app/活动');
Route::rule('app/活动内容', '/admin/app/活动内容');
Route::rule('app/活动添加', '/admin/app/活动添加');
Route::rule('app/活动添加提交', '/admin/app/活动添加提交');
Route::rule('app/活动修改', '/admin/app/活动修改');
Route::rule('app/活动修改提交', '/admin/app/活动修改提交');
Route::rule('app/活动状态', '/admin/app/活动状态');

//意见反馈
Route::rule('app/意见反馈', '/admin/app/意见反馈');
Route::rule('app/意见反馈回复', '/admin/app/意见反馈回复');
Route::rule('app/意见反馈状态', '/admin/app/意见反馈状态');

//会员消息
Route::rule('app/会员消息', '/admin/app/会员消息');
Route::rule('app/发送消息', '/admin/app/发送消息');

//找回交易密码
Route::rule('app/找回交易密码', '/admin/app/找回交易密码');
Route::rule('app/找回交易密码审核', '/admin/app/找回交易密码审核');

//提现
Route::rule('app/提现', '/admin/app/提现');
Route::rule('app/提现审核', '/admin/app/提现审核');

//矿机
Route::rule('app/mill', '/admin/app/mill');
Route::rule('app/mill_add', '/admin/app/mill_add');
Route::rule('app/mill_add_submit', '/admin/app/mill_add_submit');
Route::rule('app/mill_update', '/admin/app/mill_update');
Route::rule('app/mill_update_submit', '/admin/app/mill_update_submit');
Route::rule('app/mill_status', '/admin/app/mill_status');

Route::rule('app/会员算力', '/admin/app/会员算力');

Route::rule('app/mill租赁', '/admin/app/mill租赁');
Route::rule('app/mill租赁_add', '/admin/app/mill租赁_add');
Route::rule('app/mill租赁_add_submit', '/admin/app/mill租赁_add_submit');
Route::rule('app/mill租赁_update', '/admin/app/mill租赁_update');
Route::rule('app/mill租赁_update_submit', '/admin/app/mill租赁_update_submit');
Route::rule('app/mill租赁_status', '/admin/app/mill租赁_status');

Route::rule('app/会员租赁算力', '/admin/app/会员租赁算力');

Route::rule('user/address', 'admin/app/address');
Route::rule('user/fund/link', 'admin/app/user_fund_link');
Route::rule('user/fund/fee/submit', 'admin/app/fee_submit');
Route::rule('user/fund/cc/submit', 'admin/app/cc_submit');