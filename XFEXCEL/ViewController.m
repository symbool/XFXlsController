//
//  ViewController.m
//  XFEXCEL
//
//  Created by 小非 on 15/5/29.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc]initWithTitle:@"详细" style:UIBarButtonItemStyleDone target:self action:@selector(detailBarItemClicked:)];
    self.navigationItem.rightBarButtonItem = detailItem;
    [self createCollectionViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)detailBarItemClicked:(id)sender {
    
    XFXlsController *detailController = [[XFXlsController alloc]init];
    detailController.cellPadding = UIEdgeInsetsMake(10, 30, 10, 30);
    detailController.cellSelectedBackgroundColor = [UIColor purpleColor];
    detailController.titleRowNum = 2;
    detailController.titleLineNum = 1;
    detailController.maxCellSize = CGSizeMake(250, 200);
    detailController.data = _data;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)createCollectionViewData {
    
    _data = [[NSMutableArray alloc]init];
    NSArray *row1 = @[@"第一行", @"姓名", @"武学", @"诗号"];
    NSArray *row2 = @[@"第二行", @"清香白莲素还真", @"石破天惊混元掌，天问三誓", @"半神半圣亦半仙，全儒全道是全贤；脑中真书藏万卷，掌握文武半边天", @"琉璃仙境", @"老婆：风采铃", @"儿子：素续缘"];
    NSArray *row3 = @[@"第三行", @"百世经纶一页书", @"九梵圣印，八部龙神火，十二神天守,莲华圣路开天光，破甲尖锋七旋指，一气动山河", @"世事如棋，乾坤莫测，笑尽英雄", @"云渡山", @"徒弟：业途灵", @"机关阵法：梵字佛障", @"武器：如是我斩", @"著作：明圣天书", @"交通(坐骑)：阳翼金翼大鹏鸟、烽火关键", @"化身：紫锦囊、宇宙神知、罪恶之身、步怀真、伪问天敌"];
    NSArray *row4 = @[@"第四行", @"刀狂剑痴叶小钗", @"天剑三绝，隔纸断树、雪花盖顶，一使刀狂越九霄、长挥剑痴踏沧浪，刀曰刀狂·剑曰剑痴·狂刀狂乱舞·痴剑痴绝生，刀以毁灭·剑以创生·生生不息·乃见天地原相", @"征衣红尘化云烟，江湖落拓不知年，剑痴刀狂世纷云，今将衣钵卸双肩；踏尽千山无人识，当初枉受盛名牵，东风吹醒英雄梦，笑对青山万重天。爱落红尘心已死，持刀抱剑了一生", @"二重林、天南山、雕神古魄", @"白玉刀青玉剑,狂月九霄痴水沧浪,咒世之刀坠业之剑,越限之刀天剑,太武神器", @"儿子：金少爷"];
    NSArray *row5 = @[@"第五行", @"天道一侠史艳文", @"纯阳掌,数返真经,龙泉剑法,迷尘笛音,白虹贯日,天心掌,意发并行,发在意先.心剑,破邪.灵法反制,一人多化", @"回忆迷惘杀戮多，往事情仇待如何，绢写黑诗无限恨，夙兴夜寐枉徒劳", @"龙泉剑, 拐杖, 竹笛, 七星圣剑, 黑羽扇"];
    NSArray *row6 = @[@"第六行", @"脱俗仙子谈无欲", @"明圣剑法, 乾坤无量·光照大千, 四象无形步", @"真神真圣亦真仙，通儒通道是通贤；脑中玄机用不尽，统辖文武半边天", @"太古神器, 孔雀剑, 凤流剑, 冽月剑", @"同修：素还真"];
    NSArray *row7 = @[@"第七行", @"无忌天子", @"掌气、能困住人的光芒、移走别人的功力", @"拂尘、无声之声秘笈、吸功石", @"师傅：八趾麒麟", @"师兄弟：素还真，谈无欲"];
    NSArray *row8 = @[@"第八行", @"剑子仙迹", @"古尘·斩无私, 天下无双, 万引天殊剑归宗, 古尘元婴, 剑影纷纷, 仙影飘迹, 天元定一, 秋水不染尘, 慧眼穿云", @"何须剑道争锋？千人指，万人封，可问江湖鼎峰；三尺秋水尘不染，天下无双", @"豁然之境", @"六道封印锁、两仪锁元阵、六阳退魔真印"];
    NSArray *row9 = @[@"第九行", @"疏楼龙宿", @"荡山河满江红、紫龙卷怒涛、冰驰名封、万化千影、紫龙宿、龙腾怒潮、吞日龙吟、儒门华威、天风不落尘", @"华阳初上鸿门红，疏楼更迭，龙麟不减风采；紫金箫，白玉琴，宫灯夜明昙华正盛，共饮逍遥一世悠然", @"紫龙, 邪之刀, 紫龙扇, 紫龙影"];
    NSArray *row10 = @[@"第十行", @"佛剑分说", @"万谛一灭、六字法印、往向佛印、微尘莲峰、佛雷斩业、天火灭业、大轮天指、焚风火莲", @"杀生为护生，斩业非斩人，佛剑之路，不由分说"];
    NSArray *row11 = @[@"第十一行", @"傲笑红尘", @"气傲天苍、横霸千峰、烽火红尘路、红尘一步终", @"半涉浊流半席清，倚筝闲吟广陵文。寒剑默听君子意，傲视人间笑红尘", @"半筝剑、傲笑红尘剑、惊雷、十三名剑", @"蒿棘居、浊世江畔、昆仑山"];
    NSArray *row12 = @[@"第十二行", @"忆秋年", @"随风点穴、血光旋刃、如临秋意、一任秋月、剑舞秋风、秋洵薰心、忆·秋思化刃、逍遥秋风", @"白云天地为衾枕，兴来倒卧醉花颜；一任风月不留痕，逍遥山水忆秋年"];
    [_data addObject:row1];
    [_data addObject:row2];
    [_data addObject:row3];
    [_data addObject:row4];
    [_data addObject:row5];
    [_data addObject:row6];
    [_data addObject:row7];
    [_data addObject:row8];
    [_data addObject:row9];
    [_data addObject:row10];
    [_data addObject:row11];
    [_data addObject:row12];
}

@end
