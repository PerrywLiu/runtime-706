/*
 * Copyright (c) 1999-2007 Apple Inc.  All Rights Reserved.
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

/***********************************************************************
* objc-cache.m
* Method cache management
* Cache flushing
* Cache garbage collection
* Cache instrumentation
* Dedicated allocator for large caches
**********************************************************************/


/***********************************************************************
 * Method cache locking (GrP 2001-1-14)
 *
 * For speed, objc_msgSend does not acquire any locks when it reads 
 * method caches. Instead, all cache changes are performed so that any 
 * objc_msgSend running concurrently with the cache mutator will not 
 * crash or hang or get an incorrect result from the cache. 
 *
 * When cache memory becomes unused (e.g. the old cache after cache 
 * expansion), it is not immediately freed, because a concurrent 
 * objc_msgSend could still be using it. Instead, the memory is 
 * disconnected from the data structures and placed on a garbage list. 
 * The memory is now only accessible to instances of objc_msgSend that 
 * were running when the memory was disconnected; any further calls to 
 * objc_msgSend will not see the garbage memory because the other data 
 * structures don't point to it anymore. The collecting_in_critical
 * function checks the PC of all threads and returns FALSE when all threads 
 * are found to be outside objc_msgSend. This means any call to objc_msgSend 
 * that could have had access to the garbage has finished or moved past the 
 * cache lookup stage, so it is safe to free the memory.
 *
 * All functions that modify cache data or structures must acquire the 
 * cacheUpdateLock to prevent interference from concurrent modifications.
 * The function that frees cache garbage must acquire the cacheUpdateLock 
 * and use collecting_in_critical() to flush out cache readers.
 * The cacheUpdateLock is also used to protect the custom allocator used 
 * for large method cache blocks.
 *
 * Cache readers (PC-checked by collecting_in_critical())
 * objc_msgSend*
 * _cache_getImp
 * _cache_getMethod
 *
 * Cache writers (hold cacheUpdateLock while reading or writing; not PC-checked)
 * _cache_fill         (acquires lock)
 * _cache_expand       (only called from cache_fill)
 * _cache_create       (only called from cache_expand)
 * bcopy               (only called from instrumented cache_expand)
 * flush_caches        (acquires lock)
 * _cache_flush        (only called from cache_fill and flush_caches)
 * _cache_collect_free (only called from cache_expand and cache_flush)
 *
 * UNPROTECTED cache readers (NOT thread-safe; used for debug info only)
 * _cache_print
 * _class_printMethodCaches
 * _class_printDuplicateCacheEntries
 * _class_printMethodCacheStatistics
 *
 * _class_lookupMethodAndLoadCache is a special case. It may read a 
 * method triplet out of one cache and store it in another cache. This 
 * is unsafe if the method triplet is a forward:: entry, because the 
 * triplet itself could be freed unless _class_lookupMethodAndLoadCache 
 * were PC-checked or used a lock. Additionally, storing the method 
 * triplet in both caches would result in double-freeing if both caches 
 * were flushed or expanded. The solution is for _cache_getMethod to 
 * ignore all entries whose implementation is _objc_msgForward_impcache, 
 * so _class_lookupMethodAndLoadCache cannot look at a forward:: entry
 * unsafely or place it in multiple caches.
 ***********************************************************************/

#if !__OBJC2__

#endif
