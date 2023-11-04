var lun = new Lunar(); //月历全局对象
var curJD; //现在日期
/********************
当前时间初始化,在屏幕上显示时间、保存本地时区信息等
*********************/
function set_date_screen(fw){ //把当前时间置于屏幕的便入框之中
 var now=new Date();
 curTZ = now.getTimezoneOffset()/60; //时区 -8为北京时
 curJD = now/86400000-10957.5 - curTZ/24; //J2000起算的儒略日数(当前本地时间)
 JD.setFromJD(curJD+J2000);
 if(!fw||fw==1){
  Cml_y.value = JD.Y;
  Cml_m.value = JD.M;
  Cml_d.value = JD.D;
  Cml_his.value = JD.h+':'+JD.m+':'+JD.s.toFixed(0);
 }
 if(!fw||fw==2){
  Cal_y.value = JD.Y;
  Cal_m.value = JD.M;
 }
 curJD=int2(curJD+0.5);
}
set_date_screen(0);
/**********************
月历的年、月跳转控制函数
**********************/
function changeYear(ud){ //跳到上(或下)一年
 var y = year2Ayear(Cal_y.value);
 if(y==-10000) return;
 if(ud==0){
   if(y<=-10000) { alert('到顶了！'); return; }
   Cal_y.value = Ayear2year(y-1);
 }else{
   if(y>=9999) { alert('到顶了！'); return; }
   Cal_y.value = Ayear2year(y+1);
 }
 getLunar();
}
function changeMonth(ud){ //跳到上(或下)下月
 var y,m;
 y = year2Ayear(Cal_y.value);
 m = Cal_m.value-0;
 if(ud==0){
   if(m<=1 && y<=-10000) { alert('到顶了！'); return; }
   if(m<=1) Cal_m.value = 12, Cal_y.value = Ayear2year(y-1);
   else     Cal_m.value = m-1;
 }
 if(ud==1){
   if(m>=12 && y>=9999) { alert('到顶了！'); return; }
   if(m>=12) Cal_m.value = 1, Cal_y.value = Ayear2year(y+1);
   else      Cal_m.value = m+1;
 }
 if(ud==2) set_date_screen(2);
 getLunar();
}
/**********************
月历页面生成
**********************/
function getLunar(){ //月历页面生成

  var By  = year2Ayear(Cal_y.value);
  var Bm  = Cal_m.value-0;
  if(By == -10000) return;

  if(!lun.dn || lun.y!=By || lun.m!=Bm){  //月历未计算
   lun.yueLiHTML(By,Bm,curJD);
   Cal2.innerHTML = lun.pg1;
   Cal4.innerHTML = lun.pg2;
  }
  showMessD(-2);
}
getLunar(); //调用月历页面生成函数
