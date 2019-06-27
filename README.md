SYiOS7ModalFix
==============

iOS 7 has a well known but where showing a modal view while the status bar is in prompt mode   (double height status bar, e.g. when user is in a call) the view would have a wrong position.

Using some cute swizzling this pod can fix it.

Usage :
=======

    [UINavigationController applyiOS7ModalFix_NavigationController];
    [UIViewController       applyiOS7ModalFix_ViewController];
    [UIView                 applyiOS7ModalFix_View];

Deprecated
==========

Since iOS 8 fixed it and not a lot of iOS 7 devices are still around this pod has been deprecated.

Read the code, share it, update it, fork it, it's all yours now. 

Please do not open an issue.
