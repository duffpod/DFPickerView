# DFPickerView

[![Version](http://cocoapod-badges.herokuapp.com/v/DFPickerView/badge.png)](http://cocoadocs.org/docsets/DFPickerView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/DFPickerView/badge.png)](http://cocoadocs.org/docsets/DFPickerView)

## Usage

	__block NSMutableArray *array = [NSMutableArray array];
    
    @autoreleasepool {
        
        for(int i = 1;i < 100;i++) {
            
            [array addObject:[NSNumber numberWithInteger:i]];
            
        }
        
    }
    
    self.pickerView = [[DFPickerView alloc] initWithStyle:DFPickerViewStyleDark]; // DFPickerViewStyleLight
    self.pickerView.animationDuration = 0.30f; // defaults to 0.23f
    [self.view addSubview:self.pickerView];
    
    [self.pickerView showInView:self.view withAnimations:nil completion:nil objects:array converter:^NSString *(id object) {
        
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


## Requirements

iOS 7 and later.

## Installation

DFPickerView is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "DFPickerView"

## Author

duffpod, duffpod@gmail.com

## License

DFPickerView is available under the MIT license. See the LICENSE file for more info.

