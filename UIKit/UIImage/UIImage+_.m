//
//  UIImage+_.m
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "UIImage+_.h"
#import "PS_Head1.h"

@implementation UIImage (_)

- (UIImage *)ps_zipNSDataWithImage{
    //进行图像尺寸的压缩
    CGSize imageSize = self.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return [UIImage imageWithData:data];
}

+ (UIImage *)ps_imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)drawImagesize:(CGSize)size
          backgroundColor:(UIColor *)backgroundColor
          imageProportion:(CGFloat)proportion{
    UIImage *image = [UIImage imageNamed:@"default_img"];
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    [backgroundColor set];
    CGFloat legalSize = size.width > size.height ? size.height : size.width;
    CGFloat imageLegalSize = legalSize * proportion;
    UIRectFill(CGRectMake(0,0, size.width, size.height));
    CGFloat imageX = (size.width /2) - (imageLegalSize /2);
    CGFloat imageY = (size.height /2) - (imageLegalSize /2);
    [image drawInRect:CGRectMake(imageX, imageY, imageLegalSize, imageLegalSize)];
    UIImage *resImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}



@end


#pragma mark &************ radius

@implementation UIImage(Radius)

- (instancetype)initWithImage:(UIImage *) image size:(CGSize) size radius:(CGFloat)radius {
    if (self == [super init]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        // 获得图形上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        // 设置一个范围
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        // 根据radius的值画出路线
        CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
        // 裁剪
        CGContextClip(ctx);
        // 将原照片画到图形上下文
        [self drawInRect:rect];
        // 从上下文上获取剪裁后的照片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        self = newImage;
    }
    return self;
}

@end


@implementation UIImage(PSAddImage)

- (UIImage *)ps_insertImage:(UIImage *)image insertFrame:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)ps_saveToPhotoLibrary {
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void*)self);
    
    // 其他两种方法
//
//    ALAssetsLibrary *lib = [ALAssetsLibrary new];
//    [lib writeImageToSavedPhotosAlbum:self.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//
//    }];
//
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        //写入图片到相册
//        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:self];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        DebugLog(@"success = %d, error = %@", success, error);
//    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    DebugLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

+ (UIImage *)ps_resizeImage:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage *)ps_resizeImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

#pragma mark 截屏
+(instancetype)ps_renderView:(UIView *)renderView
{
    //应该给一个延迟的效果
    //获得图片上下文
    UIGraphicsBeginImageContextWithOptions(renderView.frame.size, NO, 0.0);
    //将控制器的view的layer渲染到图层
    [renderView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //去除图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    ///Users/think_lion/Desktop
    //将新图片压缩成二进制文件
    return newImage;
    
}

#pragma mark 裁剪图拍你的芳芳
+(instancetype)ps_clipWithImageName:(NSString *)name bordersW:(CGFloat)bordersW borderColor:(UIColor *)borderColor
{
    UIImage *oldImage=[UIImage imageNamed:name];
    CGFloat borberW=bordersW;
    CGFloat imageW=oldImage.size.width+borberW*2;
    CGFloat imageH=oldImage.size.height+borberW*2;
    CGSize  imageSize=CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef ref=UIGraphicsGetCurrentContext();
    //画一个大圆
    [borderColor set];
    CGFloat bigRadius=imageW*0.5;
    CGFloat bigX=imageW*0.5;
    CGFloat bigY=imageH*0.5;
    CGContextAddArc(ref, bigX, bigY, bigRadius, 0, M_PI*2, 0);
    //渲染到图层
    CGContextFillPath(ref);
    
    //画一个小圆
    CGFloat smallRadius=bigRadius-borberW;
    CGContextAddArc(ref, bigX, bigY, smallRadius, 0, M_PI*2, 0);
    //裁剪
    CGContextClip(ref);
    //画图
    [oldImage drawInRect:CGRectMake(borberW, borberW, oldImage.size.width, oldImage.size.height)];
    //去除图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}
#pragma mark 图片加水印的方法
+(instancetype)ps_waterWithBgName:(NSString *)bg waterLogo:(NSString *)water
{
    // 获得一张图片
    UIImage *bgName=[UIImage imageNamed:bg];
    //基于上下文 位图(bitmap) 将所有的东西绘制到一张新的图片上面去
    //1.创建一个基于位图的上下文
    //size 新图片的尺寸
    //opaque  YES 表示不透明 NO表示透明
    //运行这行代码后 旧相当于创建了一个新的bitmap  相当于创建了UIImage对象
    UIGraphicsBeginImageContextWithOptions(bgName.size, YES, 0.0);
    //2.话背景
    [bgName drawInRect:CGRectMake(0, 0, bgName.size.width, bgName.size.height)];
    //添加水印logo
    UIImage *logo=[UIImage imageNamed:water];
    CGFloat scale=0.2;
    CGFloat margin=5;
    CGFloat logoW=logo.size.width*scale;;
    CGFloat logoH=logo.size.height*scale;
    CGFloat logoX=bgName.size.width-logoW-margin;
    CGFloat logoY=bgName.size.height-logoH-margin;
    
    [logo drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    //4.从上下文去除获得的新图片对象
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //5.结束上下次文
    UIGraphicsEndImageContext();
    //返回新创建的图片对象
    return newImage;
}



@end
