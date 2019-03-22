//
//  DDModuleATestController.m
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "DDModuleATestController.h"

@interface DDModuleATestController ()

@property (nonatomic, strong, readwrite) UILabel *valueLabel;
@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, strong) UIButton *returnButton;

@end

@implementation DDModuleATestController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.returnButton];
    
    self.valueLabel.backgroundColor = [UIColor greenColor];
    self.imageView.backgroundColor = [UIColor orangeColor];
    self.returnButton.backgroundColor = [UIColor purpleColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.valueLabel sizeToFit];
    self.valueLabel.frame = CGRectMake(10, 120, 200, 36);
    self.imageView.frame = CGRectMake(10, CGRectGetMaxY(self.valueLabel.frame) + 30, 120, 120);
    self.returnButton.frame = CGRectMake(10, CGRectGetMaxY(self.imageView.frame) + 30, 100, 100);
    
}

#pragma mark - event response
- (void)didTappedReturnButton:(UIButton *)button
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - getters and setters
- (UILabel *)valueLabel
{
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont systemFontOfSize:30];
        _valueLabel.textColor = [UIColor blackColor];
    }
    return _valueLabel;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"return" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}
@end
