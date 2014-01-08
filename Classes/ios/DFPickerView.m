//
//  PickerView.m
//  TestPicker
//
//  Created by Paul Semionov on 08.01.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import "DFPickerView.h"

@interface DFPickerView()

@property (nonatomic, retain) NSArray *objects;
@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIBarButtonItem *cancelButton;
@property (nonatomic, retain) UIBarButtonItem *doneButton;

@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) DoneBlock doneBlock;
@property (nonatomic, copy) SelectionBlock selectionBlock;
@property (nonatomic, copy) ConverterBlock converterBlock;

@property (nonatomic, retain) UIColor *textColor;

@end

@implementation DFPickerView

@synthesize objects = _objects;
@synthesize selectedIndex = _selectedIndex;

@synthesize animationDuration = _animationDuration;

@synthesize cancelBlock = _cancelBlock;
@synthesize doneBlock = _doneBlock;
@synthesize selectionBlock = _selectionBlock;
@synthesize converterBlock = _converterBlock;

@synthesize textColor = _textColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [self addSubview:self.toolbar];
        
        self.cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        
        [self.toolbar setItems:@[self.cancelButton, space, self.doneButton]];
        
        CGFloat x = self.toolbar.frame.origin.x;
        CGFloat y = self.toolbar.frame.origin.y + self.toolbar.frame.size.height;
        CGFloat height = self.frame.size.height - y;
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(x, y, self.frame.size.width, height)];
        self.pickerView.delegate = self;
        [self addSubview:self.pickerView];

    }
    return self;
}

- (void)setStyle:(DFPickerViewStyle)style {
    
    switch (style) {
        case DFPickerViewStyleLight:
            _toolbar.barStyle = UIBarStyleDefault;
            _pickerView.backgroundColor = [UIColor clearColor];
            _cancelButton.tintColor = self.window.tintColor;//[UIColor colorWithRed:0.06f green:0.52f blue:0.98f alpha:1.00f];
            _doneButton.tintColor = self.window.tintColor;
            _textColor = [UIColor blackColor];
            break;
        case DFPickerViewStyleDark:
            _toolbar.barStyle = UIBarStyleBlack;
            _pickerView.backgroundColor = [UIColor colorWithRed:0.36f green:0.36f blue:0.36f alpha:1.00f];
            _cancelButton.tintColor = [UIColor whiteColor];
            _doneButton.tintColor = [UIColor whiteColor];
            _textColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
    
}

#pragma mark --
#pragma mark -- Actions

- (void)cancelButtonPressed:(UIBarButtonItem *)cancelButton {
    
    if(_cancelBlock) {
        
        _cancelBlock();
        _cancelBlock = nil;
        
    }
    
    [self hide];
    
}

- (void)doneButtonPressed:(UIBarButtonItem *)doneButton {
    
    if(_doneBlock) {
        
        _doneBlock(_selectedIndex, [_objects objectAtIndex:_selectedIndex]);
        _doneBlock = nil;
        
    }
    
    [self hide];
    
}

#pragma mark --
#pragma mark -- UIPickerView datasource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _objects.count;
    
}

#pragma mark --
#pragma mark -- UIPickerView delegate methods

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *string;
    
    if(_converterBlock) {
        
        string = _converterBlock([_objects objectAtIndex:row]);
        
    }
    
    if(string.length == 0) {
        
        string = @"No data specified";
        
    }
    
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : _textColor}];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(_selectionBlock) {
    
        _selectionBlock(row, [_objects objectAtIndex:row]);
        
    }
    
    _selectedIndex = row;
    
}

#pragma mark --
#pragma mark -- Appearence actions

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done {
    
    [self showInView:view
      withAnimations:animations
          completion:completion
             objects:objects
           converter:converter
           selection:selection
              cancel:cancel
                done:done
               index:0
            animated:NO];
    
}

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done
             index:(NSInteger)index {
    
    [self showInView:view
      withAnimations:animations
          completion:completion
             objects:objects
           converter:converter
           selection:selection
              cancel:cancel
                done:done
               index:index
            animated:NO];
    
}

- (void)showInView:(UIView *)view
    withAnimations:(void(^)(CGRect pickerFrame))animations
        completion:(void(^)(BOOL finished))completion
           objects:(NSArray *)objects
         converter:(ConverterBlock)converter
         selection:(SelectionBlock)selection
            cancel:(CancelBlock)cancel
              done:(DoneBlock)done
             index:(NSInteger)index
          animated:(BOOL)animated {
    
    self.objects = objects;
    [_pickerView reloadComponent:0];
    
    self.converterBlock = converter;
    self.selectionBlock = selection;
    self.cancelBlock = cancel;
    self.doneBlock = done;
    
    [_pickerView selectRow:index inComponent:0 animated:animated];
    
    CGFloat duration = _animationDuration == 0 ? 0.23f : _animationDuration;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame = CGRectOffset(self.frame, 0, -self.frame.size.height);
        
        if(animations) {
            
            animations(self.frame);
            
        }
        
    } completion:^(BOOL finished) {
        
        if(completion) {
            
            completion(finished);
            
        }
        
    }];
    
}

- (void)hide {
    
    CGFloat duration = _animationDuration == 0 ? 0.23f : _animationDuration;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame = CGRectOffset(self.frame, 0, self.frame.size.height);
        
//        if(animations) {
//            
//            animations(self.frame);
//            
//        }
        
    } completion:^(BOOL finished) {
        
        if(finished) {
            
            [self removeFromSuperview];
            self.objects = nil;
            self.selectionBlock = nil;
            self.converterBlock = nil;
            
        }
        
    }];
    
}

@end
