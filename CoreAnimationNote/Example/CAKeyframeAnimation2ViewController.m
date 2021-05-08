//
//  CAKeyframeAnimation2ViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "CAKeyframeAnimation2ViewController.h"

@interface CAKeyframeAnimation2ViewController ()

@end

@implementation CAKeyframeAnimation2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    //1.创建三次贝塞尔曲线(一种使用起始点，结束点和另外两个控制点定义的曲线);
    UIBezierPath *bezierPath  = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(50, 200)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 50, 200) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(CGRectGetWidth(self.view.bounds) - 150, 250)];
    
    //2.绘制飞行路线(此步骤对于动画不是必须的，只是为了动画看起来更直观)
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //3.创建显示飞机的视图
    UIImageView *airPlaneImgView = [[UIImageView alloc] init];
    airPlaneImgView.frame = CGRectMake(0, 0, 50, 50);
    airPlaneImgView.center = CGPointMake(50, 200);
    airPlaneImgView.image = [UIImage imageNamed:@"airplane"];
    airPlaneImgView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:airPlaneImgView];
    
    //4.设置关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 5.0;
    animation.path = bezierPath.CGPath;
    animation.repeatCount = MAXFLOAT; //重复执行
    animation.rotationMode = kCAAnimationRotateAuto; //设置根据曲线的切线自动旋转,让动画更加真实
    [airPlaneImgView.layer addAnimation:animation forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
