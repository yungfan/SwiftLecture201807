//
//  YFMainViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFMainViewController.h"
#import "YFService.h"
#import "YFServiceCollectionViewCell.h"
#import "YFStoreTableViewCell.h"
#import "YFStore.h"
#import "YFDetailsViewController.h"
#import "YFNetTools.h"
#import "YFFileTools.h"
#import "YFImageTools.h"
#import "YFDialogTools.h"
#import "YFLoginViewController.h"


@interface YFMainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

//上面的宫格菜单
@property (weak, nonatomic) IBOutlet UICollectionView *serviceCollectionView;

//下面的列表
@property (weak, nonatomic) IBOutlet UITableView *storeTableView;

//CollectionView的数据源
@property (nonatomic, strong) NSArray<YFService *> *services;

//Store对应的数据
@property (nonatomic, strong) NSArray<YFStore *> *stores;

//TableView对应的数据源
@property (nonatomic, strong) NSMutableArray<YFStore *> *selectedStores;

//选中的Service
@property (nonatomic, strong) YFService *selectedService;

//选中的Store
@property (nonatomic, strong) YFStore *selectedStore;

//登录
- (IBAction)login:(id)sender;

//登录状态
@property (nonatomic, assign) BOOL  isLogin;

//登录按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginItem;

@end

@implementation YFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Main", @"Main");
    
    [self setupCollectionView];
    
    [self setupTableView];
    
    //只有当网络变化的时候才会发出通知，第一次进来的时候网络已经定了，这时候监听只能是网络发生变化时才起作用了
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [self setupData];
    
    //监听用户是否登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:@"Login" object:nil];
}

//用户登录通知
-(void)notifi:(NSNotification *)noti{
    
    self.isLogin = YES;
    
    //国际化字符串
    self.loginItem.title =  NSLocalizedString(@"logout", @"logout")  ;
}
    
//根据网络状态设置数据
-(void)setupData {
    
    //获取网络状态
    NSInteger status = [[[YFFileTools sharedTool] readUserDataWithKey:@"AFNetworkReachabilityStatus"] integerValue];
    
    //加载本地数据
    if (status == NotReachable) {
        
        NSLog(@"加载本地");
        
        //1.获取CollectionView的数据源数据
        [YFService getServiceFromLocal:^(NSArray * services) {
            
            self.services = services;
 
            [self.serviceCollectionView reloadData];
            
            //2.获取TableView的数据源数据
            [YFStore getStoreFromLocal:^(NSArray * stores) {
                
                self.stores = stores;
               
            }];
            
        }];
    }
    
    //加载网络数据
    else {
        
         NSLog(@"加载网络");
        
        //1.获取CollectionView的数据源数据
        [YFService getServiceFromServer:^(NSArray * services) {
            
            self.services = services;
    
            [self.serviceCollectionView reloadData];
            
            //2.获取TableView的数据源数据
            [YFStore getStoreFromServer:^(NSArray * stores) {
                
                self.stores = stores;
                
                //3.刷新上面的宫格菜单
               
            }];
            
        }];
        
    }
}

#pragma mark - Set UI
-(void)setupCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = 2;//设置最小行间距
    
    layout.minimumInteritemSpacing = 2;//item间距(最小值)

    layout.itemSize = CGSizeMake((ScreenW-10)/3, 100);
    
    self.serviceCollectionView.collectionViewLayout = layout;
    
   
}

-(void)setupTableView{
    
    self.storeTableView.rowHeight = 80.0;
    
    self.storeTableView.tableFooterView = [[UIView alloc]init];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.services.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YFServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"serviceCell" forIndexPath:indexPath];
    
    YFService *service = [self.services objectAtIndex:indexPath.row];
    
    cell.service = service;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //用户登录了才允许展示列表数据
    if (self.isLogin) {
        
        //1.获取点击的菜单
        YFService *service = [self.services objectAtIndex:indexPath.row];
        
        self.selectedService = service;
        
        //2.点击的菜单对应的数据
        if(!self.selectedStores){
            
            self.selectedStores = [NSMutableArray array];
        }
        
        else{
            
            [self.selectedStores removeAllObjects];
            
        }
        
        for (YFStore *store in self.stores) {
            
            if (store.serviceIndex == service.index) {
                
                [self.selectedStores addObject:store];
                
                //3.刷新列表数据
                [self.storeTableView reloadData];
            }
            
        }
        
    }
    
    else{
        
 
        [[YFDialogTools sharedTool]showDialogWithType:StyleError message:NSLocalizedString(@"Please login first", @"Please login first")];
        
    }
    
    
}


//下面三个方法是让Item点击时高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    //设置(Highlight)高亮下的颜色
    [cell setBackgroundColor:YFColorFromHex(0xf2f2f2)];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
   
    //设置(Nomal)正常状态下的颜色
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [cell setBackgroundColor:[UIColor whiteColor]];
        
    });
   
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.selectedStores.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YFStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"store" forIndexPath:indexPath];
    
    YFStore *store = [self.selectedStores objectAtIndex:indexPath.row];
    
    //从缓存中取图片
    NSString *imageURL = [NSString stringWithFormat:@"%@/%@", BaseURL, self.selectedService.imagePath];;
    
    cell.imageView.image = [[YFImageTools sharedTool] imageFromDiskCacheWithURL:imageURL];
    
    cell.textLabel.text = store.name;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YFStore *store = [self.selectedStores objectAtIndex:indexPath.row];

    self.selectedStore = store;

    [self performSegueWithIdentifier:@"MainMoveToDetails" sender:nil];
    
}


#pragma mark - Segue传值

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    YFDetailsViewController *detail = segue.destinationViewController;
    
    detail.selectedStore = self.selectedStore;
}

#pragma mark - 登录
- (IBAction)login:(id)sender {
    
    if (self.isLogin) {
        
         [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    else{
        
        YFLoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
        
        [self presentViewController:loginVC animated:YES completion:nil];
       
    }
}

-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}

@end
