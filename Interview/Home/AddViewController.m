//
//  AddViewController.m
//  Interview
//
//  Created by cl on 2020/3/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import "AddViewController.h"
#import "CLAddHeaderCollectionCell.h"


@interface AddViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UILabel *myHead;
@property (strong , nonatomic)UICollectionView *collectionView;
@property(assign,nonatomic)NSInteger ItemCount;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ItemCount = 3;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
    [self setupColl];
    [self setupBottomBtn];
}
-(void)setupUI{
    self.myHead = [[UILabel alloc]initWithFrame:CGRectMake(18, 100, 100, 20)];
    self.myHead.textColor = [UIColor whiteColor];
    self.myHead.font = [UIFont systemFontOfSize:18];
    self.myHead.text = NSLocalizedString(@"我的耳机", nil);
    [self.view addSubview:self.myHead];
}

-(void)setupColl{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.frame = CGRectMake(0, 200, ScreenWidth, ScreenHeight - 300 );
    _collectionView.showsVerticalScrollIndicator = NO;        //注册
    self.collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CLAddHeaderCollectionCell class] forCellWithReuseIdentifier:identifier_CLAddHeaderCollectionCell];
    [self.view addSubview:_collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)setupBottomBtn{
    UIButton *cancelButton = [[UIButton alloc] init];
    [self.view addSubview:cancelButton];
    [cancelButton setTitle:NSLocalizedString(@"+添加新耳机", nil)  forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 16 拷贝 2"] forState:(UIControlStateNormal)];
    [cancelButton setTitleColor:[UIColor colorFromHexStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    cancelButton.layer.cornerRadius = 3;
//    cancelButton.layer.maskedCorners = YES;
    [cancelButton addTarget:self action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
      make.size.mas_equalTo(CGSizeMake(236, 31));
    }];
}
-(IBAction)addClicked:(UIButton*)sender{
    self.ItemCount = self.ItemCount+1;
    [self.collectionView reloadData];
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.ItemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     CLAddHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_CLAddHeaderCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth )/2, (ScreenWidth )/2);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 3) ? 0 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}
@end