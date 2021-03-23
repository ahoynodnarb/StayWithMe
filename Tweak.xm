//TODO: Blacklist apps?
//TODO: Whitelist apps?

#import "StayWithMe.h"

%hook SBFluidSwitcherItemContainer
-(void)scrollViewDidScroll:(UIScrollView *)arg1 {
	%orig;
	UIScrollView *scrollView = arg1;
	SBApplication *foregroundApp = (SBApplication *)[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
	SBFluidSwitcherItemContainerHeaderView *currentHeaderView = MSHookIvar<SBFluidSwitcherItemContainerHeaderView*>(self, "_iconAndLabelHeader");
	UILabel *firstLabel = MSHookIvar<UILabel *>(currentHeaderView, "_firstTitleLabel");
	BOOL isFirstApp = firstLabel.text == [foregroundApp displayName];
	// if you scroll above threshold, it stops you from killing the app
	if (scrollView.contentOffset.y > 600.0f && isFirstApp) {
		//not using animatewitfhduration because it makes the other views around it break
		[scrollView _setContentOffsetAnimationDuration:0.18f];
		[scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) animated:YES];
	}
	// if you scroll below threshold, it kills the app
	else if (scrollView.contentOffset.y < -100.0f && isFirstApp) {
		SBMainSwitcherViewController *switcher = [%c(SBMainSwitcherViewController) sharedInstance];
		if(@available(iOS 14, *)) {
			[switcher _deleteAppLayoutsMatchingBundleIdentifier: [foregroundApp bundleIdentifier]];
		} else {
			for(SBAppLayout *layout in [switcher recentAppLayouts]) {
				SBDisplayItem *displayItem = [layout.rolesToLayoutItemsMap objectForKey:@1];
				if([displayItem.bundleIdentifier isEqualToString:[foregroundApp bundleIdentifier]]) {
					[switcher _deleteAppLayout:layout forReason:1];
				}
			}
		}
	}
}
%end