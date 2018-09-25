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
#import "YFWaterFall.h"


@interface YFNoteViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

//选择图片或拍照
@property(nonatomic, strong) UIImagePickerController *pickerController;

//瀑布流UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//瀑布流Model数组
@property (nonatomic, strong) NSArray<YFWaterFall *> * waterFall;

//相册图片
@property (nonatomic, strong) NSMutableArray<UIImage *> *imageFromLocal;

//导航栏拍照按钮
- (IBAction)takePhoto:(id)sender;

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

//懒加载imageFromLocal
- (NSMutableArray *)imageFromLocal {
    
    if (!_imageFromLocal) {
        
        _imageFromLocal = [NSMutableArray array];
    }
    return _imageFromLocal;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Note", @"Note");

    [self setupCollectionView];
    
    [self setupData];

}

//设置瀑布流布局
-(void)setupCollectionView{
    
    //用的是第三方的CHTCollectionViewWaterfallLayout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView.collectionViewLayout = layout;
    
}

//设置瀑布流数据
-(void)setupData {
    
    [YFWaterFall getWaterFall:^(NSArray * _Nonnull waterfall) {
        
        self.waterFall = waterfall;
        
        [self.collectionView reloadData];
        
    }];
}



#pragma  mark - UIImagePickerControllerDelegate
//选择图片或者拍照成功以后回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        [self.pickerController dismissViewControllerAnimated:YES completion:nil];
        
        UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        
        //UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
 
        if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
            //拍照后需要保存到相册就加上这句话
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        //拍照或者从相册取数据 就添加到本地的相册图片数组中
        [self.imageFromLocal addObject:image];
        
        [self.collectionView reloadData];
        
        
    }
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //服务器+本地拍照或相册
    return self.waterFall.count + self.imageFromLocal.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YFWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterfall"
                                                                                forIndexPath:indexPath];
    //先加载网络图片
    if (indexPath.row < self.waterFall.count) {
        
        [[YFImageTools sharedTool]imageWithTarget:cell.imageView URL:self.waterFall[indexPath.row].imagePath placeHolder:@"timg"];
    }
    
    //加载本地拍照或相册
    else{
    
        NSInteger index = indexPath.row - self.waterFall.count;
        
        cell.imageView.image = self.imageFromLocal[index];
    }
    
    return cell;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //瀑布流大小由服务器返回 本地数据随服务器 所以要取余
    CGSize size =  CGSizeFromString(self.waterFall[indexPath.row % self.waterFall.count].size);

    return size;
    
    
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

-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}
@end
