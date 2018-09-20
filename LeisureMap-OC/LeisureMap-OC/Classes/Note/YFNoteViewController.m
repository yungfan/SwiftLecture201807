//
//  YFNoteViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/20.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFNoteViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CHTCollectionViewWaterfallLayout.h>
#import "YFWaterfallCell.h"
#import "YFImageTools.h"
#import "YFDialogTools.h"


@interface YFNoteViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

//选择图片或拍照
@property(nonatomic, strong) UIImagePickerController *pickerController;

//导航栏拍照按钮
- (IBAction)takePhoto:(id)sender;

//瀑布流UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//瀑布流大小数组
@property (nonatomic, strong) NSArray *cellSizes;

//网络图片URL
@property (nonatomic, strong) NSMutableArray<NSString *> *imageURLs;

//相册图片
@property (nonatomic, strong) NSMutableArray<UIImage *> *imageFromLocal;

@end

@implementation YFNoteViewController

//懒加载UIImagePickerController
-(UIImagePickerController *)pickerController{
    
    if (_pickerController == nil) {
        
        _pickerController = [[UIImagePickerController alloc]init];
        
        _pickerController.delegate = self;
        
    }
    
    return _pickerController;
    
}

//懒加载cellSizes
- (NSArray *)cellSizes {
    if (!_cellSizes) {
        
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(550, 550)],
                       [NSValue valueWithCGSize:CGSizeMake(550, 750)],
                       [NSValue valueWithCGSize:CGSizeMake(550, 950)],
                       [NSValue valueWithCGSize:CGSizeMake(550, 1150)]
                       ];
    }
    return _cellSizes;
}

//懒加载imageFromLocal
- (NSMutableArray *)imageFromLocal {
    
    if (!_imageFromLocal) {
        
        _imageFromLocal = [NSMutableArray array];
    }
    return _imageFromLocal;
}

//懒加载imageURLs
- (NSMutableArray *)imageURLs {
    
    if (!_imageURLs) {
        
        NSArray *temp = @[
                          
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537439305249&di=f97a4512250516cc096739721d130ba0&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0141f955425e750000019ae903e08c.jpg%402o.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446868&di=9ee7834043f3d2da8e858dfe443ae94a&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01de2158a69107a801219c776a1806.png%401280w_1l_2o_100sh.png",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446866&di=f093d38c6a5ad168b467bc053d4e9344&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014c2955b59f1732f875251ff28b93.png",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446865&di=17a36409396b0fc457b03b59b01c4ddd&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0150d958b6945da801219c77035689.jpg%401280w_1l_2o_100sh.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537439305249&di=f97a4512250516cc096739721d130ba0&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0141f955425e750000019ae903e08c.jpg%402o.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446868&di=9ee7834043f3d2da8e858dfe443ae94a&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01de2158a69107a801219c776a1806.png%401280w_1l_2o_100sh.png",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446866&di=f093d38c6a5ad168b467bc053d4e9344&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014c2955b59f1732f875251ff28b93.png",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537437446865&di=17a36409396b0fc457b03b59b01c4ddd&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0150d958b6945da801219c77035689.jpg%401280w_1l_2o_100sh.jpg"
                          ];
        
        _imageURLs = [NSMutableArray arrayWithArray:temp];
    }
    return _imageURLs;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupCollectionView];

}

//设置瀑布流布局
-(void)setupCollectionView{
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.minimumColumnSpacing = 10;
    
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = [UIColor orangeColor];
    
}

- (IBAction)takePhoto:(id)sender {
    
    UIAlertController *sheet = [[YFDialogTools sharedTool] alertWithTitle:@"选择照片" message:@"请根据菜单选择不同的方式" style:StyleActionSheet actionTitles:@[@"相机", @"相册",@"取消"] actionStyles:@[@(UIAlertActionStyleDefault) ,@(UIAlertActionStyleDestructive), @(UIAlertActionStyleCancel)] alerAction:^(NSInteger index) {
        
        if (index == 0) {
            
            self.pickerController.sourceType  = UIImagePickerControllerSourceTypeCamera;

            self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
       
            self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            
            self.pickerController.allowsEditing = YES;

            [self presentViewController:self.pickerController animated:YES completion:nil];
        }
        
        else if(index == 1){

            self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            self.pickerController.allowsEditing = YES;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
            
        }
    }];
    
    [self presentViewController:sheet animated:YES completion:nil];

}

#pragma  mark - UIImagePickerControllerDelegate
//选择图片或者拍照成功以后回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@", info);
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        [self.pickerController dismissViewControllerAnimated:YES completion:nil];
        
        UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        
        //UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
 
        if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
            //拍照后需要保存到相册就加上这句话
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        [self.imageFromLocal addObject:image];
        
        [self.collectionView reloadData];
        
        
    }
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageURLs.count + self.imageFromLocal.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YFWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterfall"
                                                                                forIndexPath:indexPath];
    //先加载网络图片
    if (indexPath.row < self.imageURLs.count) {
        
        [[YFImageTools sharedTool]imageWithTarget:cell.imageView URL:self.imageURLs[indexPath.row] placeHolder:@"timg"];
    }
    
    //加载本地相册
    else{
    
        NSInteger index = indexPath.row - self.imageURLs.count;
        
        cell.imageView.image = self.imageFromLocal[index];
    }
    
    return cell;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellSizes[indexPath.row % self.cellSizes.count] CGSizeValue];
}


-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}
@end
