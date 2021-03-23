#import <UIKit/UIKit.h>

@interface SBFluidSwitcherItemContainerHeaderView : UIView {
    UILabel* _firstTitleLabel;
}
@end
@interface SpringBoard : UIApplication
- (UIApplication *)_accessibilityFrontMostApplication;
@end
@interface SBApplication
-(NSString *)bundleIdentifier;
-(NSString *)displayName;
@end
@interface SBAppLayout: NSObject
-(BOOL)containsItemWithBundleIdentifier:(id)arg1;
@end
@interface SBFluidSwitcherItemContainer : UIView {
    SBFluidSwitcherItemContainerHeaderView* _iconAndLabelHeader;
}
- (void)setKillable:(BOOL)arg1;
@end
@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
-(id)recentAppLayouts;
-(void)_deleteAppLayoutsMatchingBundleIdentifier:(id)arg1;
@end