//
//  InterScaleViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/4/20.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "InterScaleViewController.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"
#import "AddViewController.h"
#import "CLAddHeaderCollectionCell.h"
#import "SliderViewController.h"
#import "KSTitleButton.h"
#import "SXCircleView.h"
@interface InterScaleViewController ()<UIGestureRecognizerDelegate,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,KSTitleButtonDelegate>

@property (nonatomic, strong) UIImageView *imageView_;
@property (nonatomic, strong) UILabel *alertLabel;
@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UIImageView *bottomImg;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIImageView *headerImageView; // 大图
@property (strong, nonatomic) UIImageView *bgImageView;     // 上个页面截图

@property(strong,nonatomic)NSArray *titleArray;

@property (strong, nonatomic) UIImageView *earImage;
@property(strong,nonatomic)SXCircleView *circleView;
@end

@implementation InterScaleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat volumeCircleWidth ;//音量圆环的宽 适配SE
    volumeCircleWidth = 275;
    NSLog(@"IndexPath=%@",self.selectIndexPath);
    self.titleArray = @[NSLocalizedString(@"按键设置", nil),NSLocalizedString(@"通用设置", nil),NSLocalizedString(@"EQ", nil),NSLocalizedString(@"固件更新", nil)] ;
     CGFloat TOPMagin = iPhoneX ? 120 :40 ;//
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    self.view.backgroundColor = [UIColor blackColor];
    NSLog(@"cell==%@",self.addCell.headerName);
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.userInteractionEnabled = YES;
    self.headerImageView.frame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenWidth*1.3);
    self.headerImageView.image = [UIImage imageNamed:self.imageName];
    self.headerImageView.layer.cornerRadius  = 10;
    self.headerImageView.layer.masksToBounds = YES;
    [self.midView addSubview:self.headerImageView];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.midView);
    }];
     CGFloat circleYTop = iPhoneX ? 140 : 100;
    
    CGFloat circleX = (ScreenWidth - volumeCircleWidth -20*2)*0.5;
    
    
    [UIView animateWithDuration:1 animations:^{
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.circleView = [[SXCircleView alloc]initWithFrame:CGRectMake(circleX,circleYTop, volumeCircleWidth, volumeCircleWidth) lineWidth:2 circleAngle:240 productModel:@"0003" imageWidth:4 ];
        [self.midView addSubview:self.circleView];
    });
    
    CGFloat headTop = iPhoneX ? 180 : 140;
    /**/
    self.earImage = [[UIImageView alloc]init];
//    self.earImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, headTop+20+20, 126, 92)];
    [self.midView addSubview:self.earImage];
//    self.earImage.centerX = self.circleView.centerX;
    
    self.earImage.image = [UIImage imageNamed:self.headerName];
    self.earImage.contentMode = UIViewContentModeScaleAspectFit;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.earImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.midView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(126, 192));
            make.top.equalTo(self.midView.mas_top).offset(headTop);
        }];
    });
    
    //右上角删除按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"失败"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(deleteClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    [UIView animateWithDuration:0.2  animations:^{
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-34);
            make.top.equalTo(self.view.mas_top).offset(50);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    } completion:nil];
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
    [self.view addSubview:bottomV];
    UIImageView *img = [[UIImageView alloc]initWithFrame:bottomV.bounds];
    self.bottomImg = img;
    img.image = [UIImage imageNamed:self.bottomName];
    [bottomV addSubview:self.bottomImg];
    self.bottomView = bottomV;
    
    [UIView animateWithDuration:0.2  animations:^{
       bottomV.frame = CGRectMake(0, ScreenHeight-260, ScreenWidth, 260);
   } completion:^(BOOL finished) {
       
   }];
    KSTitleButton *titleV = [[KSTitleButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, 200) TitleArr:self.titleArray LineNumber:2 ColumnsNumber:2 EdgeInsetsStyle:LZHEdgeInsetsStyleTop ImageTitleSpace:5 isUpdate:NO isFemale:NO];
    titleV.delegate = self;
//    self.titleV = titleV;
    [self.bottomView addSubview:titleV];
    
}
-(void)clickBTnIndex:(KSTitleViewStyle)style Title:(NSString *)title{
    [self.navigationController pushViewController:[SliderViewController new] animated:YES];
}

-(IBAction)deleteClick:(UIButton*)sender{
    [self.circleView removeFromSuperview];
    [self.earImage removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"from==%@ tovc==%@",fromVC,toVC);
    if ([toVC isKindOfClass:[AddViewController class]]) {
        return self;
    }else{
       return nil;
    }
    
}

#pragma mark - UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
     AddViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    InterScaleViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [fromVC valueForKeyPath:@"headerImageView"];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
   [toVC.collectionView layoutIfNeeded];
    CLAddHeaderCollectionCell *cell =  (CLAddHeaderCollectionCell*)[toVC.collectionView cellForItemAtIndexPath:self.selectIndexPath];
    
    UIView *originView = cell.bgImage;
//    UIView *headerView = cell.headerImg;
    
//    UIView *originView = self.addCell.bgImage;
    NSLog(@"回去的cell=%@",self.addCell.headerName.text);
    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.layer.masksToBounds = YES;
    snapShotView.layer.cornerRadius = 15;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    
    fromView.hidden = YES;
    originView.hidden = YES;
//    headerView.hidden = YES;
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    UIImageView *headerImg = [[UIImageView alloc]init];
    headerImg.contentMode = UIViewContentModeScaleAspectFit;
    headerImg.image = [UIImage imageNamed:self.headerName];
//    headerImg.frame = CGRectMake((originView.width -100)*0.5, -44, 100, 100);
    [snapShotView addSubview:headerImg];
    [headerImg sizeToFit];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(originView.mas_top).offset(0);
        make.centerX.mas_equalTo(originView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{//usingSpringWithDamping弹性值
//           [containerView layoutIfNeeded];
//           fromVC.view.alpha = 0;
//        [self.bottomView removeFromSuperview];
//           snapShotView.layer.cornerRadius = 15;
//           snapShotView.frame = [containerView convertRect:originView.frame fromView:originView.superview];
//        NSLog(@"origin=%@ originView.superview=%@ supeview=%@ oth=",NSStringFromCGRect(originView.frame) ,NSStringFromCGRect(originView.superview.frame),originView.superview);
//
//       } completion:^(BOOL finished) {
//           fromView.hidden = YES;
//           [snapShotView removeFromSuperview];
//           originView.hidden = NO;
//           [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//       }];
    
        [UIView animateWithDuration:1 animations:^{
          [containerView layoutIfNeeded];
              fromVC.view.alpha = 0;
           [self.bottomView removeFromSuperview];
              snapShotView.layer.cornerRadius = 15;
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(originView.mas_top).offset(-44);
            make.centerX.mas_equalTo(originView);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
              snapShotView.frame = [containerView convertRect:originView.frame fromView:originView.superview];
       } completion:^(BOOL finished) {
          fromView.hidden = YES;
          [snapShotView removeFromSuperview];
          originView.hidden = NO;
//           headerView.hidden = NO;
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
       }];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}
-(UIView *)midView{
    if (!_midView) {
        CGFloat TOPMagin = iPhoneX ? 120 :40 ;//
            
            self.midView = [[UIView alloc]init];
            
            CGRect beginFrame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
            
        //    CGRect endFrame = CGRectMake(20, SCREEN_HEIGHT, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
            self.midView.frame = beginFrame;
            [self.view addSubview:self.midView];
            
    }
    return _midView;
}
//-(UIImageView *)earImage{
//    if (!_earImage) {
//        CGFloat headTop = iPhoneX ? 180 : 140;
////            _earImage = [[UIImageView alloc]init];
//            self.earImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.circleView.centerX, headTop+20+20, 126, 92)];
//            [self.midView addSubview:self.earImage];
//            _earImage.image = [UIImage imageNamed:self.headerName];
//            _earImage.contentMode = UIViewContentModeScaleAspectFit;
//
////            [_earImage mas_makeConstraints:^(MASConstraintMaker *make) {
////                make.centerX.equalTo(self.midView.mas_centerX);
////                make.size.mas_equalTo(CGSizeMake(126, 192));
////                make.top.equalTo(self.midView.mas_top).offset(headTop);
////            }];
//    }
//    return _earImage;
//
//}

@end
