#!/system/bin/sh

#
# Systemless Hosts by the
# open source loving 'GL-DP' and all contributors;
# Essential repack for latest Unified hosts, with 3 additional extensions
#

# Checking for installation environment
sleep 1
if [ $BOOTMODE = true ]; then
 ROOT=$(find `magisk --path` -type d -name "mirror" | head -n 1)
ui_print "- Root path: $ROOT"
else
 ROOT=""
fi

# Search hosts file location
sleep 1
ui_print "- Searching hosts file location"
 if [ -d /system/etc ]; then
 PATH=/system/etc
sleep 1
ui_print "   File found in: $PATH" 
 elif [ -d /system/product/etc ]; then
 PATH=/system/product/etc
sleep 1
ui_print "   File found in: $PATH"
 break
 else
sleep 1
ui_print "   File not found"
sleep 1
   abort "   Aborting"
 fi

# Patch default hosts file
sleep 1
ui_print "- Patching hosts file"
 mkdir -p $MODPATH$PATH
 mv -f $MODPATH/hosts $MODPATH$PATH

# Clean up
sleep 1
ui_print "- Cleaning up"
 rm -rf $MODPATH/hosts
 rm -rf $MODPATH/LICENSE

sleep 1
# Executing...
# Done
