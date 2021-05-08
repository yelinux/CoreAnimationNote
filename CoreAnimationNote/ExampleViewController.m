//
//  ExampleViewController.m
//  CoreAnimationNote
//
//  Created by chenyehong on 2021/5/8.
//

#import "ExampleViewController.h"
#import "CABasicAnimationViewController.h"
#import "CAKeyframeAnimation1ViewController.h"
#import "CAKeyframeAnimation2ViewController.h"
#import "CAGroupAnimationViewController.h"
#import "CATransitionViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//基础动画CABasicAnimation
- (IBAction)click1:(id)sender {
    CABasicAnimationViewController *vc = [[CABasicAnimationViewController alloc] init];
    vc.title = @"基础动画CABasicAnimation";
    [self.navigationController pushViewController:vc animated:YES];
}

//关键帧动画CAKeyframeAnimation，使用values
- (IBAction)click2:(id)sender {
    CAKeyframeAnimation1ViewController *vc = [[CAKeyframeAnimation1ViewController alloc] init];
    vc.title = @"关键帧动画CAKeyframeAnimation(使用values)";
    [self.navigationController pushViewController:vc animated:YES];
}

//关键帧动画CAKeyframeAnimation，使用path
- (IBAction)click3:(id)sender {
    CAKeyframeAnimation2ViewController *vc = [[CAKeyframeAnimation2ViewController alloc] init];
    vc.title = @"关键帧动画CAKeyframeAnimation(使用path)";
    [self.navigationController pushViewController:vc animated:YES];
}

//动画组CAGroupAnimation
- (IBAction)click4:(id)sender {
    CAGroupAnimationViewController *vc = [[CAGroupAnimationViewController alloc] init];
    vc.title = @"动画组CAGroupAnimation";
    [self.navigationController pushViewController:vc animated:YES];
}

//过渡动画CATransition
- (IBAction)click5:(id)sender {
    CATransitionViewController *vc = [[CATransitionViewController alloc] init];
    vc.title = @"过渡动画CATransition";
    [self.navigationController pushViewController:vc animated:YES];
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
