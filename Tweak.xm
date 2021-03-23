#import "StayWithMe.h"

%hook SBFluidSwitcherItemContainer
// -(void)layoutSubviews {
// 	SBApplication *foregroundApp = (SBApplication *)[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
// 	NSString *frontDisplayName = [foregroundApp displayName];
// 	for(SBFluidSwitcherItemContainerHeaderItem *appHeader in [self headerItems]) {
// 		if([[appHeader titleText] isEqualToString: frontDisplayName])
// 			[self setKillable: NO];
// 	}
// 	%orig;
// }
-(void)scrollViewDidScroll:(id)arg1 {
	UIScrollView *scrollView = ((UIScrollView *)arg1);
	SBApplication *foregroundApp = (SBApplication *)[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
	NSString *frontDisplayName = [foregroundApp displayName];
	for(SBFluidSwitcherItemContainerHeaderItem *appHeader in [self headerItems]) {
		BOOL isFirstApp = [[appHeader titleText] isEqualToString: frontDisplayName];
		if(scrollView.contentOffset.y > 600.0f && isFirstApp) {
			CGPoint origin = CGPointMake(scrollView.contentOffset.x, 0.0f);
			[UIView animateWithDuration:0.5 animations:^{
    			[scrollView setContentOffset:origin animated:NO];
			}];
		}
		else if (scrollView.contentOffset.y < 0.0f && isFirstApp) {
			[[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication] terminateWithSuccess];
		}
	}
	%orig;
}
%end