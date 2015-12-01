framework-res-overlay
=====================

Using of /res - only overlay.apk(s) for changing /res-elements  in target.apk(s):


The rro (runtime resource overlay) - method is used for manipulating only resource-entries(elements) that should be changed at runtime,
without using a complete new standalone.apk.
This means we can use overlay.apk to deliver elements, that should be changed at runtime of an target.apk.
Those elements could be any matching resource in the target.apk.

In example:

the system's standard Navigation Bar Height is defined in original target '/system/framework-res.apk/res/values/dimens.xml'

To change the Navigation Bar Height-values at runtime (without having a completely new 'framework-res.apk', we can compile an
overlay.apk, that holds only the xml elements that we want to have changed at runtime (after reboot of course).

The new overlay can be named i.e. 'framework-res-overlay.apk'.
This overlay.apk will be (has to be!) compiled without any code/classses!
It will copiled ONLY with resources!

The AndroidManifest.xml will have to have a xml-key, that provides the packagename of the target.apk!

code of AndroidManifest.xml will look like this(!):

overlay android:targetPackage="android" android:priority="1"

See the AndroidManifest.xml of this project...


(The android_packagename of our sample target '/system/framework/framework-res.apk' is 'android' on Lollipop-OS)


Now we have to place a tiny xml-file as /res/values/dimens.xml for our new overlay.apk 'framework-res.apk', 
that holds only the xml-key-value-pairs, which we want to change on the target apk(!):


the code for new '/res/values/dimens.xml' will look like this:

<?xml version="1.0" encoding="utf-8"?>
<resources>
    
    <dimen name="navigation_bar_height">96.0dip</dimen>
    <dimen name="navigation_bar_height_landscape">96.0dip</dimen>
</resources>

Keep in mind, that we have to use matching resource-entries, that really exist in the target.apk!

so we define the runtime-changes for the Navigation Bar Height!

We have to compile the new overlay.apk (without any source-code-classes!), as 'framework-res-overlay.apk' i.e.

After that, we copy the new overlay.apk ('framework-res-overlay.apk') to the device 
into /vendor/overlay/ramework-res-overlay.apk

(If this folder doesn't exit on device we have to mkdir it of course!)

After doing this and rebooting,
the new Navigation Bar Height values will override the default values of the target.apk 
(/system/framework/framework-res.apk) 
that we had indicated by it's packagename "android" via the android:targetPackagname in
our overlay's Androidmanifest.xml


Tests with compiling the overlay.apk with aapt via command line (only) 
failed here - So I use eclipse for compiling the overlay.apk(s)....







