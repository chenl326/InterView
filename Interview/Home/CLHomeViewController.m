//
//  CLHomeViewController.m
//  Interview
//
//  Created by cl on 2019/7/19.
//  Copyright © 2019 cl. All rights reserved.

// 69cili.xyz  p99y.com
/** runloop 事件产生的地方就是source(输入源), 运用发消息的机制，让事件可以唤醒休眠的runloop执行*/
//    dispatch_get_main_queue()串行 gloable_queue 并发

//MARK: 传递UIApplication->UIWindow->UIView->寻找子视图看是否能处理事件->遍历子视图-（否）事件废弃

//MARK:响应者链反方向First Responser -- > The Window -- >The Application -- > App Delegate
//MARK:每个 UIView内部都有一个 CALayer 在背后提供内容的绘制和显示，并且 UIView 的尺寸样式都由内部的 Layer 所提供

//[leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal]; 右边label优先显示

#import "CLHomeViewController.h"
#import "CopyTest.h"
#import "ReverseList.h"
#import "CLButton.h"
#import "TicketManager.h"
#import <objc/runtime.h>
#import "MathUtil.h"
#import "NSObject+Extension.h"
#import "HYRadix.h"
#import "NSString+Extension.h"
#import <Test/Test.h>
#import "CHLUUID.h"
typedef NS_ENUM(NSUInteger, GaiaCommandUpdate) {
    GaiaUpdate_Unknown                          = 0x00,
    GaiaUpdate_StartRequest                     = 0x01,
    GaiaUpdate_StartConfirm                     = 0x02,
    GaiaUpdate_DataBytesRequest                 = 0x03,
    GaiaUpdate_Data                             = 0x04,
    GaiaUpdate_SuspendIndicator                 = 0x05,
    GaiaUpdate_ResumeIndicator                  = 0x06,
    GaiaUpdate_AbortRequest                     = 0x07,
    GaiaUpdate_AbortConfirm                     = 0x08,
    GaiaUpdate_ProgressRequest                  = 0x09,
    GaiaUpdate_ProgressConfirm                  = 0x0A,
    GaiaUpdate_TransferCompleteIndicator        = 0x0B,
    GaiaUpdate_TransferCompleteResult           = 0x0C,
    GaiaUpdate_InProgressIndicator              = 0x0D,
    GaiaUpdate_InProgressResult                 = 0x0E,
    GaiaUpdate_CommitRequest                    = 0x0F,
    GaiaUpdate_CommitConfirm                    = 0x10,
    GaiaUpdate_ErrorWarnIndicator               = 0x11,
    GaiaUpdate_CompleteIndicator                = 0x12,
    GaiaUpdate_SyncRequest                      = 0x13,
    GaiaUpdate_SyncConfirm                      = 0x14,
    GaiaUpdate_StartDataRequest                 = 0x15,
    GaiaUpdate_IsValidationDoneRequest          = 0x16,
    GaiaUpdate_IsValidationDoneConfirm          = 0x17,
    GaiaUpdate_SyncAferRebootRequest            = 0x18,
    GaiaUpdate_VersionRequest                   = 0x19,
    GaiaUpdate_VersionConfirm                   = 0x1A,
    GaiaUpdate_VariantRequest                   = 0x1B,
    GaiaUpdate_VariantConform                   = 0x1C,
    GaiaUpdate_HostEraseSquifRequest            = 0x1D,
    GaiaUpdate_HostEraseSquifConfirm            = 0x1E,
    GaiaUpdate_ErrorWarnResponse                = 0x1F
};


@interface CLHomeViewController ()
@property (copy, nonatomic) NSMutableArray *arr;
@property (strong, nonatomic) NSArray *bookArrayS;
@property (copy, nonatomic) NSArray *bookArrayC;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CLButton *btn1;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property(nonatomic,strong)NSString *defaultVersion;
@property(nonatomic,strong)NSString *leftVersion;
@property(nonatomic,strong)NSString *rightVersion;

@property (nonatomic) NSDictionary *supportedServices;
@end
#define GATTDeviceInformationService    @"180A"
#define GATTBatteryService              @"180F"
#define GATTHeartRateService            @"180D"
#define GATTImmediateAlertService       @"1802"
#define GATTLinkLossService             @"1803"
#define GATTAlertNotificationService    @"1811"
#define GaiaServiceUUID                 @"00001100-D102-11E1-9B23-00025B00A5A5"
#define BATTERY_LEVEL_MAX               3700
#define GATTCharacteristicFormat        @"2904"
#define GAIALocalBatteryLevel           271
#define FMPDescString @"Allow external devices to find this phone."
#define FindMyPhoneId                   @"FindMyPhone"
#define FindMe                          @"FindMe"

@implementation CLHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [CLPerson eat];
}



-(void)adjustNum{
    NSString *testNum = @"90924670";
    NSString *first = [testNum substringToIndex:1];
    NSString *two = [testNum substringWithRange:NSMakeRange(1, 2)];
    NSString *three = [testNum substringFromIndex:3];
    NSLog(@"%@--%@---%@",first,two,three);
    if ([first isEqualToString:@"9"]) {
        if ([two isEqualToString:@"10"] && [three intValue] >= 24671) {
            NSLog(@"不需要升级");
        }else{
            
            if ([two isEqualToString:@"10"] || [two isEqualToString:@"09"] ||[two isEqualToString:@"11"]) {
                NSLog(@"需要升级");
            }else{
               NSLog(@"不需要升级");
            }
        }
    }
    
    NSLog(@"大于 %d",[three intValue] >= 4);
}
// 获取当前时间戳
- (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970];// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
-(void) callMe {
    //...
}
-(void) callMeWithParam:(id)obj {
    //...
}
-(void)testDic{
    NSMutableDictionary *temDic = [NSMutableDictionary dictionary];
    NSMutableArray *tempArr= [NSMutableArray array];
    NSMutableArray *removeArr= [NSMutableArray array];
    NSArray *arr = @[@"03095b111133",@"000266144422",@"00025b00ff34",@"00125b00ffb1"];
     NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObjectsFromArray:arr];
     NSDictionary *dic = @{
         @"00025b111111":@[
             @"00025b111111",
             @"00025b884422"
         ],
         @"000266144421":@[
             @"000266144421",
             @"000266144422"
         ],
         @"00125b00ffb1":@[
             @"00125b00ffb1",
             @"00025b00ff34"]
                          ,@"03095b111133":@[
             @"03095b111133",
             @"03095b111134"]
     };
    NSLog(@"dic=%@ arr=%@",dic,arr1);
    NSArray *arr2 ;
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray*  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([arr1 containsObject:obj[0]] && [arr1 containsObject:obj[1]]) {
            NSLog(@"是一对%@",arr1);
            [removeArr addObject:obj[0]];
            [removeArr addObject:obj[1]];
            [tempArr addObject:obj];
        }else{
            NSLog(@"不是一对");
        }
    }];
    
    for (NSString * str in removeArr) {
        if ([arr1 containsObject:str]) {
            [arr1 removeObject:str];
        }
    }
    
    for (NSArray *tem in tempArr) {
        [temDic setObject:tem forKey:tem[0]];
    }

    for (NSString *str  in arr1) {
        
        [temDic setObject:@[str] forKey:str];
    }
    
    NSLog(@"arr1==%@ tempArr=%@ \n tempDic=%@",arr1,tempArr,temDic);
    NSArray *ar1 = [temDic objectForKey:@"03095b111133"];
    NSLog(@"%lu",(unsigned long)ar1.count);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //DE2CD68A-CB64-4E73-8BD4-1C0CD60BA180
    NSLog(@"----%@",[CHLUUID obtainUUID]);
//    [self testDic];
    
    /**
    NSMutableArray *mutableCopyArray;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 
    NSMutableArray *array = [NSMutableArray array];
     NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:[userDefaults objectForKey:@"theArrayKey"]];
    
    [userDefaults objectForKey:@"theArrayKey"];
    if (mutableArr.count) {
         //重要步骤操作mutableCopyArray
        mutableCopyArray = [mutableArr mutableCopy];
    }else{
        mutableCopyArray = [array mutableCopy];
    }
    
//    NSMutableArray *array = [userDefaults objectForKey:@"theArrayKey"];
    if (![mutableCopyArray containsObject:@"some new value"]) {
        [mutableCopyArray addObject:@"some new value"];
    }
    
    [userDefaults setObject: mutableCopyArray forKey:@"theArrayKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    */
    short int x;
    char x0,x1;
    x=0x1122;
    x0=((char*)&x)[0]; //低地址单元
    x1=((char*)&x)[1]; //高地址单元
    if (x0 == 0x11) {
        NSLog(@"大端");
    }
    else if (x0==0x22){
        NSLog(@"小端");
    }
    
    double newCurrent =(double)(4  + 10) / 10 ;
    NSLog(@"newCurrent==%f",newCurrent);
    NSString *str222= @"abcdefhifh";
    NSLog(@"-----=%@===%@",[str222 substringWithRange:NSMakeRange(str222.length-8, 4)],[str222 substringWithRange:NSMakeRange(str222.length-4, 4)]);
    
    NSString *str4 = [HYRadix hy_convertToDecimalFromHexadecimal:@"32"];
     NSString *str5 = [HYRadix hy_convertToDecimalFromHexadecimal:@"7f"];
    
    int a111 = [str4 intValue] & [str5 intValue];
    NSLog(@"a111==%d",a111);
        self.supportedServices = @{
        GaiaServiceUUID:
            @[@"Update Service", @"This service can update the software on the connected device."]
        };
    
    NSLog(@"supportedServices==%@",self.supportedServices);
    
    int a11 = 100;
    int b11 = 127;
    int a1q = a11 & b11;
    NSLog(@"a1==%d",a1q);
    NSString *time2 = [NSString getCurrentTimestamp];
     NSString *time1 = [HYRadix hy_convertToHexadecimalFromDecimal:[NSString getCurrentTimestamp]];
    NSLog(@"time==%@ ==%@",time1,time2);
    NSString *str = [NSObject getTempStr:@"KC331-R_ble"];
    NSLog(@"str==%@",str);
    NSString *versionStr = @"2102";
    NSLog(@"versionStr==%@",[versionStr substringWithRange:NSMakeRange(2, 2)]); 
    
    
    [self adjustNum];
//    [self testGroup];
    NSString *text = @"000a000b";
    self.leftVersion = [text substringToIndex:4];
    self.rightVersion = [text substringFromIndex:4];
    
    NSLog(@"%@---%@",self.leftVersion,self.rightVersion);
     
    NSString *aaa= [HYRadix hy_convertToDecimalFromHexadecimal:self.leftVersion];
    NSLog(@"---%@",aaa);
    CGFloat floa1 = round(292*12/71) ;
    CGFloat floa2 = round(292*12/71 -12);
   
    int a1  = [NSObject getTempEqValue:8 firstFloat:12 otherFloat:-36];
    int b1 = [NSObject getOffexY:@"0a" firstFloat:292 otherFloat:8];
     NSLog(@" b==%d %f--%f ==%f",b1,floa1,floa2,floa1 -floa2);
//    dispatch_sync(dispatch_get_main_queue(), ^(void){
//        NSLog(@"这里死锁了");
//    });
    
    [self sendDataCommand:GaiaUpdate_Unknown];
    
    int a , b ,c ,d;
    a= 3 ;
    b =3; //默认版本
    c= 3;
    d = 1;
    
    if (b>=a && b>=c) {
        NSLog(@"需要更新两个");
    }else if(b >= a || b>=c){
        NSLog(@"需要更新1个");
    }else{
        NSLog(@"不需要更新");
    }
    
    self.defaultVersion = @"000a";
    
    int abc = (int)strtoul([self.defaultVersion UTF8String], 0,16);
    
    NSInteger defau =  [self.defaultVersion integerValue];
    NSLog(@"defau=%ld",defau);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
   NSArray *firstName = [defaults objectForKey:@"ProductCode"];
//      NSLog(@"%@",firstName);
    
    
    
//    NSArray *showLevels = @[@(12), @(7), @(-9),@(15),@(26),@(-6)];
    
//    NSLog(@"suit=%ld", [self getMinValueShowLevel:showLevels mapZoomLevel:-5]);
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"跳转动画测试" class:@"TransTestController"];
    [self addCell:@"转场动画" class:@"TranslationController"];
    [self addCell:@"searchVT" class:@"SearchViewController"];
    [self addCell:@"VT搜索页面" class:@"AddViewController"];
    [self addCell:@"slider + 进度条" class:@"SliderViewController"];
    [self addCell:@"测试蓝牙工具类" class:@"BLETestViewController"];
    [self addCell:@"添加button" class:@"ButtonTagsViewController"];
    [self addCell:@"寻找view父视图+Label字体显示优先级" class:@"CommonViewController"];
    [self addCell:@"app启动性能优化+事件传递链和响应链" class:@"AppLaunchController"];
    [self addCell:@"核心动画" class:@"CoreAnimateController"];
    [self addCell:@"蓝牙跳转连接测试" class:@"OTAFirmController"];
    
    [self addCell:@"Alert" class:@"AlertViewController"];
    
    [self addCell:@"Chart" class:@"ChartViewController"];
    [self addCell:@"Label高度" class:@"LabelViewController"];
    [self addCell:@"固件升级" class:@"DeviceTableController"];
    [self addCell:@"固件升级弹出" class:@"FirmTableController"];
    [self addCell:@"各种弹窗" class:@"PopTableController"];
    [self addCell:@"BabyBluetooth" class:@"BabyBluetoothController"];
    
    [self addCell:@"Button" class:@"ButtonViewController"];
     [self addCell:@"隐私协议" class:@"ProtrocolViewController"];
     [self addCell:@"TeviChart" class:@"TeviChartViewController"];
    
    
    [self.tableView reloadData];
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_async(queue1, ^{
        NSLog(@"A");
        
        [self performSelector:@selector(test) withObject:nil afterDelay:0.1];
        
        NSLog(@"X");
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    });
    
    
    printMethodNamesOfClass(object_getClass([CLPerson class]));
//    __block int a = 0;
//    while (a < 5) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            a++;
//        });
//
//    }
    //NSLog(@"%d",a); //a至少大于5
    /**死锁1 同步添加任务需要主队列中任务打印4和6都执行完毕 主队列是串行队列需要5打印才执行6 相互等待，造成死锁*
     NSLog(@"=================4");
     dispatch_sync(dispatch_get_main_queue(), ^{ NSLog(@"=================5");
     });
     NSLog(@"=================6");
     **/
    
    /**因为是异步函数，所以系统会开启新（子）线程，又因为是串行队列，所以系统只会开启一个子线程**
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"111:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"222:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"333:%@",[NSThread currentThread]);
    });
     **/
    
//    TicketManager *ticket = [[TicketManager alloc]init];
    //    [ticket starToSale];
//    [ticket testNSOperationQueue];
    
    //    [self timerTest];
    //    [self testBtnClick];
    //    [self GCDGroup];
    //    [self setAnimate];
    //    [self copyT];
    //    [self reverseChar];
    //    [self gcdTest];
    //    [self test1];
    //    [self test2];
}
//MARK:- view #

-(void)sendDataCommand:(GaiaCommandUpdate)command{
    
    //方法2，直接拼接data
    NSMutableData *data = [NSMutableData data];
    //表头
    char head1 = 0x00;
    [data appendBytes:&head1 length:1];
    //长度
    char length = 0x03;
        
    [data appendBytes:&length length:1];
    char send[18] = {0x00,0x09,0x00,0x03,0x00,0xa0,0x00,0x08,0x01,0x40,0x00,0x03,0x00,0x90,0x00,0x04,0x01,0x40};
     NSData *sendData = [NSData dataWithBytes:send length:18];
    NSLog(@"data==%@",sendData);
   
    switch (command) {
        case GaiaUpdate_Unknown:{
            //获取电池管理状态
            char num = GaiaUpdate_Unknown;
            [data appendBytes:&num length:1];
        } break;
            
        case GaiaUpdate_StartRequest:{
            
        } break;
            
        default:
            break;
    }
    //命令字
    char cmd = 0x01;
    [data appendBytes:&cmd length:1];
    
    //灯泡的亮度
    int lightness = 40;

    [data appendData:[MathUtil convertHexStrToData:[self to16:lightness]]];//这一步是把亮度40转化为16进制字符串，然后16进制字符串转化为NSData。下面粘上这一部分转换的方法
    
//    NSLog(@"data===%@",data);
    
}

-(void)testGroup{
    dispatch_group_t group  = dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"11111!!!");
        
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //网络请求完毕 回到主线程更新UI 或者做些其它的操作
        NSLog(@"group所有请求完毕!!!");
    });
}
-(void)test{
    NSLog(@"test");
    
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CL"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


void printMethodNamesOfClass(Class cls){
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}

-(void)testBtnClick{
    self.btn1 = [[CLButton alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
    self.btn1.backgroundColor = [UIColor greenColor];
    [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.btn1];
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 40, 40)];
    self.btn2.backgroundColor = [UIColor greenColor];
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.btn2];
}

-(IBAction)btn1:(CLButton*)sender{
    NSLog(@"-------");
}
-(IBAction)btn2:(UIButton*)sender{
    NSLog(@"22222222222");
}
-(void)timerTest{
    //实现
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showMsg) userInfo:nil repeats:YES];
}
-(void)showMsg{
    NSLog(@"zzzzz-----");
}
//MARK:-GCDGroup
-(void)GCDGroup{
    dispatch_group_t group  = dispatch_group_create();
    for (int i = 0; i <9; i++){//模仿多个网络请求
        dispatch_group_async(group,dispatch_get_global_queue(0, 0), ^{
            //异步网络请求
            
            int x = arc4random() % 5;
            //模拟网络请求快慢不确定的情况
            sleep(x);
            
            NSLog(@"group 请求成功OR请求失败 %d!",i);
        });
    }
    NSLog(@"group开始 网络请求!");
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //网络请求完毕 回到主线程更新UI 或者做些其它的操作
        NSLog(@"group所有请求完毕!!!");
    });
}
//MARK: 动画
-(void)setAnimate{
    UIImageView *img  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"love"]];
    img.frame = CGRectMake(100, 200, 40, 40);
    [self.view addSubview:img];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"]; //选中的这个keyPath就是缩放
    scaleAnimation.fromValue = [NSNumber numberWithDouble:0.5]; //一开始时是0.5的大小
    scaleAnimation.toValue = [NSNumber numberWithDouble:1.5];  //结束时是1.5的大小
    scaleAnimation.duration = 1.5; //设置时间
    scaleAnimation.repeatCount = MAXFLOAT; //重复次数
    [img.layer addAnimation:scaleAnimation forKey:@"CQScale"]; //添加动画
}

-(void)gcdTest{
    dispatch_queue_t queue = dispatch_queue_create("cl.com",DISPATCH_QUEUE_SERIAL);//串行
    NSLog(@"1");
    dispatch_async( queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{ //死锁 4优先调度 3同步 FIFO先进先出
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    
}
-(void)copyT{
    NSMutableArray *books = [@[@"book1"] mutableCopy];
    self.arr = books;
    NSArray *array = @[@(0),@(1)];
    //    [self.arr removeAllObjects];
    
    self.bookArrayC = array;
    self.bookArrayS = array;
    CopyTest *copy = [[CopyTest alloc] init];
    copy.bookArray1 = books;
    copy.bookArray2 = books;
    //    self.bookArrayS = books;
    //    self.bookArrayC = books;
    [books removeAllObjects];
    //    [books addObject:@"book2"];
    
    //    [books removeAllObjects];
    NSLog(@"bookArrayS:%@ 内存地址 = %p 指针地址 = %p ",self.bookArrayS,self.bookArrayS,&_bookArrayS);
    NSLog(@"bookArrayC:%@ 内存地址 = %p 指针地址 = %p ",self.bookArrayC,self.bookArrayC,&_bookArrayC);
    
    
    NSString *str = @"aaaa";
    NSLog(@"str     = %@   内存地址 = %p 指针地址 = %p",str,str,&str);
    
    copy.strStrong = str;
    NSLog(@"strong  = %@   内存地址 = %p ",copy.strStrong,copy.strStrong);
    copy.strCopy = str;
    NSLog(@"copy    = %@   内存地址 = %p 指针地址 =\n",copy.strCopy,copy.strCopy);
    str = @"bbb";
    NSLog(@"对不可变字符串操作后：");
    NSLog(@"str     = %@   内存地址 = %p    指针地址 = %p",str,str,&str);
    NSLog(@"strong  = %@   内存地址 = %p    指针地址 = ",copy.strStrong,copy.strStrong);
    NSLog(@"copy    = %@   内存地址 = %p    指针地址 = \n",copy.strCopy,copy.strCopy);
    
    // 可变字符串
    NSLog(@"可变字符串：");
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:@"kobe"];
    NSLog(@"mutableStr = %@ 内存地址 = %p   指针地址 = %p",mutableStr,mutableStr,&mutableStr);
    copy.strStrong = mutableStr;
    NSLog(@"strong     = %@ 内存地址 = %p   指针地址 = ",copy.strStrong,copy.strStrong);
    copy.strCopy = mutableStr;
    NSLog(@"copy       = %@ 内存地址 = %p   指针地址 =\n",copy.strCopy,copy.strCopy);
    
    NSString *str1 = @"str1";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    NSLog(@"\nstr1 = %@ str1P = %p \n str2 = %@ str2P = %p \n str3 = %@ str3P = %p", str1, str1, str2, str2,str3,str3);
    
}
-(void)testBtn{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/中文"];
    NSURLRequest *req  = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",req);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}
-(IBAction)btnClick:(UIButton*)sender{
    NSLog(@"1111111");
}
///冒泡排序
-(void)test1{
    NSMutableArray * ary1 = [NSMutableArray arrayWithObjects:@"5",@"8",@"6",@"3",@"9",@"2",@"1",@"7",nil];
    
    
    
    for (int i = 0; i < [ary1 count]-1; i++) {
        BOOL isSort = true;
        
        for (int j = 0; j < [ary1 count] - i - 1; j++) {
            if ([ary1[j] intValue] > [ary1[j+1] intValue]) {
                int temp = [ary1[j] intValue];
                ary1[j] = ary1[j+1];
                ary1[j+1] = @(temp);
                isSort = false;
            }
        }
        if (isSort) {
            break;
        }
    }
    NSLog(@"%@",ary1);
}

//二分查找
-(void)test2{
    NSArray * array1 = @[@3,@7,@9,@14,@25,@26,@37,@69];
    
    NSInteger result = [self binarySearchTarget:@26 inArray:array1];//在这里打印结果看是否有相等的值
    
    NSLog(@"%ld",(long)result);
}
- (NSInteger)binarySearchTarget:(NSInteger)target inArray:(NSArray *)arr{
    
    if (arr.count < 1) {
        
        //数组无元素,返回-1;
        
        return -1;
    }
    
    NSInteger start = 0;
    
    NSInteger end = arr.count - 1;
    
    NSInteger mid = 0;
    
    while (start < end -1) {
        if ([arr[mid] integerValue] > target) {
            end = mid;
        }else{
            start = mid;
        }
    }
    // 如果第一个值和目标值相等则获取第一个值的下标
    
    if ([arr[start] integerValue] == target) {
        
        return start;
        
    }
    
    // 如果最后一个值和目标值想等则获取最后一个下标
    
    if ([arr[end] integerValue] == target) {
        
        return end;
        
    }
    return -1;
}

-(void)reverseChar{
    NSString *string = @"vsdgfgfhsddfafsdf!";
    NSInteger length = string.length;
    char ch[100];
    memcpy(ch, [string cStringUsingEncoding:NSASCIIStringEncoding], 2 * length);
    
    reverChar(ch);
    NSLog(@"CharReverse result:%s",ch);
    
}

//MARK: -递归逆序
- (void)reverseArray:(NSMutableArray *)array start:(NSInteger)start end:(NSInteger)end{
    NSNumber *temp = array[start];
    array[start] = array[end];
    array[end] = temp;
    [self reverseArray:array start:++start end:end--];
}

- (NSInteger)getMinValueShowLevel:(NSArray *)showLevels mapZoomLevel:(CGFloat)mapZoomLevel{
    NSInteger suitValue = (int)mapZoomLevel;
    NSInteger diffLevel = 9999;
    for (NSNumber *showLevel in showLevels) {
        NSInteger diffLevelTmp = fabs(mapZoomLevel - [showLevel intValue]);
        if (diffLevelTmp < diffLevel) {
            diffLevel = diffLevelTmp;
            suitValue = [showLevel intValue];
        }
    }
    return suitValue;
}
//转换成十六进制
-(NSString *)to16:(int)num{
    NSString *result = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",num]];
    if ([result length] < 2) {
        result = [NSString stringWithFormat:@"0%@", result];
    }
    return result;
}

//销毁
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
