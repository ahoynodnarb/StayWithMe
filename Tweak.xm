#import "StayWithMe.h"

%hook SBFluidSwitcherItemContainer
-(void)scrollViewDidScroll:(id)arg1 {
	UIScrollView *scrollView = ((UIScrollView *)arg1);
	SBApplication *foregroundApp = (SBApplication *)[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
	SBMainSwitcherViewController *mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
	NSArray *items = [mainSwitcher recentAppLayouts];
	for(SBAppLayout *app in items) {
		SBFluidSwitcherItemContainerHeaderView *currentHeaderView = MSHookIvar<SBFluidSwitcherItemContainerHeaderView*>(self, "_iconAndLabelHeader");
		UILabel *firstLabel = MSHookIvar<UILabel *>(currentHeaderView, "_firstTitleLabel");
		BOOL isFirstApp = [app containsItemWithBundleIdentifier: [foregroundApp bundleIdentifier]] && firstLabel.text == [foregroundApp displayName];
		if (scrollView.contentOffset.y > 600.0f && isFirstApp) {
			[self setKillable:NO];
		}
		else if (scrollView.contentOffset.y < -100.0f && isFirstApp) {
			[mainSwitcher _deleteAppLayoutsMatchingBundleIdentifier: [foregroundApp bundleIdentifier]];
		}
	}
	%orig;
}
%end