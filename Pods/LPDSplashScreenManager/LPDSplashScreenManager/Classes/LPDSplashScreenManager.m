//
//  LPDSplashScreenManager.m
//  Pods
//
//  Created by Assuner on 2017/4/21.
//
//

#import "LPDSplashScreenManager.h"
#import <SDWebImage/SDWebImageDownloader.h>


@interface LPDSplashScreenController: UIViewController

@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;

@end


@implementation LPDSplashScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = self.image;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

@end




@interface LPDSplashScreenManager ()

@property (nonatomic, copy) NSString *requestPath;

@property (nonatomic, strong) UIWindow *splashWindow;

@end


@implementation LPDSplashScreenManager

#define SPLASH_SCREEN_IMAGE_URL @"splash_screen_image_url"

static LPDSplashScreenManager *_manager = nil;
static dispatch_once_t _onceToken;

+ (LPDSplashScreenManager *)sharedManager {
    dispatch_once(&_onceToken, ^{
        _manager = [[LPDSplashScreenManager alloc] init];
    });
    return _manager;
}

+ (void)showSplashScreenWithImageUrl:(NSString *)url duration:(CGFloat)time {
    LPDSplashScreenManager *manager = [self sharedManager];
    manager.requestPath = url;
    NSData *imageDate = [NSData dataWithContentsOfFile:[self imageCachePath]];
    if (imageDate) {
        if (!manager.splashWindow) {
            manager.splashWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            manager.splashWindow.backgroundColor = [UIColor clearColor];
            manager.splashWindow.windowLevel = UIWindowLevelStatusBar + 10000;
            manager.splashWindow.rootViewController = [[LPDSplashScreenController alloc] initWithImage:[UIImage imageWithData:imageDate]];
            [manager.splashWindow makeKeyAndVisible];
            [manager performSelector:@selector(removeSplashScreen) withObject:nil afterDelay:(time > 0 ?: 1)];
        }
    } else {
        [manager startDownLoadNewImage];
    }
    
}

+ (void)clear {
    _manager = nil;
    _onceToken = 0;
}

- (void)removeSplashScreen {
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.splashWindow.rootViewController.view.layer setValue:@3 forKeyPath:@"transform.scale"];
        self.splashWindow.rootViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.splashWindow.windowLevel = normal;
        self.splashWindow = nil;
        [self startDownLoadNewImage];
    }];
}


- (void)startDownLoadNewImage {
    if ([self.requestPath isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:SPLASH_SCREEN_IMAGE_URL]]) {
        [LPDSplashScreenManager clear];
        return;
    } else {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.requestPath] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                [self performSelector:@selector(startDownLoadNewImage) withObject:nil afterDelay:20];
                return;
            }
            if ([data writeToFile:[LPDSplashScreenManager imageCachePath] atomically:YES]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.requestPath forKey:SPLASH_SCREEN_IMAGE_URL];
                [LPDSplashScreenManager clear];
            }
        }];
    }
}


+ (NSString *)imageCachePath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"splashScreenImage.png"];
}

@end

