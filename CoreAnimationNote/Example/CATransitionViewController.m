//
//  CATransitionViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()

@property (strong, nonatomic) UILabel *lb;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    lb.text = @"CATransition Test";
    lb.backgroundColor = UIColor.lightGrayColor;
    lb.userInteractionEnabled = YES;
    [lb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
    [self.view addSubview:lb];
    _lb = lb;
}

-(void)tapClick: (UITapGestureRecognizer*)sender{
    NSLog(@"%s", __func__);
    
    NSArray *typeArray = @[kCATransitionFade, kCATransitionPush, kCATransitionMoveIn, kCATransitionReveal, @"cube", @"suckEffect", @"oglFlip", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = [typeArray objectAtIndex:(_lb.tag%typeArray.count)];
//    transition.subtype = kCATransitionFromRight;//方向
    transition.duration = 0.5;
    [_lb.layer addAnimation:transition forKey:nil];
    
    _lb.text = [NSString stringWithFormat:@"%@ Test %ld", transition.type, _lb.tag];
    [_lb setTag:_lb.tag+1];
}

/*
 
 过渡动画CATransition
 
 1.过渡动画简介
 属性动画只能对图层的可动画属性起作用，而过渡动画可以改变非动画属性(比如交换一段文本和图片)，或者从层级关系中添加或者移除图层；于是就有了过渡的概念；

 过渡动画使用CATransition来实现，它同样是CAAnimation的子类；它并不像属性动画那样在平滑的两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。

 过渡动画通常用于删除子控件、添加子控件、切换两个子控件等。
 
 2.过渡动画属性介绍
 过渡动画有type和subtype两个关键属性，type用于指定动画类型，subtype用于指定动画移动的方向；
 type属性:
 type属性是一个NSString类型，用于控制整体动画效果类型，具体的可选类型如下：
 
 type值                          动画效果                对应常量                        是否支持方向
 fade                           默认效果，渐变            kCATransitionFade                 否
 moveIn                         覆盖                    kCATransitionMoveIn              是
 Push                           退出                    kCATransitionPush                 是
 Reveal                         揭开                    kCATransitionReveal               是
 cube                           立方体                  无(私有类型)                       是
 suckEffect                     收缩                    无(私有类型)                       否
 oglFlip                        翻转                    无(私有类型)                       是
 rippleEffect                   水波动画                无(私有类型)                        否
 pageCurl                       页面揭开                无(私有类型)                     只支持左右方向
 vpageUnCurl                    放下页面                无(私有类型)                     只支持左右方向
 cameraIrisHollowOpen           镜头打开                无(私有类型)                     否
 cameraIrisHollowClose          镜头关闭                无(私有类型)                     否

 目前为止，我们只能使用type的前四种公开属性，但是我们可以通过一些别的方法来自定义过渡效果(后续介绍)；

 subtype属性:
 subtype属性也是一个NSString类型，用于控制动画方向，具体的可选类型如下：
 
 Subtype类型                      具体描述
 kCATransitionFromRight         从右向左
 kCATransitionFromLeft          从左向右
 kCATransitionFromTop           从上向下
 kCATransitionFromBottom        从下向上
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
