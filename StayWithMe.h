#import <UIKit/UIKit.h>

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;               //@synthesize bundleIdentifier=_bundleIdentifier - In the implementation block
@end
@interface UIScrollView ()
-(void)_setContentOffsetAnimationDuration:(CGFloat)arg1;
@end
@interface SBFluidSwitcherItemContainerHeaderView : UIView {
    UILabel* _firstTitleLabel;
}
@end
@interface SpringBoard : UIApplication
-(UIApplication *)_accessibilityFrontMostApplication;
@end
@interface SBApplication
-(NSString *)bundleIdentifier;
-(NSString *)displayName;
@end
@interface SBAppLayout: NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
-(BOOL)containsItemWithBundleIdentifier:(id)arg1;
@end
@interface SBFluidSwitcherItemContainer : UIView {
    SBFluidSwitcherItemContainerHeaderView* _iconAndLabelHeader;
}
@end
@interface SBMainSwitcherViewController : UIViewController
+(id)sharedInstance;
-(void)_deleteAppLayoutsMatchingBundleIdentifier:(id)arg1;
-(void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
-(id)recentAppLayouts;
@end