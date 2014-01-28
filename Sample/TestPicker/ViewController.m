//
//  ViewController.m
//  TestPicker
//
//  Created by Paul Semionov on 08.01.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import "ViewController.h"
#import "DFPickerView.h"

@interface ViewController ()

@property (nonatomic, strong) DFPickerView *pickerView;

- (IBAction)show:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    
    if(self.pickerView) return;

    __block NSMutableArray *array = [NSMutableArray array];
    
    @autoreleasepool {
        
        for(int i = 1;i < 100;i++) {
            
            [array addObject:[NSNumber numberWithInteger:i]];
            
        }
        
    }
    
    self.pickerView = [[DFPickerView alloc] initWithStyle:DFPickerViewStyleDark]; // DFPickerViewStyleLight
    self.pickerView.animationDuration = 0.30f; // defaults to 0.23f
    [self.view addSubview:self.pickerView];
    
    [self.pickerView showWithAnimations:nil completion:nil objects:array converter:^NSString *(id object) {
        
        return [[object stringValue] stringByAppendingString:@" pcs."];
        
    } selection:^(NSInteger selectedIndex, id selectedObject) {
        
        NSLog(@"Selecting object: %@ at index: %i", selectedObject, selectedIndex);
        
    } cancel:^{
        
        array = nil;
        self.pickerView = nil;
        
        NSLog(@"Cancelled");
        
    } done:^(NSInteger selectedIndex, id selectedObject) {
        
        array = nil;
        self.pickerView = nil;
        
        NSLog(@"Completed with object: %@ at index: %i", selectedObject, selectedIndex);
        
    }];
    
}

@end
