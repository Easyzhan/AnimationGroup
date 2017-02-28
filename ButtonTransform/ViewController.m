//
//  ViewController.m
//  ButtonTransform
//
//  Created by Zin_戦 on 17/2/28.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
{
    NSInteger angle;
}
- (IBAction)buttonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@end

@implementation ViewController
- (IBAction)back:(id)sender {
    UIView *parentView = [self.view viewWithTag:1000];
    parentView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _circleButton.layer.cornerRadius = 62;
    _circleButton.clipsToBounds = YES;
    _circleButton.opaque = YES;
    [_circleButton setBackgroundImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view, typically from a nib.
    
    //需要翻转的视图
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 -100, 150, 200, 320)];
    parentView.backgroundColor = [UIColor yellowColor];
    parentView.tag = 1000;
    parentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"test"].CGImage);
//  [self.view addSubview:parentView];
}

- (IBAction)buttonAction:(UIButton *)sender {
    [self startAnimation];
}

//动画效果执行完毕
- (void) animationFinished: (id) sender{
    NSLog(@"animationFinished !");
}
-(void) startAnimation
{
/**-----------------------360°旋转动画--方法二---------------------------------------*/
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _circleButton.transform = endAngle;
        
        _circleButton.layer.transform = CATransform3DMakeRotation(angle * (M_PI / 180.0f) , 0 , 1 , 0 );
    } completion:^(BOOL finished) {
        angle += 10; [self startAnimation];
    }];
/**-----------------------360°旋转动画--方法三---------------------------------------*/
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.duration = 3;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = 2;
//    
//    [_circleButton.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//        UIView *parentView = [self.view viewWithTag:1000];
//    [parentView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)endAnimation
{
    angle += 10;
    [self animationRotate];
}

- (CAAnimation *) animationRotate {
    CATransform3D rotationTransform  = CATransform3DMakeRotation(angle * (M_PI / 180.0f) , 0 , 1 , 0 );
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = 1;
    animation.autoreverses = YES;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.beginTime = 0.1;
    animation.delegate = self;
    return animation;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
//    // 平移
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    
//    anim.keyPath = @"position";
//    
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200), arc4random_uniform(500))];
    
    // 缩放
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    
    anim1.keyPath = @"transform.scale";
    
    // 0 ~ 1
    static CGFloat scale = 0.1;
    if (scale < 1) {
        scale = 1.5;
    }else{
        scale = 0.2;
    }
    anim1.toValue = @(scale);
    
    // 旋转
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    
    anim2.keyPath = @"transform.rotation.y";
    
    anim2.toValue = @((360) / 180.0 * M_PI);
    
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:2.0];
    
    group.animations = @[anim1,anim2,opacityAnimation];
    
    group.duration = 0.5;
    
    // 取消反弹
    // 告诉在动画结束的时候不要移除
    group.removedOnCompletion = NO;
    // 始终保持最新的效果
    group.fillMode = kCAFillModeForwards;
    
    [_circleButton.layer addAnimation:group forKey:nil];
}

@end
