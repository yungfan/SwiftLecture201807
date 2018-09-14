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
#import <SDWebImage.h>


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

- (IBAction)logout:(id)sender;

@end

@implementation YFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.设置显示UI的细节
    self.title = @"Main";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = 5;//设置最小行间距
    
    layout.minimumInteritemSpacing = 5;//item间距(最小值)
    
    layout.itemSize = CGSizeMake(120, 120);
    
    self.serviceCollectionView.collectionViewLayout = layout;
    
    self.storeTableView.rowHeight = 100.0;
    
    self.storeTableView.tableFooterView = [[UIView alloc]init];
    
    //2.获取CollectionView的数据源数据
    [YFService getService:^(NSArray * services) {
        
        self.services = services;
        
        //刚进来选中的索引为0的数据
        self.selectedService = services.firstObject;
        
        [self.serviceCollectionView reloadData];
        
        //3.获取TableView的数据源数据
        self.selectedStores = [NSMutableArray array];
        
        [YFStore getStore:^(NSArray * stores) {
            
            self.stores = stores;
            
            //刚进来显示索引为0的数据
            for (YFStore *store in stores) {
                
                if (store.serviceIndex == self.services.firstObject.index) {
                    
                    [self.selectedStores addObject:store];
                    
                    [self.storeTableView reloadData];
                }
                
            }
        }];
        
    }];
    
   
    
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
    
    //1.获取点击的菜单
    YFService *service = [self.services objectAtIndex:indexPath.row];
    
    self.selectedService = service;
    
    [self.selectedStores removeAllObjects];
    
    //2.点击的菜单对应的数据
    for (YFStore *store in self.stores) {
        
        if (store.serviceIndex == service.index) {
            
            [self.selectedStores addObject:store];
            
             //3.刷新列表数据
            [self.storeTableView reloadData];
        }
        
    }
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.selectedStores.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YFStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"store" forIndexPath:indexPath];
    
    YFStore *store = [self.selectedStores objectAtIndex:indexPath.row];
    
    //从缓存中取图片
    NSString* strUrl = self.selectedService.imagePath;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
    
    SDImageCache* cache = [SDImageCache sharedImageCache];
    
    cell.imageView.image = [cache imageFromDiskCacheForKey:key];
    
    cell.textLabel.text = store.name;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%s", __func__);
    
}

#pragma mark - 登出
- (IBAction)logout:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}

@end