class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string   "name"
      t.string   "title"      
      t.string   "url"
      t.integer  "priority",   default: 1000
      t.timestamps null: false
    end

    data = {
      "开心100"   => "http://www.kaixin100.com",
      "邪恶站"     => "http://www.xieezhan.com",
      "爱笑兄弟"    => "http://www.aixiaoxiongdi.com",
      "美食街"     => "http://www.msj.com",
      "好时光"     => "http://www.hao40.com",
      "每日一笑"    => "http://www.97taozhe.com",
      "小明滚出去"   => "http://www.xiaoming8.com",
      "笑霸来了"    => "http://www.xiaobaxiaoba.com",
      "搞笑漫画"    => "http://www.7656.net",
      "嘻嘻讯笑话"   => "http://www.xixixun.com",
      "邪恶笑话a"    => "http://3000xh.com",
      "这不科学"    => "http://www.nokexue.com",
      "蛋好疼"     => "http://www.danhaoteng.com",
      "开心么"     => "http://www.kaixinme.com",
      "笑话圈"     => "http://www.xiaohuaquan.com",
      "说说大全"    => "http://shuoshuodaquan.org",
      "笑乐网"     => "http://www.xiaolewang.com",
      "qq头像"    => "http://www.yilun.net",
      "小学生优秀作文" => "http://www.zuowenwuyou.com",
      "114啦搞笑"  => "http://gaoxiao.114la.com",
      "美图乐乐"    => "http://www.meitulele.com",
      "奇葩网"     => "http://www.qipawang.com",
      "神回复"     => "http://www.tucao123.com",
      "漫画"      => "http://mh.quhua.com",
      "奇米影视"    => "http://www.7emi.com",
      "第一笑话a"    => "http://www.zsdvr.com",
      "无节操"     => "http://www.5jiecao.net",
      "囧内涵"     => "http://jiongneihan.com",
      "笑话大全a"    => "http://www.shyule.net",
      "内涵漫画"    => "http://www.idoman.net",
      "娱乐新闻"    => "http://www.ctrcw.net",
      "笑尿啦"     => "http://www.xiaoniaola.com",
      "李敏镐最新消息" => "http://limingao.xingshu.com",
      "笑话大全b"    => "http://www.kx43.com",
      "邪恶笑话b"    => "http://www.xieeo.com",
      "内涵人"     => "http://www.amhima.com",
      "微笑话"     => "http://www.weizhanle.com",
      "流行语"     => "http://www.99liuxing.com",
      "笑林寺"     => "http://www.xiaolinsi.com",
      "第一笑话"    => "http://www.dyxiaohua.com",
      "笑话大全c"    => "http://www.bxxh.net",
      "经典语录"    => "http://yulu.quhua.com",
      "小游戏"     => "http://www.6789.cn",
      "美女图片"    => "http://www.16999.com",
      "美文"      => "http://www.hbycw.net",
      "娱乐八卦"    => "http://www.shaqing.com",
      "IQ动漫网"   => "http://www.iq520.com",
      "留学网"     => "http://www.lxw.cn",
      "土贼网"     => "http://www.tuzei.cc",
      "开口笑一笑"   => "http://www.kkwap.net",
      "内涵漫画网"   => "http://www.neihanm.com",
      "最经典笑话"   => "http://www.jokelu.com",
      "冷段子"     => "http://lengduanzi.com",
      "小癖好"     => "http://www.xiaopihao.com",
      "乐眯网"     => "http://www.lolmi.net",
      "邪恶漫画"    => "http://xieetuan.com",
      "贼傲网"     => "http://www.zeiao.com",
      "撸管"      => "http://www.luguan.la",
      "经典笑话"    => "http://www.jdxiaohua8.com",
      "全球行"     => "http://www.qqx.com"
    }.each do |name, url|
      Website.create(name: name, url: url, title: name)
    end
  end
end
