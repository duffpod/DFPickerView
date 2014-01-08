//
//  PickerView.h
//  TestPicker
//
//  Created by Paul Semionov on 08.01.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    DFPickerViewStyleLight = 0,
    DFPickerViewStyleDark

} DFPickerViewStyle;

#if NS_BLOCKS_AVAILABLE
typedef void(^CancelBlock)();
typedef void(^DoneBlock)(NSInteger selectedIndex, id selectedObject);
typedef void(^SelectionBlock)(NSInteger selectedIndex, id selectedObject);
typedef NSString *(^ConverterBlock)(id object);
#endif

@interface DFPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) DFPickerViewStyle style;
@property (nonatomic) CGFloat animationDuration;

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done;

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done
             index:(NSInteger)index;

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done
             index:(NSInteger)index
          animated:(BOOL)animated;

@end
