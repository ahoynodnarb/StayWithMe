#import "StayWithMe.h"

static void refreshPrefs() {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.popsicletreehouse.staywithmeprefs"];
	isEnabled = [bundleDefaults objectForKey:@"isEnabled"] ? [[bundleDefaults objectForKey:@"isEnabled"]boolValue] : YES;
}
static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    refreshPrefs();
}

%hook SBFluidSwitcherItemContainer
%new
-(void)clearFromSwitcher:(NSString *)bundleIdentifier {
	SBMainSwitcherViewController *switcher = [%c(SBMainSwitcherViewController) sharedInstance];
	if(@available(iOS 14, *)) {
		[switcher _deleteAppLayoutsMatchingBundleIdentifier: bundleIdentifier];
	} else {
		for(SBAppLayout *layout in [switcher recentAppLayouts]) {
			SBDisplayItem *displayItem = [layout.rolesToLayoutItemsMap objectForKey:@1];
			if([displayItem.bundleIdentifier isEqualToString:bundleIdentifier]) {
				[switcher _deleteAppLayout:layout forReason:1];
			}
		}
	}
}
-(void)scrollViewDidScroll:(UIScrollView *)arg1 {
	%orig;
	UIScrollView *scrollView = arg1;
	SBApplication *foregroundApp = (SBApplication *)[(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
    if([%c(SparkAppList) doesIdentifier:@"com.popsicletreehouse.staywithmeprefs" andKey:@"excludedApps" containBundleIdentifier:[foregroundApp bundleIdentifier]] || !isEnabled)
		return;
	SBFluidSwitcherItemContainerHeaderView *currentHeaderView = MSHookIvar<SBFluidSwitcherItemContainerHeaderView*>(self, "_iconAndLabelHeader");
	UILabel *firstLabel = MSHookIvar<UILabel *>(currentHeaderView, "_firstTitleLabel");
	BOOL isFirstApp = firstLabel.text == [foregroundApp displayName];
	// if you scroll above threshold, it stops you from killing the app
	if (scrollView.contentOffset.y > 600.0f && isFirstApp) {
		//not using animatewithduration because it makes the other views around it break
		[scrollView _setContentOffsetAnimationDuration:0.18f];
		[scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) animated:YES];
	}
	// if you scroll below threshold, it kills the app
	else if (scrollView.contentOffset.y < -100.0f && isFirstApp) {
		[self clearFromSwitcher:[foregroundApp bundleIdentifier]];
	}
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.popsicletreehouse.staywithme.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
}