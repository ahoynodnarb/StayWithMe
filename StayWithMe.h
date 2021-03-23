#import <UIKit/UIKit.h>

@interface SBFluidSwitcherTouchPassThroughScrollView : UIScrollView
@end
@interface SpringBoard : UIApplication
- (UIApplication *)_accessibilityFrontMostApplication;
@end
@interface UIApplication ()
- (void)terminateWithSuccess;
@end
@interface SBApplication
- (NSString *)displayName;
@end
@interface SBFluidSwitcherItemContainerHeaderItem
@property(nonatomic, copy) NSString *titleText;
@end
@interface SBFluidSwitcherItemContainer : UIView
- (NSArray *)headerItems;
- (BOOL)isDragging;
- (void)layoutSubviews;
- (void)setKillable:(BOOL)arg1;
@end