/* Copyright (c) 2012-2013 Apple Inc. All rights reserved.
 *
 * @APPLE_LICENSE_HEADER_START@
 * 
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this
 * file.
 * 
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 * 
 * @APPLE_LICENSE_HEADER_END@
 */

#ifndef __OS_DEBUG_LOG_H__
#define __OS_DEBUG_LOG_H__

#include <Availability.h>
#include <TargetConditionals.h>

//#include <os/base_private.h>
#include <stdarg.h>

__OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0)
//OS_FORMAT_PRINTF(1, 2) //修改
extern void
_os_debug_log(const char *msg, ...);

/* The os_debug_log macros insert spaces before the message. If logging to a file,
 * the spaces will be replaced by a timestamp. If logging to syslog, they will
 * be skipped (syslog knows what time it is). There are 20 spaces because the
 * timestamp is printed as %16llu + 4 spaces before the next column.
 * 10^16 ns = 3.8 months. Don't run your process in _debug for that long. This
 * isn't syslog.
 */
#define _OS_DEBUG_LOG_PREFIX "                    "

#define os_debug_log(tag, fmt, ...) __extension__({\
	_os_debug_log(_OS_DEBUG_LOG_PREFIX "%s: " fmt, tag, ## __VA_ARGS__); \
})

#define os_debug_log_ctx(tag, ctx, fmt, ...) __extension__({\
	_os_debug_log(_OS_DEBUG_LOG_PREFIX "[%p]  %s: " fmt, ctx, tag, ## __VA_ARGS__); \
})

/* This is useful for clients who wish for the messages generated by os_debug_log()
 * or os_assumes() failures to go somewhere other than (or in addition to) the
 * system log, for example launchd or syslogd itself. If you don't wish for the
 * message to be logged to the system log, then return true (to indicate that
 * the message has been handled). If you want the default behavior, return
 * false. Please use this macro, rather than directly declaring a function,
 * since the declaration magic may change in the future.
 */
#define os_debug_log_redirect(func) \
	__attribute__((__used__)) \
	__attribute__((__visibility__("default"))) \
	bool _os_debug_log_redirect_func(const char *msg) { \
		return func(msg); \
	}

# pragma mark -
# pragma mark Private To Libc

// str must be modifiable (non-const)!
__OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0)
extern void
_os_debug_log_error_str(char *str);

#endif /* __OS_DEBUG_LOG_H__ */
