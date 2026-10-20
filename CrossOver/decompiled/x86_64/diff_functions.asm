; CrossOver 26.3 — functions whose references differ between slices
; objdump listings from REA evidence ev_3e3af8da6fe5694dc184791c4755683894ac5bc4da3caf95a840fd1ca902a343 (x86_64) and ev_be740f96d13b18f1147404d9cca0dc483fac76d20283b87339857ccc3eb23143 (arm64),
; annotated by .slicediff.py with resolved selectors/imports/strings.
; arm64 notes follow adrp pages linearly; a page carried across basic
; blocks can be mislabelled (reference_diffs.json uses the strict view).

; ===== x86_64 =====

00000001000126a8 <-[CXServer applicationWillFinishLaunching:]>:
1000126a8: 55                          	pushq	%rbp
1000126a9: 48 89 e5                    	movq	%rsp, %rbp
1000126ac: 41 57                       	pushq	%r15
1000126ae: 41 56                       	pushq	%r14
1000126b0: 41 55                       	pushq	%r13
1000126b2: 41 54                       	pushq	%r12
1000126b4: 53                          	pushq	%rbx
1000126b5: 50                          	pushq	%rax
1000126b6: 49 89 fe                    	movq	%rdi, %r14
1000126b9: e8 62 8c 05 00              	callq	0x10006b320 <_PFMoveToApplicationsFolderIfNecessary>    ; call "_PFMoveToApplicationsFolderIfNecessary"
1000126be: 48 8b 3d 0b 90 0b 00        	movq	0xb900b(%rip), %rdi     ## 0x1000cb6d0    ; class "NSAppleEventManager"
1000126c5: 48 8b 35 9c 5b 0b 00        	movq	0xb5b9c(%rip), %rsi     ## 0x1000c8268    ; sel "sharedAppleEventManager"
1000126cc: 4c 8b 25 3d ac 08 00        	movq	0x8ac3d(%rip), %r12     ## 0x10009d310    ; import "_objc_msgSend"
1000126d3: 41 ff d4                    	callq	*%r12
1000126d6: 48 89 c7                    	movq	%rax, %rdi
1000126d9: e8 0a 71 06 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000126de: 48 89 c3                    	movq	%rax, %rbx
1000126e1: 48 8b 0d 88 5b 0b 00        	movq	0xb5b88(%rip), %rcx     ## 0x1000c8270    ; sel "handleGetURLEvent:withReplyEvent:"
1000126e8: 48 8b 35 89 5b 0b 00        	movq	0xb5b89(%rip), %rsi     ## 0x1000c8278    ; sel "setEventHandler:andSelector:forEventClass:andEventID:"
1000126ef: 48 89 c7                    	movq	%rax, %rdi
1000126f2: 4c 89 f2                    	movq	%r14, %rdx
1000126f5: 41 b8 4c 52 55 47           	movl	$0x4755524c, %r8d       ## imm = 0x4755524C
1000126fb: 41 b9 4c 52 55 47           	movl	$0x4755524c, %r9d       ## imm = 0x4755524C
100012701: 41 ff d4                    	callq	*%r12
100012704: 48 8b 3d cd 8f 0b 00        	movq	0xb8fcd(%rip), %rdi     ## 0x1000cb6d8    ; class "CXApplication"
10001270b: 4c 8b 35 6e 5b 0b 00        	movq	0xb5b6e(%rip), %r14     ## 0x1000c8280    ; sel "sharedApplication"
100012712: 4c 89 f6                    	movq	%r14, %rsi
100012715: 41 ff d4                    	callq	*%r12
100012718: 48 89 c7                    	movq	%rax, %rdi
10001271b: e8 c8 70 06 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100012720: 49 89 c7                    	movq	%rax, %r15
100012723: 48 8b 35 5e 5b 0b 00        	movq	0xb5b5e(%rip), %rsi     ## 0x1000c8288    ; sel "setDaysLeft"
10001272a: 48 89 c7                    	movq	%rax, %rdi
10001272d: 41 ff d4                    	callq	*%r12
100012730: 4c 8b 2d e1 ab 08 00        	movq	0x8abe1(%rip), %r13     ## 0x10009d318    ; import "_objc_release"
100012737: 4c 89 ff                    	movq	%r15, %rdi
10001273a: 41 ff d5                    	callq	*%r13
10001273d: 48 8b 3d 94 8f 0b 00        	movq	0xb8f94(%rip), %rdi     ## 0x1000cb6d8    ; class "CXApplication"
100012744: 4c 89 f6                    	movq	%r14, %rsi
100012747: 41 ff d4                    	callq	*%r12
10001274a: 48 89 c7                    	movq	%rax, %rdi
10001274d: e8 96 70 06 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100012752: 49 89 c6                    	movq	%rax, %r14
100012755: 48 8b 35 34 5b 0b 00        	movq	0xb5b34(%rip), %rsi     ## 0x1000c8290    ; sel "setIsDemo"
10001275c: 48 89 c7                    	movq	%rax, %rdi
10001275f: 41 ff d4                    	callq	*%r12
100012762: 4c 89 f7                    	movq	%r14, %rdi
100012765: 41 ff d5                    	callq	*%r13
100012768: 48 89 df                    	movq	%rbx, %rdi
10001276b: 4c 89 e8                    	movq	%r13, %rax
10001276e: 48 83 c4 08                 	addq	$0x8, %rsp
100012772: 5b                          	popq	%rbx
100012773: 41 5c                       	popq	%r12
100012775: 41 5d                       	popq	%r13
100012777: 41 5e                       	popq	%r14
100012779: 41 5f                       	popq	%r15
10001277b: 5d                          	popq	%rbp
10001277c: ff e0                       	jmpq	*%rax


000000010001b719 <-[RunCommandController supportsAVX]>:
10001b719: 55                          	pushq	%rbp
10001b71a: 48 89 e5                    	movq	%rsp, %rbp
10001b71d: 31 c0                       	xorl	%eax, %eax
10001b71f: 5d                          	popq	%rbp
10001b720: c3                          	retq


0000000100065e08 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke>:
100065e08: 55                          	pushq	%rbp
100065e09: 48 89 e5                    	movq	%rsp, %rbp
100065e0c: 41 57                       	pushq	%r15
100065e0e: 41 56                       	pushq	%r14
100065e10: 41 55                       	pushq	%r13
100065e12: 41 54                       	pushq	%r12
100065e14: 53                          	pushq	%rbx
100065e15: 48 81 ec 38 01 00 00        	subq	$0x138, %rsp            ## imm = 0x138
100065e1c: 48 8b 05 6d 74 03 00        	movq	0x3746d(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
100065e23: 48 8b 00                    	movq	(%rax), %rax
100065e26: 48 89 45 d0                 	movq	%rax, -0x30(%rbp)
100065e2a: 48 8d 05 37 a6 03 00        	leaq	0x3a637(%rip), %rax     ## 0x1000a0468    ; cfstr "bottleName"
100065e31: 48 8d 8d 60 ff ff ff        	leaq	-0xa0(%rbp), %rcx
100065e38: 48 89 01                    	movq	%rax, (%rcx)
100065e3b: 48 8d 05 e6 b9 03 00        	leaq	0x3b9e6(%rip), %rax     ## 0x1000a1828    ; cfstr "bottlename"
100065e42: 48 8d 55 98                 	leaq	-0x68(%rbp), %rdx
100065e46: 48 89 02                    	movq	%rax, (%rdx)
100065e49: 48 8d 05 78 ef 03 00        	leaq	0x3ef78(%rip), %rax     ## 0x1000a4dc8    ; cfstr "dependencyOverrides"
100065e50: 48 89 41 08                 	movq	%rax, 0x8(%rcx)
100065e54: 48 8d 05 8d ef 03 00        	leaq	0x3ef8d(%rip), %rax     ## 0x1000a4de8    ; cfstr "dependency_overrides"
100065e5b: 48 89 42 08                 	movq	%rax, 0x8(%rdx)
100065e5f: 48 8d 05 a2 ef 03 00        	leaq	0x3efa2(%rip), %rax     ## 0x1000a4e08    ; cfstr "downloadURL"
100065e66: 48 89 41 10                 	movq	%rax, 0x10(%rcx)
100065e6a: 48 8d 05 b7 ef 03 00        	leaq	0x3efb7(%rip), %rax     ## 0x1000a4e28    ; cfstr "download_url"
100065e71: 48 89 42 10                 	movq	%rax, 0x10(%rdx)
100065e75: 48 8d 05 ec b8 03 00        	leaq	0x3b8ec(%rip), %rax     ## 0x1000a1768    ; cfstr "nameForNewBottle"
100065e7c: 48 89 41 18                 	movq	%rax, 0x18(%rcx)
100065e80: 48 8d 05 c1 ef 03 00        	leaq	0x3efc1(%rip), %rax     ## 0x1000a4e48    ; cfstr "newBottleName"
100065e87: 48 89 42 18                 	movq	%rax, 0x18(%rdx)
100065e8b: 48 8d 05 d6 ef 03 00        	leaq	0x3efd6(%rip), %rax     ## 0x1000a4e68    ; cfstr "postInstallURL"
100065e92: 48 89 41 20                 	movq	%rax, 0x20(%rcx)
100065e96: 48 8d 05 eb ef 03 00        	leaq	0x3efeb(%rip), %rax     ## 0x1000a4e88    ; cfstr "post_install_url"
100065e9d: 48 89 42 20                 	movq	%rax, 0x20(%rdx)
100065ea1: 48 8d 05 00 f0 03 00        	leaq	0x3f000(%rip), %rax     ## 0x1000a4ea8    ; cfstr "steamID"
100065ea8: 48 89 41 28                 	movq	%rax, 0x28(%rcx)
100065eac: 48 8d 05 15 f0 03 00        	leaq	0x3f015(%rip), %rax     ## 0x1000a4ec8    ; cfstr "steamid"
100065eb3: 48 89 42 28                 	movq	%rax, 0x28(%rdx)
100065eb7: 48 8d 05 8a b8 03 00        	leaq	0x3b88a(%rip), %rax     ## 0x1000a1748    ; cfstr "targetBottle"
100065ebe: 48 89 41 30                 	movq	%rax, 0x30(%rcx)
100065ec2: 48 8d 05 1f f0 03 00        	leaq	0x3f01f(%rip), %rax     ## 0x1000a4ee8    ; cfstr "target_bottle"
100065ec9: 48 89 42 30                 	movq	%rax, 0x30(%rdx)
100065ecd: 48 8b 3d a4 57 06 00        	movq	0x657a4(%rip), %rdi     ## 0x1000cb678    ; class "NSDictionary"
100065ed4: 48 8b 35 e5 2a 06 00        	movq	0x62ae5(%rip), %rsi     ## 0x1000c89c0    ; sel "dictionaryWithObjects:forKeys:count:"
100065edb: 41 b8 07 00 00 00           	movl	$0x7, %r8d
100065ee1: ff 15 29 74 03 00           	callq	*0x37429(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
100065ee7: 48 89 c7                    	movq	%rax, %rdi
100065eea: e8 f9 38 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100065eef: 48 89 85 18 ff ff ff        	movq	%rax, -0xe8(%rbp)
100065ef6: 48 8b 3d 9b 57 06 00        	movq	0x6579b(%rip), %rdi     ## 0x1000cb698    ; class "NSMutableDictionary"
100065efd: e8 56 38 01 00              	callq	0x100079758    ; import "_objc_alloc_init"
100065f02: 48 89 85 48 ff ff ff        	movq	%rax, -0xb8(%rbp)
100065f09: 48 8b 3d 30 56 06 00        	movq	0x65630(%rip), %rdi     ## 0x1000cb540    ; class "InstallConfiguration"
100065f10: e8 af 38 01 00              	callq	0x1000797c4    ; import "_objc_opt_class"
100065f15: 48 8d 9d 34 ff ff ff        	leaq	-0xcc(%rbp), %rbx
100065f1c: 48 89 c7                    	movq	%rax, %rdi
100065f1f: 48 89 de                    	movq	%rbx, %rsi
100065f22: e8 83 37 01 00              	callq	0x1000796aa    ; import "_class_copyPropertyList"
100065f27: 49 89 c7                    	movq	%rax, %r15
100065f2a: 83 3b 00                    	cmpl	$0x0, (%rbx)
100065f2d: 0f 84 b6 04 00 00           	je	0x1000663e9 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x5e1>
100065f33: 48 8b 05 be 3a 06 00        	movq	0x63abe(%rip), %rax     ## 0x1000c99f8    ; sel "stringWithUTF8String:"
100065f3a: 48 89 85 40 ff ff ff        	movq	%rax, -0xc0(%rbp)
100065f41: 48 8b 05 58 13 06 00        	movq	0x61358(%rip), %rax     ## 0x1000c72a0    ; sel "objectForKey:"
100065f48: 48 89 85 a8 fe ff ff        	movq	%rax, -0x158(%rbp)
100065f4f: 48 8b 05 1a 4d 06 00        	movq	0x64d1a(%rip), %rax     ## 0x1000cac70    ; sel "setInstallTaskAttribute:"
100065f56: 48 89 85 08 ff ff ff        	movq	%rax, -0xf8(%rbp)
100065f5d: 48 8b 05 14 4d 06 00        	movq	0x64d14(%rip), %rax     ## 0x1000cac78    ; sel "installTaskAttribute"
100065f64: 48 89 85 b0 fe ff ff        	movq	%rax, -0x150(%rbp)
100065f6b: 48 8b 05 0e 4d 06 00        	movq	0x64d0e(%rip), %rax     ## 0x1000cac80    ; sel "setBoolTyped:"
100065f72: 48 89 85 b8 fe ff ff        	movq	%rax, -0x148(%rbp)
100065f79: 48 8b 05 08 4d 06 00        	movq	0x64d08(%rip), %rax     ## 0x1000cac88    ; sel "setGetter:"
100065f80: 48 89 85 20 ff ff ff        	movq	%rax, -0xe0(%rbp)
100065f87: 48 8b 05 02 4d 06 00        	movq	0x64d02(%rip), %rax     ## 0x1000cac90    ; sel "getter"
100065f8e: 48 89 85 c0 fe ff ff        	movq	%rax, -0x140(%rbp)
100065f95: 48 8b 05 5c 21 06 00        	movq	0x6215c(%rip), %rax     ## 0x1000c80f8    ; sel "setObject:forKey:"
100065f9c: 48 89 85 10 ff ff ff        	movq	%rax, -0xf0(%rbp)
100065fa3: 48 8b 05 ee 4c 06 00        	movq	0x64cee(%rip), %rax     ## 0x1000cac98    ; sel "setSetter:"
100065faa: 48 89 85 28 ff ff ff        	movq	%rax, -0xd8(%rbp)
100065fb1: 48 8b 05 08 3c 06 00        	movq	0x63c08(%rip), %rax     ## 0x1000c9bc0    ; sel "substringToIndex:"
100065fb8: 48 89 85 e0 fe ff ff        	movq	%rax, -0x120(%rbp)
100065fbf: 48 8b 05 da 4c 06 00        	movq	0x64cda(%rip), %rax     ## 0x1000caca0    ; sel "uppercaseString"
100065fc6: 48 89 85 e8 fe ff ff        	movq	%rax, -0x118(%rbp)
100065fcd: 48 8b 05 74 25 06 00        	movq	0x62574(%rip), %rax     ## 0x1000c8548    ; sel "substringFromIndex:"
100065fd4: 48 89 85 f0 fe ff ff        	movq	%rax, -0x110(%rbp)
100065fdb: 48 8b 05 46 1a 06 00        	movq	0x61a46(%rip), %rax     ## 0x1000c7a28    ; sel "stringWithFormat:"
100065fe2: 48 89 85 f8 fe ff ff        	movq	%rax, -0x108(%rbp)
100065fe9: 48 8b 05 b8 4c 06 00        	movq	0x64cb8(%rip), %rax     ## 0x1000caca8    ; sel "setter"
100065ff0: 48 89 85 c8 fe ff ff        	movq	%rax, -0x138(%rbp)
100065ff7: 4c 8b 25 12 73 03 00        	movq	0x37312(%rip), %r12     ## 0x10009d310    ; import "_objc_msgSend"
100065ffe: 48 8b 1d 13 73 03 00        	movq	0x37313(%rip), %rbx     ## 0x10009d318    ; import "_objc_release"
100066005: 45 31 f6                    	xorl	%r14d, %r14d
100066008: 4c 89 bd 38 ff ff ff        	movq	%r15, -0xc8(%rbp)
10006600f: e8 56 37 01 00              	callq	0x10007976a    ; import "_objc_autoreleasePoolPush"
100066014: 49 89 c5                    	movq	%rax, %r13
100066017: 4b 8b 3c f7                 	movq	(%r15,%r14,8), %rdi
10006601b: 48 8d 35 ef 01 03 00        	leaq	0x301ef(%rip), %rsi     ## 0x100096211    ; str "D"
100066022: e8 09 38 01 00              	callq	0x100079830    ; import "_property_copyAttributeValue"
100066027: 48 85 c0                    	testq	%rax, %rax
10006602a: 0f 84 9f 03 00 00           	je	0x1000663cf <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x5c7>
100066030: 4c 89 ad 00 ff ff ff        	movq	%r13, -0x100(%rbp)
100066037: 48 89 c7                    	movq	%rax, %rdi
10006603a: e8 e9 36 01 00              	callq	0x100079728    ; import "_free"
10006603f: 49 89 dd                    	movq	%rbx, %r13
100066042: 48 8b 1d 77 55 06 00        	movq	0x65577(%rip), %rbx     ## 0x1000cb5c0    ; class "NSString"
100066049: 4b 8b 3c f7                 	movq	(%r15,%r14,8), %rdi
10006604d: e8 e4 37 01 00              	callq	0x100079836    ; import "_property_getName"
100066052: 48 89 df                    	movq	%rbx, %rdi
100066055: 48 8b b5 40 ff ff ff        	movq	-0xc0(%rbp), %rsi
10006605c: 48 89 c2                    	movq	%rax, %rdx
10006605f: 41 ff d4                    	callq	*%r12
100066062: 48 89 c7                    	movq	%rax, %rdi
100066065: e8 7e 37 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
10006606a: 48 89 c3                    	movq	%rax, %rbx
10006606d: 48 8b 3d fc 58 06 00        	movq	0x658fc(%rip), %rdi     ## 0x1000cb970    ; class "PropertyDescriptor"
100066074: e8 df 36 01 00              	callq	0x100079758    ; import "_objc_alloc_init"
100066079: 4d 89 f7                    	movq	%r14, %r15
10006607c: 49 89 c6                    	movq	%rax, %r14
10006607f: 48 8b bd 18 ff ff ff        	movq	-0xe8(%rbp), %rdi
100066086: 48 8b b5 a8 fe ff ff        	movq	-0x158(%rbp), %rsi
10006608d: 48 89 9d 50 ff ff ff        	movq	%rbx, -0xb0(%rbp)
100066094: 48 89 da                    	movq	%rbx, %rdx
100066097: 41 ff d4                    	callq	*%r12
10006609a: 48 89 c7                    	movq	%rax, %rdi
10006609d: e8 46 37 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000660a2: 48 89 c3                    	movq	%rax, %rbx
1000660a5: 4c 89 f7                    	movq	%r14, %rdi
1000660a8: 48 8b b5 08 ff ff ff        	movq	-0xf8(%rbp), %rsi
1000660af: 48 89 c2                    	movq	%rax, %rdx
1000660b2: 41 ff d4                    	callq	*%r12
1000660b5: 48 89 df                    	movq	%rbx, %rdi
1000660b8: 41 ff d5                    	callq	*%r13
1000660bb: 4c 89 f7                    	movq	%r14, %rdi
1000660be: 48 8b b5 b0 fe ff ff        	movq	-0x150(%rbp), %rsi
1000660c5: 41 ff d4                    	callq	*%r12
1000660c8: 48 89 c7                    	movq	%rax, %rdi
1000660cb: e8 18 37 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000660d0: 48 89 c3                    	movq	%rax, %rbx
1000660d3: 48 89 c7                    	movq	%rax, %rdi
1000660d6: 41 ff d5                    	callq	*%r13
1000660d9: 4d 89 f5                    	movq	%r14, %r13
1000660dc: 48 85 db                    	testq	%rbx, %rbx
1000660df: 75 14                       	jne	0x1000660f5 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x2ed>
1000660e1: 4c 89 ef                    	movq	%r13, %rdi
1000660e4: 48 8b b5 08 ff ff ff        	movq	-0xf8(%rbp), %rsi
1000660eb: 48 8b 95 50 ff ff ff        	movq	-0xb0(%rbp), %rdx
1000660f2: 41 ff d4                    	callq	*%r12
1000660f5: 4c 8b b5 38 ff ff ff        	movq	-0xc8(%rbp), %r14
1000660fc: 4b 8b 3c fe                 	movq	(%r14,%r15,8), %rdi
100066100: 48 8d 35 0c 01 03 00        	leaq	0x3010c(%rip), %rsi     ## 0x100096213    ; str "T"
100066107: e8 24 37 01 00              	callq	0x100079830    ; import "_property_copyAttributeValue"
10006610c: 48 89 c3                    	movq	%rax, %rbx
10006610f: 48 89 c7                    	movq	%rax, %rdi
100066112: 48 8d 35 fc 00 03 00        	leaq	0x300fc(%rip), %rsi     ## 0x100096215    ; str "c"
100066119: e8 4e 37 01 00              	callq	0x10007986c    ; import "_strcmp"
10006611e: 31 d2                       	xorl	%edx, %edx
100066120: 85 c0                       	testl	%eax, %eax
100066122: 0f 94 c2                    	sete	%dl
100066125: 4c 89 ef                    	movq	%r13, %rdi
100066128: 48 8b b5 b8 fe ff ff        	movq	-0x148(%rbp), %rsi
10006612f: 41 ff d4                    	callq	*%r12
100066132: 48 89 df                    	movq	%rbx, %rdi
100066135: e8 ee 35 01 00              	callq	0x100079728    ; import "_free"
10006613a: 4c 89 bd a0 fe ff ff        	movq	%r15, -0x160(%rbp)
100066141: 4b 8b 3c fe                 	movq	(%r14,%r15,8), %rdi
100066145: 48 8d 35 cb 00 03 00        	leaq	0x300cb(%rip), %rsi     ## 0x100096217    ; str "G"
10006614c: e8 df 36 01 00              	callq	0x100079830    ; import "_property_copyAttributeValue"
100066151: 4d 89 e7                    	movq	%r12, %r15
100066154: 48 85 c0                    	testq	%rax, %rax
100066157: 74 4f                       	je	0x1000661a8 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x3a0>
100066159: 49 89 c4                    	movq	%rax, %r12
10006615c: 48 8b 3d 5d 54 06 00        	movq	0x6545d(%rip), %rdi     ## 0x1000cb5c0    ; class "NSString"
100066163: 48 8b b5 40 ff ff ff        	movq	-0xc0(%rbp), %rsi
10006616a: 48 89 c2                    	movq	%rax, %rdx
10006616d: 41 ff d7                    	callq	*%r15
100066170: 48 89 c7                    	movq	%rax, %rdi
100066173: e8 70 36 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100066178: 48 89 c3                    	movq	%rax, %rbx
10006617b: 4c 89 ef                    	movq	%r13, %rdi
10006617e: 48 8b b5 20 ff ff ff        	movq	-0xe0(%rbp), %rsi
100066185: 48 89 c2                    	movq	%rax, %rdx
100066188: 41 ff d7                    	callq	*%r15
10006618b: 48 89 df                    	movq	%rbx, %rdi
10006618e: 4d 89 ee                    	movq	%r13, %r14
100066191: 4c 8b 2d 80 71 03 00        	movq	0x37180(%rip), %r13     ## 0x10009d318    ; import "_objc_release"
100066198: 41 ff d5                    	callq	*%r13
10006619b: 4c 89 e7                    	movq	%r12, %rdi
10006619e: e8 85 35 01 00              	callq	0x100079728    ; import "_free"
1000661a3: 4d 89 fc                    	movq	%r15, %r12
1000661a6: eb 21                       	jmp	0x1000661c9 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x3c1>
1000661a8: 4c 89 ef                    	movq	%r13, %rdi
1000661ab: 48 8b b5 20 ff ff ff        	movq	-0xe0(%rbp), %rsi
1000661b2: 48 8b 95 50 ff ff ff        	movq	-0xb0(%rbp), %rdx
1000661b9: 41 ff d7                    	callq	*%r15
1000661bc: 4d 89 fc                    	movq	%r15, %r12
1000661bf: 4d 89 ee                    	movq	%r13, %r14
1000661c2: 4c 8b 2d 4f 71 03 00        	movq	0x3714f(%rip), %r13     ## 0x10009d318    ; import "_objc_release"
1000661c9: 4c 89 f7                    	movq	%r14, %rdi
1000661cc: 48 8b b5 c0 fe ff ff        	movq	-0x140(%rbp), %rsi
1000661d3: 41 ff d4                    	callq	*%r12
1000661d6: 48 89 c7                    	movq	%rax, %rdi
1000661d9: e8 0a 36 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000661de: 48 89 c3                    	movq	%rax, %rbx
1000661e1: 48 8b bd 48 ff ff ff        	movq	-0xb8(%rbp), %rdi
1000661e8: 48 8b b5 10 ff ff ff        	movq	-0xf0(%rbp), %rsi
1000661ef: 4c 89 b5 58 ff ff ff        	movq	%r14, -0xa8(%rbp)
1000661f6: 4c 89 f2                    	movq	%r14, %rdx
1000661f9: 48 89 c1                    	movq	%rax, %rcx
1000661fc: 41 ff d4                    	callq	*%r12
1000661ff: 48 89 df                    	movq	%rbx, %rdi
100066202: 41 ff d5                    	callq	*%r13
100066205: 4c 8b bd 38 ff ff ff        	movq	-0xc8(%rbp), %r15
10006620c: 4c 8b b5 a0 fe ff ff        	movq	-0x160(%rbp), %r14
100066213: 4b 8b 3c f7                 	movq	(%r15,%r14,8), %rdi
100066217: 48 8d 35 fb ff 02 00        	leaq	0x2fffb(%rip), %rsi     ## 0x100096219    ; str "R"
10006621e: e8 0d 36 01 00              	callq	0x100079830    ; import "_property_copyAttributeValue"
100066223: 48 85 c0                    	testq	%rax, %rax
100066226: 74 1e                       	je	0x100066246 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x43e>
100066228: 4c 89 eb                    	movq	%r13, %rbx
10006622b: 48 89 c7                    	movq	%rax, %rdi
10006622e: e8 f5 34 01 00              	callq	0x100079728    ; import "_free"
100066233: 4c 8b ad 00 ff ff ff        	movq	-0x100(%rbp), %r13
10006623a: 48 8b bd 58 ff ff ff        	movq	-0xa8(%rbp), %rdi
100066241: e9 7e 01 00 00              	jmp	0x1000663c4 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x5bc>
100066246: 4b 8b 3c f7                 	movq	(%r15,%r14,8), %rdi
10006624a: 48 8d 35 ca ff 02 00        	leaq	0x2ffca(%rip), %rsi     ## 0x10009621b    ; str "S"
100066251: e8 da 35 01 00              	callq	0x100079830    ; import "_property_copyAttributeValue"
100066256: 4c 8b 2d 63 53 06 00        	movq	0x65363(%rip), %r13     ## 0x1000cb5c0    ; class "NSString"
10006625d: 48 85 c0                    	testq	%rax, %rax
100066260: 74 4c                       	je	0x1000662ae <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x4a6>
100066262: 48 89 c3                    	movq	%rax, %rbx
100066265: 4c 89 ef                    	movq	%r13, %rdi
100066268: 48 8b b5 40 ff ff ff        	movq	-0xc0(%rbp), %rsi
10006626f: 48 89 c2                    	movq	%rax, %rdx
100066272: 41 ff d4                    	callq	*%r12
100066275: 48 89 c7                    	movq	%rax, %rdi
100066278: e8 6b 35 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
10006627d: 49 89 c7                    	movq	%rax, %r15
100066280: 48 8b bd 58 ff ff ff        	movq	-0xa8(%rbp), %rdi
100066287: 48 8b b5 28 ff ff ff        	movq	-0xd8(%rbp), %rsi
10006628e: 48 89 c2                    	movq	%rax, %rdx
100066291: 41 ff d4                    	callq	*%r12
100066294: 4c 89 ff                    	movq	%r15, %rdi
100066297: 4c 8b 2d 7a 70 03 00        	movq	0x3707a(%rip), %r13     ## 0x10009d318    ; import "_objc_release"
10006629e: 41 ff d5                    	callq	*%r13
1000662a1: 48 89 df                    	movq	%rbx, %rdi
1000662a4: e8 7f 34 01 00              	callq	0x100079728    ; import "_free"
1000662a9: e9 c6 00 00 00              	jmp	0x100066374 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x56c>
1000662ae: ba 01 00 00 00              	movl	$0x1, %edx
1000662b3: 48 8b 9d 50 ff ff ff        	movq	-0xb0(%rbp), %rbx
1000662ba: 48 89 df                    	movq	%rbx, %rdi
1000662bd: 48 8b b5 e0 fe ff ff        	movq	-0x120(%rbp), %rsi
1000662c4: 41 ff d4                    	callq	*%r12
1000662c7: 48 89 c7                    	movq	%rax, %rdi
1000662ca: e8 19 35 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000662cf: 48 89 85 d0 fe ff ff        	movq	%rax, -0x130(%rbp)
1000662d6: 48 89 c7                    	movq	%rax, %rdi
1000662d9: 48 8b b5 e8 fe ff ff        	movq	-0x118(%rbp), %rsi
1000662e0: 41 ff d4                    	callq	*%r12
1000662e3: 48 89 c7                    	movq	%rax, %rdi
1000662e6: e8 fd 34 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
1000662eb: 49 89 c7                    	movq	%rax, %r15
1000662ee: 48 89 85 d8 fe ff ff        	movq	%rax, -0x128(%rbp)
1000662f5: ba 01 00 00 00              	movl	$0x1, %edx
1000662fa: 48 89 df                    	movq	%rbx, %rdi
1000662fd: 48 8b b5 f0 fe ff ff        	movq	-0x110(%rbp), %rsi
100066304: 41 ff d4                    	callq	*%r12
100066307: 48 89 c7                    	movq	%rax, %rdi
10006630a: e8 d9 34 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
10006630f: 48 89 c3                    	movq	%rax, %rbx
100066312: 4c 89 ef                    	movq	%r13, %rdi
100066315: 48 8b b5 f8 fe ff ff        	movq	-0x108(%rbp), %rsi
10006631c: 48 8d 15 e5 eb 03 00        	leaq	0x3ebe5(%rip), %rdx     ## 0x1000a4f08    ; cfstr "set%@%@:"
100066323: 4c 89 f9                    	movq	%r15, %rcx
100066326: 49 89 c0                    	movq	%rax, %r8
100066329: 31 c0                       	xorl	%eax, %eax
10006632b: 41 ff d4                    	callq	*%r12
10006632e: 48 89 c7                    	movq	%rax, %rdi
100066331: e8 b2 34 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100066336: 49 89 c7                    	movq	%rax, %r15
100066339: 48 8b bd 58 ff ff ff        	movq	-0xa8(%rbp), %rdi
100066340: 48 8b b5 28 ff ff ff        	movq	-0xd8(%rbp), %rsi
100066347: 48 89 c2                    	movq	%rax, %rdx
10006634a: 41 ff d4                    	callq	*%r12
10006634d: 4c 89 ff                    	movq	%r15, %rdi
100066350: 4c 8b 2d c1 6f 03 00        	movq	0x36fc1(%rip), %r13     ## 0x10009d318    ; import "_objc_release"
100066357: 41 ff d5                    	callq	*%r13
10006635a: 48 89 df                    	movq	%rbx, %rdi
10006635d: 41 ff d5                    	callq	*%r13
100066360: 48 8b bd d8 fe ff ff        	movq	-0x128(%rbp), %rdi
100066367: 41 ff d5                    	callq	*%r13
10006636a: 48 8b bd d0 fe ff ff        	movq	-0x130(%rbp), %rdi
100066371: 41 ff d5                    	callq	*%r13
100066374: 4c 8b bd 58 ff ff ff        	movq	-0xa8(%rbp), %r15
10006637b: 4c 89 ff                    	movq	%r15, %rdi
10006637e: 48 8b b5 c8 fe ff ff        	movq	-0x138(%rbp), %rsi
100066385: 41 ff d4                    	callq	*%r12
100066388: 48 89 c7                    	movq	%rax, %rdi
10006638b: e8 58 34 01 00              	callq	0x1000797e8    ; import "_objc_retainAutoreleasedReturnValue"
100066390: 48 89 c3                    	movq	%rax, %rbx
100066393: 48 8b bd 48 ff ff ff        	movq	-0xb8(%rbp), %rdi
10006639a: 48 8b b5 10 ff ff ff        	movq	-0xf0(%rbp), %rsi
1000663a1: 4c 89 fa                    	movq	%r15, %rdx
1000663a4: 48 89 c1                    	movq	%rax, %rcx
1000663a7: 41 ff d4                    	callq	*%r12
1000663aa: 48 89 df                    	movq	%rbx, %rdi
1000663ad: 41 ff d5                    	callq	*%r13
1000663b0: 4c 89 ff                    	movq	%r15, %rdi
1000663b3: 4c 8b bd 38 ff ff ff        	movq	-0xc8(%rbp), %r15
1000663ba: 4c 89 eb                    	movq	%r13, %rbx
1000663bd: 4c 8b ad 00 ff ff ff        	movq	-0x100(%rbp), %r13
1000663c4: ff d3                       	callq	*%rbx
1000663c6: 48 8b bd 50 ff ff ff        	movq	-0xb0(%rbp), %rdi
1000663cd: ff d3                       	callq	*%rbx
1000663cf: 4c 89 ef                    	movq	%r13, %rdi
1000663d2: e8 8d 33 01 00              	callq	0x100079764    ; import "_objc_autoreleasePoolPop"
1000663d7: 49 ff c6                    	incq	%r14
1000663da: 8b 85 34 ff ff ff           	movl	-0xcc(%rbp), %eax
1000663e0: 49 39 c6                    	cmpq	%rax, %r14
1000663e3: 0f 82 26 fc ff ff           	jb	0x10006600f <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x207>
1000663e9: 4c 89 ff                    	movq	%r15, %rdi
1000663ec: e8 37 33 01 00              	callq	0x100079728    ; import "_free"
1000663f1: 48 8b 3d 08 93 06 00        	movq	0x69308(%rip), %rdi     ## 0x1000cf700 <_selectorToProperty>    ; data "_selectorToProperty"
1000663f8: 48 8b 85 48 ff ff ff        	movq	-0xb8(%rbp), %rax
1000663ff: 48 89 05 fa 92 06 00        	movq	%rax, 0x692fa(%rip)     ## 0x1000cf700 <_selectorToProperty>    ; data "_selectorToProperty"
100066406: 48 8b 1d 0b 6f 03 00        	movq	0x36f0b(%rip), %rbx     ## 0x10009d318    ; import "_objc_release"
10006640d: ff d3                       	callq	*%rbx
10006640f: 48 8b bd 18 ff ff ff        	movq	-0xe8(%rbp), %rdi
100066416: ff d3                       	callq	*%rbx
100066418: 48 8b 05 71 6e 03 00        	movq	0x36e71(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
10006641f: 48 8b 00                    	movq	(%rax), %rax
100066422: 48 3b 45 d0                 	cmpq	-0x30(%rbp), %rax
100066426: 75 12                       	jne	0x10006643a <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x632>
100066428: 48 81 c4 38 01 00 00        	addq	$0x138, %rsp            ## imm = 0x138
10006642f: 5b                          	popq	%rbx
100066430: 41 5c                       	popq	%r12
100066432: 41 5d                       	popq	%r13
100066434: 41 5e                       	popq	%r14
100066436: 41 5f                       	popq	%r15
100066438: 5d                          	popq	%rbp
100066439: c3                          	retq
10006643a: e8 47 32 01 00              	callq	0x100079686    ; import "___stack_chk_fail"


000000010006b083 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]>:
10006b083: 55                          	pushq	%rbp
10006b084: 48 89 e5                    	movq	%rsp, %rbp
10006b087: 41 57                       	pushq	%r15
10006b089: 41 56                       	pushq	%r14
10006b08b: 41 55                       	pushq	%r13
10006b08d: 41 54                       	pushq	%r12
10006b08f: 53                          	pushq	%rbx
10006b090: 48 81 ec 98 00 00 00        	subq	$0x98, %rsp
10006b097: 49 89 ff                    	movq	%rdi, %r15
10006b09a: 48 8b 3d 37 05 06 00        	movq	0x60537(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006b0a1: 48 8b 35 00 cb 05 00        	movq	0x5cb00(%rip), %rsi     ## 0x1000c7ba8    ; sel "defaultManager"
10006b0a8: 4c 8b 2d 61 22 03 00        	movq	0x32261(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b0af: 41 ff d5                    	callq	*%r13
10006b0b2: 48 8b 35 9f fe 05 00        	movq	0x5fe9f(%rip), %rsi     ## 0x1000caf58    ; sel "fileSystemRepresentationWithPath:"
10006b0b9: 48 89 c7                    	movq	%rax, %rdi
10006b0bc: 4c 89 fa                    	movq	%r15, %rdx
10006b0bf: 41 ff d5                    	callq	*%r13
10006b0c2: 48 8d b5 40 ff ff ff        	leaq	-0xc0(%rbp), %rsi
10006b0c9: 48 89 c7                    	movq	%rax, %rdi
10006b0cc: e8 75 e6 00 00              	callq	0x100079746    ; import "_lstat$INODE64"
10006b0d1: 85 c0                       	testl	%eax, %eax
10006b0d3: 0f 88 ab 00 00 00           	js	0x10006b184 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x101>
10006b0d9: 4c 8b 25 80 fe 05 00        	movq	0x5fe80(%rip), %r12     ## 0x1000caf60    ; sel "stringByConditionallyResolvingAlias"
10006b0e0: 48 8b 05 81 fe 05 00        	movq	0x5fe81(%rip), %rax     ## 0x1000caf68    ; sel "stringByConditionallyResolvingSymlink"
10006b0e7: 48 89 45 d0                 	movq	%rax, -0x30(%rbp)
10006b0eb: 31 db                       	xorl	%ebx, %ebx
10006b0ed: 0f b7 85 44 ff ff ff        	movzwl	-0xbc(%rbp), %eax
10006b0f4: 89 c1                       	movl	%eax, %ecx
10006b0f6: 81 e1 00 f0 00 00           	andl	$0xf000, %ecx           ## imm = 0xF000
10006b0fc: 81 f9 00 a0 00 00           	cmpl	$0xa000, %ecx           ## imm = 0xA000
10006b102: 74 20                       	je	0x10006b124 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xa1>
10006b104: 81 f9 00 40 00 00           	cmpl	$0x4000, %ecx           ## imm = 0x4000
10006b10a: 74 7b                       	je	0x10006b187 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x104>
10006b10c: 4c 89 ff                    	movq	%r15, %rdi
10006b10f: 4c 89 e6                    	movq	%r12, %rsi
10006b112: 41 ff d5                    	callq	*%r13
10006b115: 48 85 c0                    	testq	%rax, %rax
10006b118: 74 6d                       	je	0x10006b187 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x104>
10006b11a: 48 89 c3                    	movq	%rax, %rbx
10006b11d: 0f b7 85 44 ff ff ff        	movzwl	-0xbc(%rbp), %eax
10006b124: 25 00 f0 00 00              	andl	$0xf000, %eax           ## imm = 0xF000
10006b129: 49 89 de                    	movq	%rbx, %r14
10006b12c: 3d 00 a0 00 00              	cmpl	$0xa000, %eax           ## imm = 0xA000
10006b131: 75 12                       	jne	0x10006b145 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xc2>
10006b133: 4c 89 ff                    	movq	%r15, %rdi
10006b136: 48 8b 75 d0                 	movq	-0x30(%rbp), %rsi
10006b13a: 41 ff d5                    	callq	*%r13
10006b13d: 49 89 c6                    	movq	%rax, %r14
10006b140: 48 85 c0                    	testq	%rax, %rax
10006b143: 74 3f                       	je	0x10006b184 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x101>
10006b145: 48 8b 3d 8c 04 06 00        	movq	0x6048c(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006b14c: 48 8b 35 55 ca 05 00        	movq	0x5ca55(%rip), %rsi     ## 0x1000c7ba8    ; sel "defaultManager"
10006b153: 41 ff d5                    	callq	*%r13
10006b156: 48 89 c7                    	movq	%rax, %rdi
10006b159: 48 8b 35 f8 fd 05 00        	movq	0x5fdf8(%rip), %rsi     ## 0x1000caf58    ; sel "fileSystemRepresentationWithPath:"
10006b160: 4c 89 f2                    	movq	%r14, %rdx
10006b163: 41 ff d5                    	callq	*%r13
10006b166: 48 89 c7                    	movq	%rax, %rdi
10006b169: 48 8d b5 40 ff ff ff        	leaq	-0xc0(%rbp), %rsi
10006b170: e8 d1 e5 00 00              	callq	0x100079746    ; import "_lstat$INODE64"
10006b175: 85 c0                       	testl	%eax, %eax
10006b177: 79 03                       	jns	0x10006b17c <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xf9>
10006b179: 45 31 f6                    	xorl	%r14d, %r14d
10006b17c: 4d 89 f7                    	movq	%r14, %r15
10006b17f: e9 69 ff ff ff              	jmp	0x10006b0ed <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x6a>
10006b184: 45 31 ff                    	xorl	%r15d, %r15d
10006b187: 4c 89 f8                    	movq	%r15, %rax
10006b18a: 48 81 c4 98 00 00 00        	addq	$0x98, %rsp
10006b191: 5b                          	popq	%rbx
10006b192: 41 5c                       	popq	%r12
10006b194: 41 5d                       	popq	%r13
10006b196: 41 5e                       	popq	%r14
10006b198: 41 5f                       	popq	%r15
10006b19a: 5d                          	popq	%rbp
10006b19b: c3                          	retq


000000010006b320 <_PFMoveToApplicationsFolderIfNecessary>:
10006b320: 55                          	pushq	%rbp
10006b321: 48 89 e5                    	movq	%rsp, %rbp
10006b324: 41 57                       	pushq	%r15
10006b326: 41 56                       	pushq	%r14
10006b328: 41 55                       	pushq	%r13
10006b32a: 41 54                       	pushq	%r12
10006b32c: 53                          	pushq	%rbx
10006b32d: 48 81 ec a8 02 00 00        	subq	$0x2a8, %rsp            ## imm = 0x2A8
10006b334: 48 8b 05 55 1f 03 00        	movq	0x31f55(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
10006b33b: 48 8b 00                    	movq	(%rax), %rax
10006b33e: 48 89 45 d0                 	movq	%rax, -0x30(%rbp)
10006b342: 48 8b 3d bf 01 06 00        	movq	0x601bf(%rip), %rdi     ## 0x1000cb508    ; class "NSUserDefaults"
10006b349: 48 8b 35 48 bf 05 00        	movq	0x5bf48(%rip), %rsi     ## 0x1000c7298    ; sel "standardUserDefaults"
10006b350: 4c 8b 2d b9 1f 03 00        	movq	0x31fb9(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b357: 41 ff d5                    	callq	*%r13
10006b35a: 48 89 c3                    	movq	%rax, %rbx
10006b35d: 48 8b 35 d4 e2 05 00        	movq	0x5e2d4(%rip), %rsi     ## 0x1000c9638    ; sel "boolForKey:"
10006b364: 48 8d 15 9d a1 03 00        	leaq	0x3a19d(%rip), %rdx     ## 0x1000a5508    ; cfstr "moveToApplicationsFolderAlertSuppress"
10006b36b: 48 89 c7                    	movq	%rax, %rdi
10006b36e: 41 ff d5                    	callq	*%r13
10006b371: 84 c0                       	testb	%al, %al
10006b373: 74 26                       	je	0x10006b39b <_PFMoveToApplicationsFolderIfNecessary+0x7b>
10006b375: 48 8b 05 14 1f 03 00        	movq	0x31f14(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
10006b37c: 48 8b 00                    	movq	(%rax), %rax
10006b37f: 48 3b 45 d0                 	cmpq	-0x30(%rbp), %rax
10006b383: 0f 85 33 10 00 00           	jne	0x10006c3bc <_PFMoveToApplicationsFolderIfNecessary+0x109c>
10006b389: 48 81 c4 a8 02 00 00        	addq	$0x2a8, %rsp            ## imm = 0x2A8
10006b390: 5b                          	popq	%rbx
10006b391: 41 5c                       	popq	%r12
10006b393: 41 5d                       	popq	%r13
10006b395: 41 5e                       	popq	%r14
10006b397: 41 5f                       	popq	%r15
10006b399: 5d                          	popq	%rbp
10006b39a: c3                          	retq
10006b39b: 48 89 9d 18 fe ff ff        	movq	%rbx, -0x1e8(%rbp)
10006b3a2: 48 8b 3d d7 01 06 00        	movq	0x601d7(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006b3a9: 48 8b 35 68 c5 05 00        	movq	0x5c568(%rip), %rsi     ## 0x1000c7918    ; sel "mainBundle"
10006b3b0: 41 ff d5                    	callq	*%r13
10006b3b3: 48 8b 35 2e d1 05 00        	movq	0x5d12e(%rip), %rsi     ## 0x1000c84e8    ; sel "bundlePath"
10006b3ba: 48 89 c7                    	movq	%rax, %rdi
10006b3bd: 41 ff d5                    	callq	*%r13
10006b3c0: 48 89 85 30 fe ff ff        	movq	%rax, -0x1d0(%rbp)
10006b3c7: bf 01 00 00 00              	movl	$0x1, %edi
10006b3cc: be ff ff 00 00              	movl	$0xffff, %esi           ## imm = 0xFFFF
10006b3d1: ba 01 00 00 00              	movl	$0x1, %edx
10006b3d6: e8 f1 e1 00 00              	callq	0x1000795cc    ; import "_NSSearchPathForDirectoriesInDomains"
10006b3db: 48 89 c3                    	movq	%rax, %rbx
10006b3de: 66 0f 57 c0                 	xorpd	%xmm0, %xmm0
10006b3e2: 48 8d 95 70 fd ff ff        	leaq	-0x290(%rbp), %rdx
10006b3e9: 66 0f 29 02                 	movapd	%xmm0, (%rdx)
10006b3ed: 66 0f 29 42 10              	movapd	%xmm0, 0x10(%rdx)
10006b3f2: 66 0f 29 42 20              	movapd	%xmm0, 0x20(%rdx)
10006b3f7: 66 0f 29 42 30              	movapd	%xmm0, 0x30(%rdx)
10006b3fc: 48 8b 35 35 c3 05 00        	movq	0x5c335(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b403: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006b40a: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b410: 48 89 c7                    	movq	%rax, %rdi
10006b413: 41 ff d5                    	callq	*%r13
10006b416: 48 85 c0                    	testq	%rax, %rax
10006b419: 74 7b                       	je	0x10006b496 <_PFMoveToApplicationsFolderIfNecessary+0x176>
10006b41b: 49 89 c4                    	movq	%rax, %r12
10006b41e: 4c 8d bd 70 fd ff ff        	leaq	-0x290(%rbp), %r15
10006b425: 49 8b 47 10                 	movq	0x10(%r15), %rax
10006b429: 4c 8b 30                    	movq	(%rax), %r14
10006b42c: 45 31 ed                    	xorl	%r13d, %r13d
10006b42f: 48 8b 85 80 fd ff ff        	movq	-0x280(%rbp), %rax
10006b436: 4c 39 30                    	cmpq	%r14, (%rax)
10006b439: 74 08                       	je	0x10006b443 <_PFMoveToApplicationsFolderIfNecessary+0x123>
10006b43b: 48 89 df                    	movq	%rbx, %rdi
10006b43e: e8 4b e3 00 00              	callq	0x10007978e    ; import "_objc_enumerationMutation"
10006b443: 48 8b 85 78 fd ff ff        	movq	-0x288(%rbp), %rax
10006b44a: 4a 8b 34 e8                 	movq	(%rax,%r13,8), %rsi
10006b44e: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006b455: e8 87 12 00 00              	callq	0x10006c6e1 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
10006b45a: 84 c0                       	testb	%al, %al
10006b45c: 0f 85 13 ff ff ff           	jne	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006b462: 49 ff c5                    	incq	%r13
10006b465: 4d 39 ec                    	cmpq	%r13, %r12
10006b468: 75 c5                       	jne	0x10006b42f <_PFMoveToApplicationsFolderIfNecessary+0x10f>
10006b46a: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b470: 48 89 df                    	movq	%rbx, %rdi
10006b473: 48 8b 35 be c2 05 00        	movq	0x5c2be(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b47a: 4c 89 fa                    	movq	%r15, %rdx
10006b47d: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006b484: 4c 8b 2d 85 1e 03 00        	movq	0x31e85(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b48b: 41 ff d5                    	callq	*%r13
10006b48e: 49 89 c4                    	movq	%rax, %r12
10006b491: 48 85 c0                    	testq	%rax, %rax
10006b494: 75 96                       	jne	0x10006b42c <_PFMoveToApplicationsFolderIfNecessary+0x10c>
10006b496: 48 8b 35 63 f1 05 00        	movq	0x5f163(%rip), %rsi     ## 0x1000ca600    ; sel "pathComponents"
10006b49d: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006b4a4: 41 ff d5                    	callq	*%r13
10006b4a7: 48 89 c3                    	movq	%rax, %rbx
10006b4aa: 48 8b 35 ef c9 05 00        	movq	0x5c9ef(%rip), %rsi     ## 0x1000c7ea0    ; sel "containsObject:"
10006b4b1: 48 8d 15 70 a0 03 00        	leaq	0x3a070(%rip), %rdx     ## 0x1000a5528    ; cfstr "Applications"
10006b4b8: 48 89 c7                    	movq	%rax, %rdi
10006b4bb: 41 ff d5                    	callq	*%r13
10006b4be: 84 c0                       	testb	%al, %al
10006b4c0: 0f 85 af fe ff ff           	jne	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006b4c6: 66 0f 57 c0                 	xorpd	%xmm0, %xmm0
10006b4ca: 48 8d 95 b0 fd ff ff        	leaq	-0x250(%rbp), %rdx
10006b4d1: 66 0f 29 42 30              	movapd	%xmm0, 0x30(%rdx)
10006b4d6: 66 0f 29 42 20              	movapd	%xmm0, 0x20(%rdx)
10006b4db: 66 0f 29 42 10              	movapd	%xmm0, 0x10(%rdx)
10006b4e0: 66 0f 29 02                 	movapd	%xmm0, (%rdx)
10006b4e4: 48 8d 8d d0 fe ff ff        	leaq	-0x130(%rbp), %rcx
10006b4eb: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b4f1: 48 89 df                    	movq	%rbx, %rdi
10006b4f4: 48 8b 35 3d c2 05 00        	movq	0x5c23d(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b4fb: ff 15 0f 1e 03 00           	callq	*0x31e0f(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b501: 48 85 c0                    	testq	%rax, %rax
10006b504: 0f 84 87 00 00 00           	je	0x10006b591 <_PFMoveToApplicationsFolderIfNecessary+0x271>
10006b50a: 49 89 c4                    	movq	%rax, %r12
10006b50d: 48 8d 85 b0 fd ff ff        	leaq	-0x250(%rbp), %rax
10006b514: 48 8b 40 10                 	movq	0x10(%rax), %rax
10006b518: 4c 8b 30                    	movq	(%rax), %r14
10006b51b: 4c 8b 3d c6 ca 05 00        	movq	0x5cac6(%rip), %r15     ## 0x1000c7fe8    ; sel "caseInsensitiveCompare:"
10006b522: 45 31 ed                    	xorl	%r13d, %r13d
10006b525: 48 8b 85 c0 fd ff ff        	movq	-0x240(%rbp), %rax
10006b52c: 4c 39 30                    	cmpq	%r14, (%rax)
10006b52f: 74 08                       	je	0x10006b539 <_PFMoveToApplicationsFolderIfNecessary+0x219>
10006b531: 48 89 df                    	movq	%rbx, %rdi
10006b534: e8 55 e2 00 00              	callq	0x10007978e    ; import "_objc_enumerationMutation"
10006b539: 48 8b 85 b8 fd ff ff        	movq	-0x248(%rbp), %rax
10006b540: 4a 8b 3c e8                 	movq	(%rax,%r13,8), %rdi
10006b544: 4c 89 fe                    	movq	%r15, %rsi
10006b547: 48 8d 15 fa 9f 03 00        	leaq	0x39ffa(%rip), %rdx     ## 0x1000a5548    ; cfstr "SteamApps"
10006b54e: ff 15 bc 1d 03 00           	callq	*0x31dbc(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b554: 48 85 c0                    	testq	%rax, %rax
10006b557: 0f 84 18 fe ff ff           	je	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006b55d: 49 ff c5                    	incq	%r13
10006b560: 4d 39 ec                    	cmpq	%r13, %r12
10006b563: 75 c0                       	jne	0x10006b525 <_PFMoveToApplicationsFolderIfNecessary+0x205>
10006b565: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b56b: 48 89 df                    	movq	%rbx, %rdi
10006b56e: 48 8b 35 c3 c1 05 00        	movq	0x5c1c3(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b575: 48 8d 95 b0 fd ff ff        	leaq	-0x250(%rbp), %rdx
10006b57c: 48 8d 8d d0 fe ff ff        	leaq	-0x130(%rbp), %rcx
10006b583: ff 15 87 1d 03 00           	callq	*0x31d87(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b589: 49 89 c4                    	movq	%rax, %r12
10006b58c: 48 85 c0                    	testq	%rax, %rax
10006b58f: 75 8a                       	jne	0x10006b51b <_PFMoveToApplicationsFolderIfNecessary+0x1fb>
10006b591: 48 8b 3d 40 00 06 00        	movq	0x60040(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006b598: 48 8b 1d 09 c6 05 00        	movq	0x5c609(%rip), %rbx     ## 0x1000c7ba8    ; sel "defaultManager"
10006b59f: 48 89 de                    	movq	%rbx, %rsi
10006b5a2: 4c 8b 2d 67 1d 03 00        	movq	0x31d67(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b5a9: 41 ff d5                    	callq	*%r13
10006b5ac: 48 89 85 08 fe ff ff        	movq	%rax, -0x1f8(%rbp)
10006b5b3: 31 ff                       	xorl	%edi, %edi
10006b5b5: e8 b6 0f 00 00              	callq	0x10006c570 <_IsLaunchedFromDMG>    ; call "_IsLaunchedFromDMG"
10006b5ba: 88 85 4f fe ff ff           	movb	%al, -0x1b1(%rbp)
10006b5c0: 48 8b 3d 11 00 06 00        	movq	0x60011(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006b5c7: 48 89 de                    	movq	%rbx, %rsi
10006b5ca: 41 ff d5                    	callq	*%r13
10006b5cd: 48 89 c3                    	movq	%rax, %rbx
10006b5d0: bf 01 00 00 00              	movl	$0x1, %edi
10006b5d5: be 01 00 00 00              	movl	$0x1, %esi
10006b5da: ba 01 00 00 00              	movl	$0x1, %edx
10006b5df: e8 e8 df 00 00              	callq	0x1000795cc    ; import "_NSSearchPathForDirectoriesInDomains"
10006b5e4: 49 89 c7                    	movq	%rax, %r15
10006b5e7: 48 8b 35 d2 c2 05 00        	movq	0x5c2d2(%rip), %rsi     ## 0x1000c78c0    ; sel "count"
10006b5ee: 48 89 c7                    	movq	%rax, %rdi
10006b5f1: 41 ff d5                    	callq	*%r13
10006b5f4: 48 85 c0                    	testq	%rax, %rax
10006b5f7: 0f 84 e1 01 00 00           	je	0x10006b7de <_PFMoveToApplicationsFolderIfNecessary+0x4be>
10006b5fd: 48 8b 35 04 c5 05 00        	movq	0x5c504(%rip), %rsi     ## 0x1000c7b08    ; sel "objectAtIndex:"
10006b604: 4c 89 ff                    	movq	%r15, %rdi
10006b607: 31 d2                       	xorl	%edx, %edx
10006b609: 41 ff d5                    	callq	*%r13
10006b60c: 48 8b 35 c5 c9 05 00        	movq	0x5c9c5(%rip), %rsi     ## 0x1000c7fd8    ; sel "fileExistsAtPath:isDirectory:"
10006b613: 48 8d 8d 70 fd ff ff        	leaq	-0x290(%rbp), %rcx
10006b61a: 48 89 df                    	movq	%rbx, %rdi
10006b61d: 48 89 85 38 fe ff ff        	movq	%rax, -0x1c8(%rbp)
10006b624: 48 89 c2                    	movq	%rax, %rdx
10006b627: 41 ff d5                    	callq	*%r13
10006b62a: 84 c0                       	testb	%al, %al
10006b62c: 0f 84 a5 01 00 00           	je	0x10006b7d7 <_PFMoveToApplicationsFolderIfNecessary+0x4b7>
10006b632: 80 bd 70 fd ff ff 00        	cmpb	$0x0, -0x290(%rbp)
10006b639: 0f 84 98 01 00 00           	je	0x10006b7d7 <_PFMoveToApplicationsFolderIfNecessary+0x4b7>
10006b63f: 48 8b 35 ba c9 05 00        	movq	0x5c9ba(%rip), %rsi     ## 0x1000c8000    ; sel "contentsOfDirectoryAtPath:error:"
10006b646: 48 89 df                    	movq	%rbx, %rdi
10006b649: 48 8b 95 38 fe ff ff        	movq	-0x1c8(%rbp), %rdx
10006b650: 31 c9                       	xorl	%ecx, %ecx
10006b652: 48 8b 1d b7 1c 03 00        	movq	0x31cb7(%rip), %rbx     ## 0x10009d310    ; import "_objc_msgSend"
10006b659: ff d3                       	callq	*%rbx
10006b65b: 49 89 c6                    	movq	%rax, %r14
10006b65e: 48 8b 3d 6b ff 05 00        	movq	0x5ff6b(%rip), %rdi     ## 0x1000cb5d0    ; class "NSWorkspace"
10006b665: 48 8b 35 fc c4 05 00        	movq	0x5c4fc(%rip), %rsi     ## 0x1000c7b68    ; sel "sharedWorkspace"
10006b66c: ff d3                       	callq	*%rbx
10006b66e: 49 89 c4                    	movq	%rax, %r12
10006b671: 66 0f 57 c0                 	xorpd	%xmm0, %xmm0
10006b675: 48 8d 95 d0 fe ff ff        	leaq	-0x130(%rbp), %rdx
10006b67c: 66 0f 29 02                 	movapd	%xmm0, (%rdx)
10006b680: 66 0f 29 42 10              	movapd	%xmm0, 0x10(%rdx)
10006b685: 66 0f 29 42 20              	movapd	%xmm0, 0x20(%rdx)
10006b68a: 66 0f 29 42 30              	movapd	%xmm0, 0x30(%rdx)
10006b68f: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006b696: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b69c: 4c 89 b5 f8 fd ff ff        	movq	%r14, -0x208(%rbp)
10006b6a3: 4c 89 f7                    	movq	%r14, %rdi
10006b6a6: 48 8b 35 8b c0 05 00        	movq	0x5c08b(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b6ad: ff d3                       	callq	*%rbx
10006b6af: 48 89 85 28 fe ff ff        	movq	%rax, -0x1d8(%rbp)
10006b6b6: 48 85 c0                    	testq	%rax, %rax
10006b6b9: 0f 84 18 01 00 00           	je	0x10006b7d7 <_PFMoveToApplicationsFolderIfNecessary+0x4b7>
10006b6bf: 48 8d 85 d0 fe ff ff        	leaq	-0x130(%rbp), %rax
10006b6c6: 48 8b 40 10                 	movq	0x10(%rax), %rax
10006b6ca: 48 8b 00                    	movq	(%rax), %rax
10006b6cd: 48 89 85 00 fe ff ff        	movq	%rax, -0x200(%rbp)
10006b6d4: 48 8b 05 25 1c 03 00        	movq	0x31c25(%rip), %rax     ## 0x10009d300    ; import "_kUTTypeApplication"
10006b6db: 48 8b 00                    	movq	(%rax), %rax
10006b6de: 48 89 85 f0 fd ff ff        	movq	%rax, -0x210(%rbp)
10006b6e5: 48 8b 05 94 c7 05 00        	movq	0x5c794(%rip), %rax     ## 0x1000c7e80    ; sel "stringByAppendingPathComponent:"
10006b6ec: 48 89 85 40 fe ff ff        	movq	%rax, -0x1c0(%rbp)
10006b6f3: 4c 8b 3d be f8 05 00        	movq	0x5f8be(%rip), %r15     ## 0x1000cafb8    ; sel "stringByResolvingSymlinksAndAliases"
10006b6fa: 48 8b 1d bf f8 05 00        	movq	0x5f8bf(%rip), %rbx     ## 0x1000cafc0    ; sel "typeOfFile:error:"
10006b701: 48 8b 05 38 f4 05 00        	movq	0x5f438(%rip), %rax     ## 0x1000cab40    ; sel "type:conformsToType:"
10006b708: 48 89 85 10 fe ff ff        	movq	%rax, -0x1f0(%rbp)
10006b70f: 45 31 f6                    	xorl	%r14d, %r14d
10006b712: 48 8b 85 e0 fe ff ff        	movq	-0x120(%rbp), %rax
10006b719: 48 8b 8d 00 fe ff ff        	movq	-0x200(%rbp), %rcx
10006b720: 48 39 08                    	cmpq	%rcx, (%rax)
10006b723: 74 0c                       	je	0x10006b731 <_PFMoveToApplicationsFolderIfNecessary+0x411>
10006b725: 48 8b bd f8 fd ff ff        	movq	-0x208(%rbp), %rdi
10006b72c: e8 5d e0 00 00              	callq	0x10007978e    ; import "_objc_enumerationMutation"
10006b731: 48 8b 85 d8 fe ff ff        	movq	-0x128(%rbp), %rax
10006b738: 4a 8b 14 f0                 	movq	(%rax,%r14,8), %rdx
10006b73c: 48 8b bd 38 fe ff ff        	movq	-0x1c8(%rbp), %rdi
10006b743: 48 8b b5 40 fe ff ff        	movq	-0x1c0(%rbp), %rsi
10006b74a: 4c 8b 2d bf 1b 03 00        	movq	0x31bbf(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b751: 41 ff d5                    	callq	*%r13
10006b754: 48 89 c7                    	movq	%rax, %rdi
10006b757: 4c 89 fe                    	movq	%r15, %rsi
10006b75a: 41 ff d5                    	callq	*%r13
10006b75d: 4c 89 e7                    	movq	%r12, %rdi
10006b760: 48 89 de                    	movq	%rbx, %rsi
10006b763: 48 89 c2                    	movq	%rax, %rdx
10006b766: 31 c9                       	xorl	%ecx, %ecx
10006b768: 41 ff d5                    	callq	*%r13
10006b76b: 48 85 c0                    	testq	%rax, %rax
10006b76e: 74 1f                       	je	0x10006b78f <_PFMoveToApplicationsFolderIfNecessary+0x46f>
10006b770: 4c 89 e7                    	movq	%r12, %rdi
10006b773: 48 8b b5 10 fe ff ff        	movq	-0x1f0(%rbp), %rsi
10006b77a: 48 89 c2                    	movq	%rax, %rdx
10006b77d: 48 8b 8d f0 fd ff ff        	movq	-0x210(%rbp), %rcx
10006b784: 41 ff d5                    	callq	*%r13
10006b787: 84 c0                       	testb	%al, %al
10006b789: 0f 85 1d 01 00 00           	jne	0x10006b8ac <_PFMoveToApplicationsFolderIfNecessary+0x58c>
10006b78f: 49 ff c6                    	incq	%r14
10006b792: 4c 39 b5 28 fe ff ff        	cmpq	%r14, -0x1d8(%rbp)
10006b799: 0f 85 73 ff ff ff           	jne	0x10006b712 <_PFMoveToApplicationsFolderIfNecessary+0x3f2>
10006b79f: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006b7a5: 48 8b bd f8 fd ff ff        	movq	-0x208(%rbp), %rdi
10006b7ac: 48 8b 35 85 bf 05 00        	movq	0x5bf85(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006b7b3: 48 8d 95 d0 fe ff ff        	leaq	-0x130(%rbp), %rdx
10006b7ba: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006b7c1: ff 15 49 1b 03 00           	callq	*0x31b49(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b7c7: 48 89 85 28 fe ff ff        	movq	%rax, -0x1d8(%rbp)
10006b7ce: 48 85 c0                    	testq	%rax, %rax
10006b7d1: 0f 85 0e ff ff ff           	jne	0x10006b6e5 <_PFMoveToApplicationsFolderIfNecessary+0x3c5>
10006b7d7: 4c 8b 2d 32 1b 03 00        	movq	0x31b32(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006b7de: bf 01 00 00 00              	movl	$0x1, %edi
10006b7e3: be 02 00 00 00              	movl	$0x2, %esi
10006b7e8: ba 01 00 00 00              	movl	$0x1, %edx
10006b7ed: e8 da dd 00 00              	callq	0x1000795cc    ; import "_NSSearchPathForDirectoriesInDomains"
10006b7f2: 48 8b 35 a7 be 05 00        	movq	0x5bea7(%rip), %rsi     ## 0x1000c76a0    ; sel "lastObject"
10006b7f9: 48 89 c7                    	movq	%rax, %rdi
10006b7fc: 41 ff d5                    	callq	*%r13
10006b7ff: 48 8b 35 b2 f7 05 00        	movq	0x5f7b2(%rip), %rsi     ## 0x1000cafb8    ; sel "stringByResolvingSymlinksAndAliases"
10006b806: 48 89 c7                    	movq	%rax, %rdi
10006b809: 41 ff d5                    	callq	*%r13
10006b80c: 49 89 c7                    	movq	%rax, %r15
10006b80f: 48 8d 05 32 9b 03 00        	leaq	0x39b32(%rip), %rax     ## 0x1000a5348    ; cfstr "Move to Applications folder?"
10006b816: 48 89 85 28 fe ff ff        	movq	%rax, -0x1d8(%rbp)
10006b81d: 48 8b 1d 5c c6 05 00        	movq	0x5c65c(%rip), %rbx     ## 0x1000c7e80    ; sel "stringByAppendingPathComponent:"
10006b824: 48 8b 35 e5 c7 05 00        	movq	0x5c7e5(%rip), %rsi     ## 0x1000c8010    ; sel "lastPathComponent"
10006b82b: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006b832: 41 ff d5                    	callq	*%r13
10006b835: 4c 89 ff                    	movq	%r15, %rdi
10006b838: 48 89 de                    	movq	%rbx, %rsi
10006b83b: 48 89 c2                    	movq	%rax, %rdx
10006b83e: 41 ff d5                    	callq	*%r13
10006b841: 49 89 c6                    	movq	%rax, %r14
10006b844: 4c 8b 25 e5 c8 05 00        	movq	0x5c8e5(%rip), %r12     ## 0x1000c8130    ; sel "isWritableFileAtPath:"
10006b84b: 48 8b 9d 08 fe ff ff        	movq	-0x1f8(%rbp), %rbx
10006b852: 48 89 df                    	movq	%rbx, %rdi
10006b855: 4c 89 e6                    	movq	%r12, %rsi
10006b858: 4c 89 fa                    	movq	%r15, %rdx
10006b85b: 41 ff d5                    	callq	*%r13
10006b85e: 84 c0                       	testb	%al, %al
10006b860: 74 46                       	je	0x10006b8a8 <_PFMoveToApplicationsFolderIfNecessary+0x588>
10006b862: 48 8b 35 6f c7 05 00        	movq	0x5c76f(%rip), %rsi     ## 0x1000c7fd8    ; sel "fileExistsAtPath:isDirectory:"
10006b869: 48 8d 8d 4e fe ff ff        	leaq	-0x1b2(%rbp), %rcx
10006b870: 48 89 df                    	movq	%rbx, %rdi
10006b873: 4c 89 f2                    	movq	%r14, %rdx
10006b876: ff 15 94 1a 03 00           	callq	*0x31a94(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b87c: 84 c0                       	testb	%al, %al
10006b87e: 74 59                       	je	0x10006b8d9 <_PFMoveToApplicationsFolderIfNecessary+0x5b9>
10006b880: 80 bd 4e fe ff ff 00        	cmpb	$0x0, -0x1b2(%rbp)
10006b887: bb 00 00 00 00              	movl	$0x0, %ebx
10006b88c: 74 4d                       	je	0x10006b8db <_PFMoveToApplicationsFolderIfNecessary+0x5bb>
10006b88e: 48 8b bd 08 fe ff ff        	movq	-0x1f8(%rbp), %rdi
10006b895: 4c 89 e6                    	movq	%r12, %rsi
10006b898: 4c 89 f2                    	movq	%r14, %rdx
10006b89b: ff 15 6f 1a 03 00           	callq	*0x31a6f(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b8a1: 84 c0                       	testb	%al, %al
10006b8a3: 0f 94 c3                    	sete	%bl
10006b8a6: eb 33                       	jmp	0x10006b8db <_PFMoveToApplicationsFolderIfNecessary+0x5bb>
10006b8a8: b3 01                       	movb	$0x1, %bl
10006b8aa: eb 2f                       	jmp	0x10006b8db <_PFMoveToApplicationsFolderIfNecessary+0x5bb>
10006b8ac: 48 8b bd 38 fe ff ff        	movq	-0x1c8(%rbp), %rdi
10006b8b3: 4c 89 fe                    	movq	%r15, %rsi
10006b8b6: ff 15 54 1a 03 00           	callq	*0x31a54(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006b8bc: 49 89 c7                    	movq	%rax, %r15
10006b8bf: 48 8d 05 42 9a 03 00        	leaq	0x39a42(%rip), %rax     ## 0x1000a5308    ; cfstr "Move to Applications folder in your Home folder?"
10006b8c6: 48 89 85 28 fe ff ff        	movq	%rax, -0x1d8(%rbp)
10006b8cd: 48 8b 9d 40 fe ff ff        	movq	-0x1c0(%rbp), %rbx
10006b8d4: e9 4b ff ff ff              	jmp	0x10006b824 <_PFMoveToApplicationsFolderIfNecessary+0x504>
10006b8d9: 31 db                       	xorl	%ebx, %ebx
10006b8db: 4c 89 b5 38 fe ff ff        	movq	%r14, -0x1c8(%rbp)
10006b8e2: 48 8b 3d 17 fd 05 00        	movq	0x5fd17(%rip), %rdi     ## 0x1000cb600    ; class "NSAlert"
10006b8e9: e8 6a de 00 00              	callq	0x100079758    ; import "_objc_alloc_init"
10006b8ee: 48 89 c7                    	movq	%rax, %rdi
10006b8f1: e8 68 de 00 00              	callq	0x10007975e    ; import "_objc_autorelease"
10006b8f6: 49 89 c7                    	movq	%rax, %r15
10006b8f9: 48 8b 3d 80 fc 05 00        	movq	0x5fc80(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006b900: 4c 8b 35 11 c0 05 00        	movq	0x5c011(%rip), %r14     ## 0x1000c7918    ; sel "mainBundle"
10006b907: 4c 89 f6                    	movq	%r14, %rsi
10006b90a: 41 ff d5                    	callq	*%r13
10006b90d: 4c 8b 25 0c c0 05 00        	movq	0x5c00c(%rip), %r12     ## 0x1000c7920    ; sel "localizedStringForKey:value:table:"
10006b914: 48 8d 0d 4d 25 03 00        	leaq	0x3254d(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006b91b: 4c 8d 05 06 9a 03 00        	leaq	0x39a06(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006b922: 48 89 c7                    	movq	%rax, %rdi
10006b925: 4c 89 e6                    	movq	%r12, %rsi
10006b928: 48 8b 95 28 fe ff ff        	movq	-0x1d8(%rbp), %rdx
10006b92f: 41 ff d5                    	callq	*%r13
10006b932: 48 8b 35 07 c4 05 00        	movq	0x5c407(%rip), %rsi     ## 0x1000c7d40    ; sel "setMessageText:"
10006b939: 4c 89 bd 28 fe ff ff        	movq	%r15, -0x1d8(%rbp)
10006b940: 4c 89 ff                    	movq	%r15, %rdi
10006b943: 48 89 c2                    	movq	%rax, %rdx
10006b946: 41 ff d5                    	callq	*%r13
10006b949: 48 8b 3d 30 fc 05 00        	movq	0x5fc30(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006b950: 4c 89 f6                    	movq	%r14, %rsi
10006b953: 41 ff d5                    	callq	*%r13
10006b956: 48 8d 15 0b 9a 03 00        	leaq	0x39a0b(%rip), %rdx     ## 0x1000a5368    ; cfstr "I can move myself to the Applications folder if you'd like."
10006b95d: 48 89 c7                    	movq	%rax, %rdi
10006b960: 4c 89 e6                    	movq	%r12, %rsi
10006b963: 48 8d 0d fe 24 03 00        	leaq	0x324fe(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006b96a: 4c 8d 05 b7 99 03 00        	leaq	0x399b7(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006b971: 41 ff d5                    	callq	*%r13
10006b974: 84 db                       	testb	%bl, %bl
10006b976: 89 9d 00 fe ff ff           	movl	%ebx, -0x200(%rbp)
10006b97c: 74 7c                       	je	0x10006b9fa <_PFMoveToApplicationsFolderIfNecessary+0x6da>
10006b97e: 4c 8b 3d 93 c3 05 00        	movq	0x5c393(%rip), %r15     ## 0x1000c7d18    ; sel "stringByAppendingString:"
10006b985: 48 8d 15 bc 24 03 00        	leaq	0x324bc(%rip), %rdx     ## 0x10009de48    ; cfstr " "
10006b98c: 48 89 c7                    	movq	%rax, %rdi
10006b98f: 4c 89 fe                    	movq	%r15, %rsi
10006b992: 41 ff d5                    	callq	*%r13
10006b995: 48 89 c3                    	movq	%rax, %rbx
10006b998: 48 8b 3d e1 fb 05 00        	movq	0x5fbe1(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006b99f: 4c 8b 35 72 bf 05 00        	movq	0x5bf72(%rip), %r14     ## 0x1000c7918    ; sel "mainBundle"
10006b9a6: 4c 89 f6                    	movq	%r14, %rsi
10006b9a9: 41 ff d5                    	callq	*%r13
10006b9ac: 48 8d 15 d5 99 03 00        	leaq	0x399d5(%rip), %rdx     ## 0x1000a5388    ; cfstr "Note that this will require an administrator password."
10006b9b3: 48 8d 0d ae 24 03 00        	leaq	0x324ae(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006b9ba: 4c 8d 05 67 99 03 00        	leaq	0x39967(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006b9c1: 48 89 c7                    	movq	%rax, %rdi
10006b9c4: 4c 8b 25 55 bf 05 00        	movq	0x5bf55(%rip), %r12     ## 0x1000c7920    ; sel "localizedStringForKey:value:table:"
10006b9cb: 4c 89 e6                    	movq	%r12, %rsi
10006b9ce: 41 ff d5                    	callq	*%r13
10006b9d1: 48 89 df                    	movq	%rbx, %rdi
10006b9d4: 4c 89 fe                    	movq	%r15, %rsi
10006b9d7: 48 89 c2                    	movq	%rax, %rdx
10006b9da: 41 ff d5                    	callq	*%r13
10006b9dd: 48 89 c2                    	movq	%rax, %rdx
10006b9e0: 48 8b 05 39 16 03 00        	movq	0x31639(%rip), %rax     ## 0x10009d020    ; import "_NSAppKitVersionNumber"
10006b9e7: 66 0f 3a 0b 00 09           	roundsd	$0x9, (%rax), %xmm0
10006b9ed: f2 0f 11 85 40 fe ff ff     	movsd	%xmm0, -0x1c0(%rbp)
10006b9f5: e9 bb 01 00 00              	jmp	0x10006bbb5 <_PFMoveToApplicationsFolderIfNecessary+0x895>
10006b9fa: 48 89 85 10 fe ff ff        	movq	%rax, -0x1f0(%rbp)
10006ba01: 48 8b 05 18 16 03 00        	movq	0x31618(%rip), %rax     ## 0x10009d020    ; import "_NSAppKitVersionNumber"
10006ba08: 66 0f 3a 0b 00 09           	roundsd	$0x9, (%rax), %xmm0
10006ba0e: f2 0f 11 85 40 fe ff ff     	movsd	%xmm0, -0x1c0(%rbp)
10006ba16: 66 0f 2e 05 f2 fb 02 00     	ucomisd	0x2fbf2(%rip), %xmm0    ## 0x10009b610 <_validIcnsImageDimensions+0x110>
10006ba1e: 0f 86 d7 00 00 00           	jbe	0x10006bafb <_PFMoveToApplicationsFolderIfNecessary+0x7db>
10006ba24: bf 0f 00 00 00              	movl	$0xf, %edi
10006ba29: be ff ff 00 00              	movl	$0xffff, %esi           ## imm = 0xFFFF
10006ba2e: ba 01 00 00 00              	movl	$0x1, %edx
10006ba33: e8 94 db 00 00              	callq	0x1000795cc    ; import "_NSSearchPathForDirectoriesInDomains"
10006ba38: 49 89 c5                    	movq	%rax, %r13
10006ba3b: 66 0f 57 c0                 	xorpd	%xmm0, %xmm0
10006ba3f: 48 8d 95 d0 fe ff ff        	leaq	-0x130(%rbp), %rdx
10006ba46: 66 0f 29 02                 	movapd	%xmm0, (%rdx)
10006ba4a: 66 0f 29 42 10              	movapd	%xmm0, 0x10(%rdx)
10006ba4f: 66 0f 29 42 20              	movapd	%xmm0, 0x20(%rdx)
10006ba54: 66 0f 29 42 30              	movapd	%xmm0, 0x30(%rdx)
10006ba59: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006ba60: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006ba66: 48 89 c7                    	movq	%rax, %rdi
10006ba69: 48 8b 35 c8 bc 05 00        	movq	0x5bcc8(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006ba70: ff 15 9a 18 03 00           	callq	*0x3189a(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006ba76: 48 85 c0                    	testq	%rax, %rax
10006ba79: 74 77                       	je	0x10006baf2 <_PFMoveToApplicationsFolderIfNecessary+0x7d2>
10006ba7b: 49 89 c7                    	movq	%rax, %r15
10006ba7e: 48 8d 9d d0 fe ff ff        	leaq	-0x130(%rbp), %rbx
10006ba85: 48 8b 43 10                 	movq	0x10(%rbx), %rax
10006ba89: 4c 8b 30                    	movq	(%rax), %r14
10006ba8c: 45 31 e4                    	xorl	%r12d, %r12d
10006ba8f: 48 8b 85 e0 fe ff ff        	movq	-0x120(%rbp), %rax
10006ba96: 4c 39 30                    	cmpq	%r14, (%rax)
10006ba99: 74 08                       	je	0x10006baa3 <_PFMoveToApplicationsFolderIfNecessary+0x783>
10006ba9b: 4c 89 ef                    	movq	%r13, %rdi
10006ba9e: e8 eb dc 00 00              	callq	0x10007978e    ; import "_objc_enumerationMutation"
10006baa3: 48 8b 85 d8 fe ff ff        	movq	-0x128(%rbp), %rax
10006baaa: 4a 8b 34 e0                 	movq	(%rax,%r12,8), %rsi
10006baae: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006bab5: e8 27 0c 00 00              	callq	0x10006c6e1 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
10006baba: 84 c0                       	testb	%al, %al
10006babc: 0f 85 86 00 00 00           	jne	0x10006bb48 <_PFMoveToApplicationsFolderIfNecessary+0x828>
10006bac2: 49 ff c4                    	incq	%r12
10006bac5: 4d 39 e7                    	cmpq	%r12, %r15
10006bac8: 75 c5                       	jne	0x10006ba8f <_PFMoveToApplicationsFolderIfNecessary+0x76f>
10006baca: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006bad0: 4c 89 ef                    	movq	%r13, %rdi
10006bad3: 48 8b 35 5e bc 05 00        	movq	0x5bc5e(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006bada: 48 89 da                    	movq	%rbx, %rdx
10006badd: 48 8d 8d 50 ff ff ff        	leaq	-0xb0(%rbp), %rcx
10006bae4: ff 15 26 18 03 00           	callq	*0x31826(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006baea: 49 89 c7                    	movq	%rax, %r15
10006baed: 48 85 c0                    	testq	%rax, %rax
10006baf0: 75 9a                       	jne	0x10006ba8c <_PFMoveToApplicationsFolderIfNecessary+0x76c>
10006baf2: 4c 8b 2d 17 18 03 00        	movq	0x31817(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006baf9: eb 36                       	jmp	0x10006bb31 <_PFMoveToApplicationsFolderIfNecessary+0x811>
10006bafb: 48 8b 35 6e da 05 00        	movq	0x5da6e(%rip), %rsi     ## 0x1000c9570    ; sel "stringByDeletingLastPathComponent"
10006bb02: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006bb09: 41 ff d5                    	callq	*%r13
10006bb0c: 48 89 c7                    	movq	%rax, %rdi
10006bb0f: 48 8b 35 fa c4 05 00        	movq	0x5c4fa(%rip), %rsi     ## 0x1000c8010    ; sel "lastPathComponent"
10006bb16: 41 ff d5                    	callq	*%r13
10006bb19: 48 8b 35 40 bc 05 00        	movq	0x5bc40(%rip), %rsi     ## 0x1000c7760    ; sel "isEqualToString:"
10006bb20: 48 8d 15 41 9a 03 00        	leaq	0x39a41(%rip), %rdx     ## 0x1000a5568    ; cfstr "Downloads"
10006bb27: 48 89 c7                    	movq	%rax, %rdi
10006bb2a: 41 ff d5                    	callq	*%r13
10006bb2d: 84 c0                       	testb	%al, %al
10006bb2f: 75 1e                       	jne	0x10006bb4f <_PFMoveToApplicationsFolderIfNecessary+0x82f>
10006bb31: 4c 8b 35 e0 bd 05 00        	movq	0x5bde0(%rip), %r14     ## 0x1000c7918    ; sel "mainBundle"
10006bb38: 4c 8b 25 e1 bd 05 00        	movq	0x5bde1(%rip), %r12     ## 0x1000c7920    ; sel "localizedStringForKey:value:table:"
10006bb3f: 48 8b 95 10 fe ff ff        	movq	-0x1f0(%rbp), %rdx
10006bb46: eb 6d                       	jmp	0x10006bbb5 <_PFMoveToApplicationsFolderIfNecessary+0x895>
10006bb48: 4c 8b 2d c1 17 03 00        	movq	0x317c1(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006bb4f: 4c 8b 3d c2 c1 05 00        	movq	0x5c1c2(%rip), %r15     ## 0x1000c7d18    ; sel "stringByAppendingString:"
10006bb56: 48 8d 15 eb 22 03 00        	leaq	0x322eb(%rip), %rdx     ## 0x10009de48    ; cfstr " "
10006bb5d: 48 8b bd 10 fe ff ff        	movq	-0x1f0(%rbp), %rdi
10006bb64: 4c 89 fe                    	movq	%r15, %rsi
10006bb67: 41 ff d5                    	callq	*%r13
10006bb6a: 48 89 c3                    	movq	%rax, %rbx
10006bb6d: 48 8b 3d 0c fa 05 00        	movq	0x5fa0c(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006bb74: 4c 8b 35 9d bd 05 00        	movq	0x5bd9d(%rip), %r14     ## 0x1000c7918    ; sel "mainBundle"
10006bb7b: 4c 89 f6                    	movq	%r14, %rsi
10006bb7e: 41 ff d5                    	callq	*%r13
10006bb81: 48 8d 15 20 98 03 00        	leaq	0x39820(%rip), %rdx     ## 0x1000a53a8    ; cfstr "This will keep your Downloads folder uncluttered."
10006bb88: 48 8d 0d d9 22 03 00        	leaq	0x322d9(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006bb8f: 4c 8d 05 92 97 03 00        	leaq	0x39792(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006bb96: 48 89 c7                    	movq	%rax, %rdi
10006bb99: 4c 8b 25 80 bd 05 00        	movq	0x5bd80(%rip), %r12     ## 0x1000c7920    ; sel "localizedStringForKey:value:table:"
10006bba0: 4c 89 e6                    	movq	%r12, %rsi
10006bba3: 41 ff d5                    	callq	*%r13
10006bba6: 48 89 df                    	movq	%rbx, %rdi
10006bba9: 4c 89 fe                    	movq	%r15, %rsi
10006bbac: 48 89 c2                    	movq	%rax, %rdx
10006bbaf: 41 ff d5                    	callq	*%r13
10006bbb2: 48 89 c2                    	movq	%rax, %rdx
10006bbb5: 48 8b 35 8c c1 05 00        	movq	0x5c18c(%rip), %rsi     ## 0x1000c7d48    ; sel "setInformativeText:"
10006bbbc: 4c 8b bd 28 fe ff ff        	movq	-0x1d8(%rbp), %r15
10006bbc3: 4c 89 ff                    	movq	%r15, %rdi
10006bbc6: 41 ff d5                    	callq	*%r13
10006bbc9: 48 8b 3d b0 f9 05 00        	movq	0x5f9b0(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006bbd0: 4c 89 f6                    	movq	%r14, %rsi
10006bbd3: 41 ff d5                    	callq	*%r13
10006bbd6: 48 8d 15 eb 97 03 00        	leaq	0x397eb(%rip), %rdx     ## 0x1000a53c8    ; cfstr "Move to Applications Folder"
10006bbdd: 48 8d 0d 84 22 03 00        	leaq	0x32284(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006bbe4: 4c 8d 05 3d 97 03 00        	leaq	0x3973d(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006bbeb: 48 89 c7                    	movq	%rax, %rdi
10006bbee: 4c 89 e6                    	movq	%r12, %rsi
10006bbf1: 41 ff d5                    	callq	*%r13
10006bbf4: 48 8b 1d 5d c1 05 00        	movq	0x5c15d(%rip), %rbx     ## 0x1000c7d58    ; sel "addButtonWithTitle:"
10006bbfb: 4c 89 ff                    	movq	%r15, %rdi
10006bbfe: 48 89 de                    	movq	%rbx, %rsi
10006bc01: 48 89 c2                    	movq	%rax, %rdx
10006bc04: 41 ff d5                    	callq	*%r13
10006bc07: 48 8b 3d 72 f9 05 00        	movq	0x5f972(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006bc0e: 4c 89 f6                    	movq	%r14, %rsi
10006bc11: 41 ff d5                    	callq	*%r13
10006bc14: 48 8d 15 cd 97 03 00        	leaq	0x397cd(%rip), %rdx     ## 0x1000a53e8    ; cfstr "Do Not Move"
10006bc1b: 48 89 c7                    	movq	%rax, %rdi
10006bc1e: 4c 89 e6                    	movq	%r12, %rsi
10006bc21: 4d 89 fc                    	movq	%r15, %r12
10006bc24: 48 8d 0d 3d 22 03 00        	leaq	0x3223d(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006bc2b: 4c 8d 05 f6 96 03 00        	leaq	0x396f6(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006bc32: 41 ff d5                    	callq	*%r13
10006bc35: 4c 89 ff                    	movq	%r15, %rdi
10006bc38: 48 89 de                    	movq	%rbx, %rsi
10006bc3b: 48 89 c2                    	movq	%rax, %rdx
10006bc3e: 41 ff d5                    	callq	*%r13
10006bc41: 48 8b 35 38 f3 05 00        	movq	0x5f338(%rip), %rsi     ## 0x1000caf80    ; sel "setKeyEquivalent:"
10006bc48: 48 8d 15 b9 97 03 00        	leaq	0x397b9(%rip), %rdx     ## 0x1000a5408    ; cfstr "\u001b"
10006bc4f: 48 89 c7                    	movq	%rax, %rdi
10006bc52: 41 ff d5                    	callq	*%r13
10006bc55: f2 0f 10 85 40 fe ff ff     	movsd	-0x1c0(%rbp), %xmm0
10006bc5d: 66 0f 2e 05 ab f9 02 00     	ucomisd	0x2f9ab(%rip), %xmm0    ## 0x10009b610 <_validIcnsImageDimensions+0x110>
10006bc65: 0f 86 8a 00 00 00           	jbe	0x10006bcf5 <_PFMoveToApplicationsFolderIfNecessary+0x9d5>
10006bc6b: 48 8b 35 16 f3 05 00        	movq	0x5f316(%rip), %rsi     ## 0x1000caf88    ; sel "setShowsSuppressionButton:"
10006bc72: 4c 89 e7                    	movq	%r12, %rdi
10006bc75: ba 01 00 00 00              	movl	$0x1, %edx
10006bc7a: 41 ff d5                    	callq	*%r13
10006bc7d: 48 8b 1d 0c f3 05 00        	movq	0x5f30c(%rip), %rbx     ## 0x1000caf90    ; sel "suppressionButton"
10006bc84: 4c 89 e7                    	movq	%r12, %rdi
10006bc87: 48 89 de                    	movq	%rbx, %rsi
10006bc8a: 41 ff d5                    	callq	*%r13
10006bc8d: 4c 8b 3d dc da 05 00        	movq	0x5dadc(%rip), %r15     ## 0x1000c9770    ; sel "cell"
10006bc94: 48 89 c7                    	movq	%rax, %rdi
10006bc97: 4c 89 fe                    	movq	%r15, %rsi
10006bc9a: 41 ff d5                    	callq	*%r13
10006bc9d: 48 8b 35 74 b7 05 00        	movq	0x5b774(%rip), %rsi     ## 0x1000c7418    ; sel "setControlSize:"
10006bca4: ba 01 00 00 00              	movl	$0x1, %edx
10006bca9: 48 89 c7                    	movq	%rax, %rdi
10006bcac: 41 ff d5                    	callq	*%r13
10006bcaf: 4c 89 e7                    	movq	%r12, %rdi
10006bcb2: 48 89 de                    	movq	%rbx, %rsi
10006bcb5: 41 ff d5                    	callq	*%r13
10006bcb8: 48 89 c7                    	movq	%rax, %rdi
10006bcbb: 4c 89 fe                    	movq	%r15, %rsi
10006bcbe: 41 ff d5                    	callq	*%r13
10006bcc1: 48 89 c3                    	movq	%rax, %rbx
10006bcc4: 4c 8b 3d 35 f8 05 00        	movq	0x5f835(%rip), %r15     ## 0x1000cb500    ; class "NSFont"
10006bccb: 48 8b 35 c6 f2 05 00        	movq	0x5f2c6(%rip), %rsi     ## 0x1000caf98    ; sel "smallSystemFontSize"
10006bcd2: 4c 89 ff                    	movq	%r15, %rdi
10006bcd5: 41 ff d5                    	callq	*%r13
10006bcd8: 48 8b 35 29 bf 05 00        	movq	0x5bf29(%rip), %rsi     ## 0x1000c7c08    ; sel "systemFontOfSize:"
10006bcdf: 4c 89 ff                    	movq	%r15, %rdi
10006bce2: 41 ff d5                    	callq	*%r13
10006bce5: 48 8b 35 5c b5 05 00        	movq	0x5b55c(%rip), %rsi     ## 0x1000c7248    ; sel "setFont:"
10006bcec: 48 89 df                    	movq	%rbx, %rdi
10006bcef: 48 89 c2                    	movq	%rax, %rdx
10006bcf2: 41 ff d5                    	callq	*%r13
10006bcf5: 48 8b 1d 1c 13 03 00        	movq	0x3131c(%rip), %rbx     ## 0x10009d018    ; import "_NSApp"
10006bcfc: 48 8b 3b                    	movq	(%rbx), %rdi
10006bcff: 48 8b 35 da c5 05 00        	movq	0x5c5da(%rip), %rsi     ## 0x1000c82e0    ; sel "isActive"
10006bd06: ff 15 04 16 03 00           	callq	*0x31604(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bd0c: 84 c0                       	testb	%al, %al
10006bd0e: 4c 8b b5 38 fe ff ff        	movq	-0x1c8(%rbp), %r14
10006bd15: 75 15                       	jne	0x10006bd2c <_PFMoveToApplicationsFolderIfNecessary+0xa0c>
10006bd17: 48 8b 3b                    	movq	(%rbx), %rdi
10006bd1a: 48 8b 35 df c7 05 00        	movq	0x5c7df(%rip), %rsi     ## 0x1000c8500    ; sel "activateIgnoringOtherApps:"
10006bd21: ba 01 00 00 00              	movl	$0x1, %edx
10006bd26: ff 15 e4 15 03 00           	callq	*0x315e4(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bd2c: 48 8b 35 3d c4 05 00        	movq	0x5c43d(%rip), %rsi     ## 0x1000c8170    ; sel "runModal"
10006bd33: 4c 89 e7                    	movq	%r12, %rdi
10006bd36: ff 15 d4 15 03 00           	callq	*0x315d4(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bd3c: 48 89 c3                    	movq	%rax, %rbx
10006bd3f: f2 0f 10 85 40 fe ff ff     	movsd	-0x1c0(%rbp), %xmm0
10006bd47: 66 0f 2e 05 c1 f8 02 00     	ucomisd	0x2f8c1(%rip), %xmm0    ## 0x10009b610 <_validIcnsImageDimensions+0x110>
10006bd4f: 76 5c                       	jbe	0x10006bdad <_PFMoveToApplicationsFolderIfNecessary+0xa8d>
10006bd51: 48 8b 35 38 f2 05 00        	movq	0x5f238(%rip), %rsi     ## 0x1000caf90    ; sel "suppressionButton"
10006bd58: 4c 89 e7                    	movq	%r12, %rdi
10006bd5b: 41 ff d5                    	callq	*%r13
10006bd5e: 48 8b 35 5b d5 05 00        	movq	0x5d55b(%rip), %rsi     ## 0x1000c92c0    ; sel "state"
10006bd65: 48 89 c7                    	movq	%rax, %rdi
10006bd68: 41 ff d5                    	callq	*%r13
10006bd6b: 48 83 f8 01                 	cmpq	$0x1, %rax
10006bd6f: 75 2d                       	jne	0x10006bd9e <_PFMoveToApplicationsFolderIfNecessary+0xa7e>
10006bd71: 48 8b 35 80 b5 05 00        	movq	0x5b580(%rip), %rsi     ## 0x1000c72f8    ; sel "setBool:forKey:"
10006bd78: 48 8d 0d 89 97 03 00        	leaq	0x39789(%rip), %rcx     ## 0x1000a5508    ; cfstr "moveToApplicationsFolderAlertSuppress"
10006bd7f: 4c 8b bd 18 fe ff ff        	movq	-0x1e8(%rbp), %r15
10006bd86: 4c 89 ff                    	movq	%r15, %rdi
10006bd89: ba 01 00 00 00              	movl	$0x1, %edx
10006bd8e: 41 ff d5                    	callq	*%r13
10006bd91: 48 8b 35 98 ea 05 00        	movq	0x5ea98(%rip), %rsi     ## 0x1000ca830    ; sel "synchronize"
10006bd98: 4c 89 ff                    	movq	%r15, %rdi
10006bd9b: 41 ff d5                    	callq	*%r13
10006bd9e: 48 81 fb e8 03 00 00        	cmpq	$0x3e8, %rbx            ## imm = 0x3E8
10006bda5: 0f 85 ca f5 ff ff           	jne	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006bdab: eb 0d                       	jmp	0x10006bdba <_PFMoveToApplicationsFolderIfNecessary+0xa9a>
10006bdad: 48 81 fb e8 03 00 00        	cmpq	$0x3e8, %rbx            ## imm = 0x3E8
10006bdb4: 0f 85 d2 01 00 00           	jne	0x10006bf8c <_PFMoveToApplicationsFolderIfNecessary+0xc6c>
10006bdba: 48 8d 3d 67 96 03 00        	leaq	0x39667(%rip), %rdi     ## 0x1000a5428    ; cfstr "INFO -- Moving myself to the Applications folder"
10006bdc1: 31 c0                       	xorl	%eax, %eax
10006bdc3: e8 99 f5 fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006bdc8: 80 bd 00 fe ff ff 00        	cmpb	$0x0, -0x200(%rbp)
10006bdcf: 0f 84 e9 01 00 00           	je	0x10006bfbe <_PFMoveToApplicationsFolderIfNecessary+0xc9e>
10006bdd5: 48 8b 35 74 e0 05 00        	movq	0x5e074(%rip), %rsi     ## 0x1000c9e50    ; sel "hasSuffix:"
10006bddc: 48 8d 15 e5 97 03 00        	leaq	0x397e5(%rip), %rdx     ## 0x1000a55c8    ; cfstr ".app"
10006bde3: 4c 89 f7                    	movq	%r14, %rdi
10006bde6: ff 15 24 15 03 00           	callq	*0x31524(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bdec: 84 c0                       	testb	%al, %al
10006bdee: 0f 84 7e 01 00 00           	je	0x10006bf72 <_PFMoveToApplicationsFolderIfNecessary+0xc52>
10006bdf4: 48 8b 3d 8d f8 05 00        	movq	0x5f88d(%rip), %rdi     ## 0x1000cb688    ; class "NSCharacterSet"
10006bdfb: 48 8b 1d 0e ed 05 00        	movq	0x5ed0e(%rip), %rbx     ## 0x1000cab10    ; sel "whitespaceCharacterSet"
10006be02: 48 89 de                    	movq	%rbx, %rsi
10006be05: 41 ff d5                    	callq	*%r13
10006be08: 4c 8b 3d 69 e5 05 00        	movq	0x5e569(%rip), %r15     ## 0x1000ca378    ; sel "stringByTrimmingCharactersInSet:"
10006be0f: 4c 89 f7                    	movq	%r14, %rdi
10006be12: 4c 89 fe                    	movq	%r15, %rsi
10006be15: 48 89 c2                    	movq	%rax, %rdx
10006be18: 41 ff d5                    	callq	*%r13
10006be1b: 4c 8b 25 56 b6 05 00        	movq	0x5b656(%rip), %r12     ## 0x1000c7478    ; sel "length"
10006be22: 48 89 c7                    	movq	%rax, %rdi
10006be25: 4c 89 e6                    	movq	%r12, %rsi
10006be28: 41 ff d5                    	callq	*%r13
10006be2b: 48 85 c0                    	testq	%rax, %rax
10006be2e: 0f 84 3e 01 00 00           	je	0x10006bf72 <_PFMoveToApplicationsFolderIfNecessary+0xc52>
10006be34: 48 8b 3d 4d f8 05 00        	movq	0x5f84d(%rip), %rdi     ## 0x1000cb688    ; class "NSCharacterSet"
10006be3b: 48 89 de                    	movq	%rbx, %rsi
10006be3e: 41 ff d5                    	callq	*%r13
10006be41: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006be48: 4c 89 fe                    	movq	%r15, %rsi
10006be4b: 48 89 c2                    	movq	%rax, %rdx
10006be4e: 41 ff d5                    	callq	*%r13
10006be51: 48 89 c7                    	movq	%rax, %rdi
10006be54: 4c 89 e6                    	movq	%r12, %rsi
10006be57: 41 ff d5                    	callq	*%r13
10006be5a: 48 85 c0                    	testq	%rax, %rax
10006be5d: 0f 84 0f 01 00 00           	je	0x10006bf72 <_PFMoveToApplicationsFolderIfNecessary+0xc52>
10006be63: 48 8d 8d b0 fd ff ff        	leaq	-0x250(%rbp), %rcx
10006be6a: 31 ff                       	xorl	%edi, %edi
10006be6c: 31 f6                       	xorl	%esi, %esi
10006be6e: 31 d2                       	xorl	%edx, %edx
10006be70: e8 d1 d5 00 00              	callq	0x100079446    ; import "_AuthorizationCreate"
10006be75: 85 c0                       	testl	%eax, %eax
10006be77: 0f 85 f5 00 00 00           	jne	0x10006bf72 <_PFMoveToApplicationsFolderIfNecessary+0xc52>
10006be7d: 0f 10 05 c4 1e 03 00        	movups	0x31ec4(%rip), %xmm0    ## 0x10009dd48 <___block_descriptor_41_e8_32s_e34_v40?0"NSFont"8{_NSRange=QQ}16*32l+0x40>
10006be84: 0f 29 85 e0 fe ff ff        	movaps	%xmm0, -0x120(%rbp)
10006be8b: 66 0f 10 05 a5 1e 03 00     	movupd	0x31ea5(%rip), %xmm0    ## 0x10009dd38 <___block_descriptor_41_e8_32s_e34_v40?0"NSFont"8{_NSRange=QQ}16*32l+0x30>
10006be93: 66 0f 29 85 d0 fe ff ff     	movapd	%xmm0, -0x130(%rbp)
10006be9b: 48 8d b5 70 fd ff ff        	leaq	-0x290(%rbp), %rsi
10006bea2: c7 06 01 00 00 00           	movl	$0x1, (%rsi)
10006bea8: 48 8d 85 d0 fe ff ff        	leaq	-0x130(%rbp), %rax
10006beaf: 48 89 46 08                 	movq	%rax, 0x8(%rsi)
10006beb3: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006beba: 31 d2                       	xorl	%edx, %edx
10006bebc: b9 13 00 00 00              	movl	$0x13, %ecx
10006bec1: 45 31 c0                    	xorl	%r8d, %r8d
10006bec4: e8 77 d5 00 00              	callq	0x100079440    ; import "_AuthorizationCopyRights"
10006bec9: 3d 9a 15 ff ff              	cmpl	$0xffff159a, %eax       ## imm = 0xFFFF159A
10006bece: 0f 84 e3 03 00 00           	je	0x10006c2b7 <_PFMoveToApplicationsFolderIfNecessary+0xf97>
10006bed4: 85 c0                       	testl	%eax, %eax
10006bed6: 0f 85 88 00 00 00           	jne	0x10006bf64 <_PFMoveToApplicationsFolderIfNecessary+0xc44>
10006bedc: 48 83 3d 24 38 06 00 00     	cmpq	$0x0, 0x63824(%rip)     ## 0x1000cf708 <_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges>    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10006bee4: 75 1f                       	jne	0x10006bf05 <_PFMoveToApplicationsFolderIfNecessary+0xbe5>
10006bee6: 48 8d 35 6e a9 02 00        	leaq	0x2a96e(%rip), %rsi     ## 0x10009685b    ; str "AuthorizationExecuteWithPrivileges"
10006beed: 48 c7 c7 fe ff ff ff        	movq	$-0x2, %rdi
10006bef4: e8 05 d8 00 00              	callq	0x1000796fe    ; import "_dlsym"
10006bef9: 48 89 05 08 38 06 00        	movq	%rax, 0x63808(%rip)     ## 0x1000cf708 <_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges>    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10006bf00: 48 85 c0                    	testq	%rax, %rax
10006bf03: 74 5f                       	je	0x10006bf64 <_PFMoveToApplicationsFolderIfNecessary+0xc44>
10006bf05: 48 8d 05 72 a9 02 00        	leaq	0x2a972(%rip), %rax     ## 0x10009687e    ; str "-rf"
10006bf0c: 4c 8d bd 50 ff ff ff        	leaq	-0xb0(%rbp), %r15
10006bf13: 49 89 07                    	movq	%rax, (%r15)
10006bf16: 4c 89 f7                    	movq	%r14, %rdi
10006bf19: 4c 8d 35 25 57 02 00        	leaq	0x25725(%rip), %r14     ## 0x100091645    ; str "--"
10006bf20: 4d 89 77 08                 	movq	%r14, 0x8(%r15)
10006bf24: 48 8b 1d cd be 05 00        	movq	0x5becd(%rip), %rbx     ## 0x1000c7df8    ; sel "fileSystemRepresentation"
10006bf2b: 48 89 de                    	movq	%rbx, %rsi
10006bf2e: ff 15 dc 13 03 00           	callq	*0x313dc(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bf34: 49 89 47 10                 	movq	%rax, 0x10(%r15)
10006bf38: 49 c7 47 18 00 00 00 00     	movq	$0x0, 0x18(%r15)
10006bf40: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006bf47: 48 8d 35 34 a9 02 00        	leaq	0x2a934(%rip), %rsi     ## 0x100096882    ; str "/bin/rm"
10006bf4e: 31 d2                       	xorl	%edx, %edx
10006bf50: 4c 89 f9                    	movq	%r15, %rcx
10006bf53: 45 31 c0                    	xorl	%r8d, %r8d
10006bf56: ff 15 ac 37 06 00           	callq	*0x637ac(%rip)          ## 0x1000cf708 <_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges>    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10006bf5c: 85 c0                       	testl	%eax, %eax
10006bf5e: 0f 84 74 03 00 00           	je	0x10006c2d8 <_PFMoveToApplicationsFolderIfNecessary+0xfb8>
10006bf64: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006bf6b: 31 f6                       	xorl	%esi, %esi
10006bf6d: e8 e0 d4 00 00              	callq	0x100079452    ; import "_AuthorizationFree"
10006bf72: 48 8d 3d ef 94 03 00        	leaq	0x394ef(%rip), %rdi     ## 0x1000a5468    ; cfstr "ERROR -- Could not copy myself to /Applications with authorization"
10006bf79: 31 c0                       	xorl	%eax, %eax
10006bf7b: e8 34 d6 00 00              	callq	0x1000795b4    ; import "_NSLog"
10006bf80: 4c 8b 25 e9 c1 05 00        	movq	0x5c1e9(%rip), %r12     ## 0x1000c8170    ; sel "runModal"
10006bf87: e9 c3 02 00 00              	jmp	0x10006c24f <_PFMoveToApplicationsFolderIfNecessary+0xf2f>
10006bf8c: 48 8b 35 65 b3 05 00        	movq	0x5b365(%rip), %rsi     ## 0x1000c72f8    ; sel "setBool:forKey:"
10006bf93: 48 8d 0d 6e 95 03 00        	leaq	0x3956e(%rip), %rcx     ## 0x1000a5508    ; cfstr "moveToApplicationsFolderAlertSuppress"
10006bf9a: 48 8b 9d 18 fe ff ff        	movq	-0x1e8(%rbp), %rbx
10006bfa1: 48 89 df                    	movq	%rbx, %rdi
10006bfa4: ba 01 00 00 00              	movl	$0x1, %edx
10006bfa9: 41 ff d5                    	callq	*%r13
10006bfac: 48 8b 35 7d e8 05 00        	movq	0x5e87d(%rip), %rsi     ## 0x1000ca830    ; sel "synchronize"
10006bfb3: 48 89 df                    	movq	%rbx, %rdi
10006bfb6: 41 ff d5                    	callq	*%r13
10006bfb9: e9 b7 f3 ff ff              	jmp	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006bfbe: 48 8b 35 73 de 05 00        	movq	0x5de73(%rip), %rsi     ## 0x1000c9e38    ; sel "fileExistsAtPath:"
10006bfc5: 48 8b bd 08 fe ff ff        	movq	-0x1f8(%rbp), %rdi
10006bfcc: 4c 89 f2                    	movq	%r14, %rdx
10006bfcf: ff 15 3b 13 03 00           	callq	*0x3133b(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006bfd5: 84 c0                       	testb	%al, %al
10006bfd7: 0f 84 43 01 00 00           	je	0x10006c120 <_PFMoveToApplicationsFolderIfNecessary+0xe00>
10006bfdd: 66 0f 57 c0                 	xorpd	%xmm0, %xmm0
10006bfe1: 48 8d 9d 30 fd ff ff        	leaq	-0x2d0(%rbp), %rbx
10006bfe8: 66 0f 29 43 30              	movapd	%xmm0, 0x30(%rbx)
10006bfed: 66 0f 29 43 20              	movapd	%xmm0, 0x20(%rbx)
10006bff2: 66 0f 29 43 10              	movapd	%xmm0, 0x10(%rbx)
10006bff7: 66 0f 29 03                 	movapd	%xmm0, (%rbx)
10006bffb: 48 8b 3d ce f5 05 00        	movq	0x5f5ce(%rip), %rdi     ## 0x1000cb5d0    ; class "NSWorkspace"
10006c002: 48 8b 35 5f bb 05 00        	movq	0x5bb5f(%rip), %rsi     ## 0x1000c7b68    ; sel "sharedWorkspace"
10006c009: 41 ff d5                    	callq	*%r13
10006c00c: 48 8b 35 8d ef 05 00        	movq	0x5ef8d(%rip), %rsi     ## 0x1000cafa0    ; sel "runningApplications"
10006c013: 48 89 c7                    	movq	%rax, %rdi
10006c016: 41 ff d5                    	callq	*%r13
10006c019: 48 8d 8d 50 fe ff ff        	leaq	-0x1b0(%rbp), %rcx
10006c020: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006c026: 48 89 85 40 fe ff ff        	movq	%rax, -0x1c0(%rbp)
10006c02d: 48 89 c7                    	movq	%rax, %rdi
10006c030: 48 8b 35 01 b7 05 00        	movq	0x5b701(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006c037: 48 89 da                    	movq	%rbx, %rdx
10006c03a: 41 ff d5                    	callq	*%r13
10006c03d: 48 85 c0                    	testq	%rax, %rax
10006c040: 0f 84 c3 00 00 00           	je	0x10006c109 <_PFMoveToApplicationsFolderIfNecessary+0xde9>
10006c046: 48 89 c3                    	movq	%rax, %rbx
10006c049: 48 8d 85 30 fd ff ff        	leaq	-0x2d0(%rbp), %rax
10006c050: 48 8b 40 10                 	movq	0x10(%rax), %rax
10006c054: 48 8b 00                    	movq	(%rax), %rax
10006c057: 48 89 85 18 fe ff ff        	movq	%rax, -0x1e8(%rbp)
10006c05e: 4c 8b 2d 43 ef 05 00        	movq	0x5ef43(%rip), %r13     ## 0x1000cafa8    ; sel "executableURL"
10006c065: 4c 8b 25 e4 b8 05 00        	movq	0x5b8e4(%rip), %r12     ## 0x1000c7950    ; sel "path"
10006c06c: 45 31 ff                    	xorl	%r15d, %r15d
10006c06f: 48 8b 85 40 fd ff ff        	movq	-0x2c0(%rbp), %rax
10006c076: 48 8b 8d 18 fe ff ff        	movq	-0x1e8(%rbp), %rcx
10006c07d: 48 39 08                    	cmpq	%rcx, (%rax)
10006c080: 74 0c                       	je	0x10006c08e <_PFMoveToApplicationsFolderIfNecessary+0xd6e>
10006c082: 48 8b bd 40 fe ff ff        	movq	-0x1c0(%rbp), %rdi
10006c089: e8 00 d7 00 00              	callq	0x10007978e    ; import "_objc_enumerationMutation"
10006c08e: 48 8b 85 38 fd ff ff        	movq	-0x2c8(%rbp), %rax
10006c095: 4a 8b 3c f8                 	movq	(%rax,%r15,8), %rdi
10006c099: 4c 89 ee                    	movq	%r13, %rsi
10006c09c: 4c 8b 35 6d 12 03 00        	movq	0x3126d(%rip), %r14     ## 0x10009d310    ; import "_objc_msgSend"
10006c0a3: 41 ff d6                    	callq	*%r14
10006c0a6: 48 89 c7                    	movq	%rax, %rdi
10006c0a9: 4c 89 e6                    	movq	%r12, %rsi
10006c0ac: 41 ff d6                    	callq	*%r14
10006c0af: 48 89 c7                    	movq	%rax, %rdi
10006c0b2: 4c 8b b5 38 fe ff ff        	movq	-0x1c8(%rbp), %r14
10006c0b9: 4c 89 f6                    	movq	%r14, %rsi
10006c0bc: e8 20 06 00 00              	callq	0x10006c6e1 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
10006c0c1: 84 c0                       	testb	%al, %al
10006c0c3: 0f 85 b8 02 00 00           	jne	0x10006c381 <_PFMoveToApplicationsFolderIfNecessary+0x1061>
10006c0c9: 49 ff c7                    	incq	%r15
10006c0cc: 4c 39 fb                    	cmpq	%r15, %rbx
10006c0cf: 75 9e                       	jne	0x10006c06f <_PFMoveToApplicationsFolderIfNecessary+0xd4f>
10006c0d1: 41 b8 10 00 00 00           	movl	$0x10, %r8d
10006c0d7: 48 8b bd 40 fe ff ff        	movq	-0x1c0(%rbp), %rdi
10006c0de: 48 8b 35 53 b6 05 00        	movq	0x5b653(%rip), %rsi     ## 0x1000c7738    ; sel "countByEnumeratingWithState:objects:count:"
10006c0e5: 48 8d 95 30 fd ff ff        	leaq	-0x2d0(%rbp), %rdx
10006c0ec: 48 8d 8d 50 fe ff ff        	leaq	-0x1b0(%rbp), %rcx
10006c0f3: 4c 8b 2d 16 12 03 00        	movq	0x31216(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006c0fa: 41 ff d5                    	callq	*%r13
10006c0fd: 48 89 c3                    	movq	%rax, %rbx
10006c100: 48 85 c0                    	testq	%rax, %rax
10006c103: 0f 85 55 ff ff ff           	jne	0x10006c05e <_PFMoveToApplicationsFolderIfNecessary+0xd3e>
10006c109: 4c 89 f7                    	movq	%r14, %rdi
10006c10c: e8 99 06 00 00              	callq	0x10006c7aa <_Trash>    ; call "_Trash"
10006c111: 84 c0                       	testb	%al, %al
10006c113: 4c 8b 25 56 c0 05 00        	movq	0x5c056(%rip), %r12     ## 0x1000c8170    ; sel "runModal"
10006c11a: 0f 84 2f 01 00 00           	je	0x10006c24f <_PFMoveToApplicationsFolderIfNecessary+0xf2f>
10006c120: 48 8b 3d b1 f4 05 00        	movq	0x5f4b1(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006c127: 48 8b 35 7a ba 05 00        	movq	0x5ba7a(%rip), %rsi     ## 0x1000c7ba8    ; sel "defaultManager"
10006c12e: 41 ff d5                    	callq	*%r13
10006c131: 48 89 c3                    	movq	%rax, %rbx
10006c134: 48 8b 35 9d ee 05 00        	movq	0x5ee9d(%rip), %rsi     ## 0x1000cafd8    ; sel "attributesOfFileSystemForPath:error:"
10006c13b: 48 89 c7                    	movq	%rax, %rdi
10006c13e: 4d 89 f7                    	movq	%r14, %r15
10006c141: 4c 8b b5 30 fe ff ff        	movq	-0x1d0(%rbp), %r14
10006c148: 4c 89 f2                    	movq	%r14, %rdx
10006c14b: 31 c9                       	xorl	%ecx, %ecx
10006c14d: 41 ff d5                    	callq	*%r13
10006c150: 48 8b 0d b1 0f 03 00        	movq	0x30fb1(%rip), %rcx     ## 0x10009d108    ; import "_NSFileSystemNumber"
10006c157: 4c 8b 21                    	movq	(%rcx), %r12
10006c15a: 4c 8b 2d 3f b1 05 00        	movq	0x5b13f(%rip), %r13     ## 0x1000c72a0    ; sel "objectForKey:"
10006c161: 48 89 c7                    	movq	%rax, %rdi
10006c164: 4c 89 ee                    	movq	%r13, %rsi
10006c167: 4c 89 e2                    	movq	%r12, %rdx
10006c16a: ff 15 a0 11 03 00           	callq	*0x311a0(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006c170: 48 89 85 18 fe ff ff        	movq	%rax, -0x1e8(%rbp)
10006c177: 48 8b 35 f2 d3 05 00        	movq	0x5d3f2(%rip), %rsi     ## 0x1000c9570    ; sel "stringByDeletingLastPathComponent"
10006c17e: 4c 89 ff                    	movq	%r15, %rdi
10006c181: ff 15 89 11 03 00           	callq	*0x31189(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006c187: 48 89 df                    	movq	%rbx, %rdi
10006c18a: 48 8b 35 47 ee 05 00        	movq	0x5ee47(%rip), %rsi     ## 0x1000cafd8    ; sel "attributesOfFileSystemForPath:error:"
10006c191: 48 89 c2                    	movq	%rax, %rdx
10006c194: 31 c9                       	xorl	%ecx, %ecx
10006c196: ff 15 74 11 03 00           	callq	*0x31174(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006c19c: 48 89 c7                    	movq	%rax, %rdi
10006c19f: 4c 89 ee                    	movq	%r13, %rsi
10006c1a2: 4c 8b 2d 67 11 03 00        	movq	0x31167(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006c1a9: 4c 89 e2                    	movq	%r12, %rdx
10006c1ac: 41 ff d5                    	callq	*%r13
10006c1af: 48 8b 35 12 d2 05 00        	movq	0x5d212(%rip), %rsi     ## 0x1000c93c8    ; sel "isEqual:"
10006c1b6: 48 8b bd 18 fe ff ff        	movq	-0x1e8(%rbp), %rdi
10006c1bd: 48 89 c2                    	movq	%rax, %rdx
10006c1c0: 41 ff d5                    	callq	*%r13
10006c1c3: 84 c0                       	testb	%al, %al
10006c1c5: 74 49                       	je	0x10006c210 <_PFMoveToApplicationsFolderIfNecessary+0xef0>
10006c1c7: 4c 8d 85 50 ff ff ff        	leaq	-0xb0(%rbp), %r8
10006c1ce: 49 c7 00 00 00 00 00        	movq	$0x0, (%r8)
10006c1d5: 48 8b 35 04 ee 05 00        	movq	0x5ee04(%rip), %rsi     ## 0x1000cafe0    ; sel "moveItemAtPath:toPath:error:"
10006c1dc: 48 89 df                    	movq	%rbx, %rdi
10006c1df: 4c 89 f2                    	movq	%r14, %rdx
10006c1e2: 4c 89 f9                    	movq	%r15, %rcx
10006c1e5: ff 15 25 11 03 00           	callq	*0x31125(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006c1eb: 84 c0                       	testb	%al, %al
10006c1ed: 0f 85 d2 01 00 00           	jne	0x10006c3c5 <_PFMoveToApplicationsFolderIfNecessary+0x10a5>
10006c1f3: 48 8b 8d 50 ff ff ff        	movq	-0xb0(%rbp), %rcx
10006c1fa: 48 8d 3d 27 94 03 00        	leaq	0x39427(%rip), %rdi     ## 0x1000a5628    ; cfstr "WARNING -- Could not move '%@' to '%@' (%@)"
10006c201: 4c 89 f6                    	movq	%r14, %rsi
10006c204: 4c 89 fa                    	movq	%r15, %rdx
10006c207: 31 c0                       	xorl	%eax, %eax
10006c209: e8 53 f1 fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006c20e: eb 14                       	jmp	0x10006c224 <_PFMoveToApplicationsFolderIfNecessary+0xf04>
10006c210: 48 8d 3d f1 93 03 00        	leaq	0x393f1(%rip), %rdi     ## 0x1000a5608    ; cfstr "INFO -- Not moving '%@' to '%@' on different file system"
10006c217: 4c 89 f6                    	movq	%r14, %rsi
10006c21a: 4c 89 fa                    	movq	%r15, %rdx
10006c21d: 31 c0                       	xorl	%eax, %eax
10006c21f: e8 3d f1 fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006c224: 4c 8b 25 45 bf 05 00        	movq	0x5bf45(%rip), %r12     ## 0x1000c8170    ; sel "runModal"
10006c22b: 4c 89 f7                    	movq	%r14, %rdi
10006c22e: 4c 89 fe                    	movq	%r15, %rsi
10006c231: e8 36 06 00 00              	callq	0x10006c86c <_CopyBundle>    ; call "_CopyBundle"
10006c236: 84 c0                       	testb	%al, %al
10006c238: 0f 85 83 01 00 00           	jne	0x10006c3c1 <_PFMoveToApplicationsFolderIfNecessary+0x10a1>
10006c23e: 48 8d 3d 63 92 03 00        	leaq	0x39263(%rip), %rdi     ## 0x1000a54a8    ; cfstr "ERROR -- Could not copy myself to %@"
10006c245: 4c 89 fe                    	movq	%r15, %rsi
10006c248: 31 c0                       	xorl	%eax, %eax
10006c24a: e8 65 d3 00 00              	callq	0x1000795b4    ; import "_NSLog"
10006c24f: 48 8b 3d aa f3 05 00        	movq	0x5f3aa(%rip), %rdi     ## 0x1000cb600    ; class "NSAlert"
10006c256: e8 fd d4 00 00              	callq	0x100079758    ; import "_objc_alloc_init"
10006c25b: 48 89 c7                    	movq	%rax, %rdi
10006c25e: e8 fb d4 00 00              	callq	0x10007975e    ; import "_objc_autorelease"
10006c263: 48 89 c3                    	movq	%rax, %rbx
10006c266: 48 8b 3d 13 f3 05 00        	movq	0x5f313(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006c26d: 48 8b 35 a4 b6 05 00        	movq	0x5b6a4(%rip), %rsi     ## 0x1000c7918    ; sel "mainBundle"
10006c274: 41 ff d5                    	callq	*%r13
10006c277: 48 8d 15 6a 92 03 00        	leaq	0x3926a(%rip), %rdx     ## 0x1000a54e8    ; cfstr "Could not move to Applications folder"
10006c27e: 48 8d 0d e3 1b 03 00        	leaq	0x31be3(%rip), %rcx     ## 0x10009de68    ; cfstr ""
10006c285: 4c 8d 05 9c 90 03 00        	leaq	0x3909c(%rip), %r8      ## 0x1000a5328    ; cfstr "MoveApplication"
10006c28c: 48 89 c7                    	movq	%rax, %rdi
10006c28f: 48 8b 35 8a b6 05 00        	movq	0x5b68a(%rip), %rsi     ## 0x1000c7920    ; sel "localizedStringForKey:value:table:"
10006c296: 41 ff d5                    	callq	*%r13
10006c299: 48 89 df                    	movq	%rbx, %rdi
10006c29c: 48 8b 35 9d ba 05 00        	movq	0x5ba9d(%rip), %rsi     ## 0x1000c7d40    ; sel "setMessageText:"
10006c2a3: 48 89 c2                    	movq	%rax, %rdx
10006c2a6: 41 ff d5                    	callq	*%r13
10006c2a9: 48 89 df                    	movq	%rbx, %rdi
10006c2ac: 4c 89 e6                    	movq	%r12, %rsi
10006c2af: 41 ff d5                    	callq	*%r13
10006c2b2: e9 be f0 ff ff              	jmp	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006c2b7: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006c2be: 31 f6                       	xorl	%esi, %esi
10006c2c0: e8 8d d1 00 00              	callq	0x100079452    ; import "_AuthorizationFree"
10006c2c5: 48 8d 3d 7c 91 03 00        	leaq	0x3917c(%rip), %rdi     ## 0x1000a5448    ; cfstr "INFO -- Not moving because user canceled authorization"
10006c2cc: 31 c0                       	xorl	%eax, %eax
10006c2ce: e8 8e f0 fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006c2d3: e9 9d f0 ff ff              	jmp	0x10006b375 <_PFMoveToApplicationsFolderIfNecessary+0x55>
10006c2d8: 48 8d bd 24 fe ff ff        	leaq	-0x1dc(%rbp), %rdi
10006c2df: e8 a6 d5 00 00              	callq	0x10007988a    ; import "_wait"
10006c2e4: 83 f8 ff                    	cmpl	$-0x1, %eax
10006c2e7: 0f 84 77 fc ff ff           	je	0x10006bf64 <_PFMoveToApplicationsFolderIfNecessary+0xc44>
10006c2ed: f6 85 24 fe ff ff 7f        	testb	$0x7f, -0x1dc(%rbp)
10006c2f4: 0f 85 6a fc ff ff           	jne	0x10006bf64 <_PFMoveToApplicationsFolderIfNecessary+0xc44>
10006c2fa: 48 8d 05 ac 94 02 00        	leaq	0x294ac(%rip), %rax     ## 0x1000957ad    ; str "--noqtn"
10006c301: 49 89 07                    	movq	%rax, (%r15)
10006c304: 4d 89 77 08                 	movq	%r14, 0x8(%r15)
10006c308: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006c30f: 48 89 de                    	movq	%rbx, %rsi
10006c312: 41 ff d5                    	callq	*%r13
10006c315: 49 89 47 10                 	movq	%rax, 0x10(%r15)
10006c319: 48 8b bd 38 fe ff ff        	movq	-0x1c8(%rbp), %rdi
10006c320: 48 89 de                    	movq	%rbx, %rsi
10006c323: 41 ff d5                    	callq	*%r13
10006c326: 49 89 47 18                 	movq	%rax, 0x18(%r15)
10006c32a: 49 c7 47 20 00 00 00 00     	movq	$0x0, 0x20(%r15)
10006c332: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006c339: 48 8d 35 5b 94 02 00        	leaq	0x2945b(%rip), %rsi     ## 0x10009579b    ; str "/usr/bin/ditto"
10006c340: 31 d2                       	xorl	%edx, %edx
10006c342: 4c 89 f9                    	movq	%r15, %rcx
10006c345: 45 31 c0                    	xorl	%r8d, %r8d
10006c348: ff 15 ba 33 06 00           	callq	*0x633ba(%rip)          ## 0x1000cf708 <_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges>    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10006c34e: 85 c0                       	testl	%eax, %eax
10006c350: 75 23                       	jne	0x10006c375 <_PFMoveToApplicationsFolderIfNecessary+0x1055>
10006c352: 48 8d bd 24 fe ff ff        	leaq	-0x1dc(%rbp), %rdi
10006c359: e8 2c d5 00 00              	callq	0x10007988a    ; import "_wait"
10006c35e: 83 f8 ff                    	cmpl	$-0x1, %eax
10006c361: 74 12                       	je	0x10006c375 <_PFMoveToApplicationsFolderIfNecessary+0x1055>
10006c363: 0f b7 85 24 fe ff ff        	movzwl	-0x1dc(%rbp), %eax
10006c36a: a9 7f ff 00 00              	testl	$0xff7f, %eax           ## imm = 0xFF7F
10006c36f: 0f 84 e6 01 00 00           	je	0x10006c55b <_PFMoveToApplicationsFolderIfNecessary+0x123b>
10006c375: 4c 8b 2d 94 0f 03 00        	movq	0x30f94(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006c37c: e9 e3 fb ff ff              	jmp	0x10006bf64 <_PFMoveToApplicationsFolderIfNecessary+0xc44>
10006c381: 48 8d 3d 00 91 03 00        	leaq	0x39100(%rip), %rdi     ## 0x1000a5488    ; cfstr "INFO -- Switching to an already running version"
10006c388: 31 c0                       	xorl	%eax, %eax
10006c38a: e8 d2 ef fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006c38f: 48 8b 3d 3a f2 05 00        	movq	0x5f23a(%rip), %rdi     ## 0x1000cb5d0    ; class "NSWorkspace"
10006c396: 48 8b 35 cb b7 05 00        	movq	0x5b7cb(%rip), %rsi     ## 0x1000c7b68    ; sel "sharedWorkspace"
10006c39d: 48 8b 1d 6c 0f 03 00        	movq	0x30f6c(%rip), %rbx     ## 0x10009d310    ; import "_objc_msgSend"
10006c3a4: ff d3                       	callq	*%rbx
10006c3a6: 48 8b 35 cb ba 05 00        	movq	0x5bacb(%rip), %rsi     ## 0x1000c7e78    ; sel "openFile:"
10006c3ad: 48 89 c7                    	movq	%rax, %rdi
10006c3b0: 4c 89 f2                    	movq	%r14, %rdx
10006c3b3: ff d3                       	callq	*%rbx
10006c3b5: 31 ff                       	xorl	%edi, %edi
10006c3b7: e8 48 d3 00 00              	callq	0x100079704    ; import "_exit"
10006c3bc: e8 c5 d2 00 00              	callq	0x100079686    ; import "___stack_chk_fail"
10006c3c1: 31 db                       	xorl	%ebx, %ebx
10006c3c3: eb 02                       	jmp	0x10006c3c7 <_PFMoveToApplicationsFolderIfNecessary+0x10a7>
10006c3c5: b3 01                       	movb	$0x1, %bl
10006c3c7: 48 8b 3d 0a f2 05 00        	movq	0x5f20a(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006c3ce: 48 8b 35 d3 b7 05 00        	movq	0x5b7d3(%rip), %rsi     ## 0x1000c7ba8    ; sel "defaultManager"
10006c3d5: 4c 8b 35 34 0f 03 00        	movq	0x30f34(%rip), %r14     ## 0x10009d310    ; import "_objc_msgSend"
10006c3dc: 41 ff d6                    	callq	*%r14
10006c3df: 48 8b 35 ca eb 05 00        	movq	0x5ebca(%rip), %rsi     ## 0x1000cafb0    ; sel "clearQuarantine:"
10006c3e6: 48 89 c7                    	movq	%rax, %rdi
10006c3e9: 48 8b 95 38 fe ff ff        	movq	-0x1c8(%rbp), %rdx
10006c3f0: 41 ff d6                    	callq	*%r14
10006c3f3: 84 db                       	testb	%bl, %bl
10006c3f5: 75 27                       	jne	0x10006c41e <_PFMoveToApplicationsFolderIfNecessary+0x10fe>
10006c3f7: 80 bd 4f fe ff ff 00        	cmpb	$0x0, -0x1b1(%rbp)
10006c3fe: 75 1e                       	jne	0x10006c41e <_PFMoveToApplicationsFolderIfNecessary+0x10fe>
10006c400: 48 8b bd 30 fe ff ff        	movq	-0x1d0(%rbp), %rdi
10006c407: e8 9e 03 00 00              	callq	0x10006c7aa <_Trash>    ; call "_Trash"
10006c40c: 84 c0                       	testb	%al, %al
10006c40e: 75 0e                       	jne	0x10006c41e <_PFMoveToApplicationsFolderIfNecessary+0x10fe>
10006c410: 48 8d 3d b1 90 03 00        	leaq	0x390b1(%rip), %rdi     ## 0x1000a54c8    ; cfstr "WARNING -- Could not delete application after moving it to Applications folder"
10006c417: 31 c0                       	xorl	%eax, %eax
10006c419: e8 43 ef fd ff              	callq	0x10004b361 <_CXLog>    ; call "_CXLog"
10006c41e: 48 8b 3d 13 f2 05 00        	movq	0x5f213(%rip), %rdi     ## 0x1000cb638    ; class "NSProcessInfo"
10006c425: 48 8b 35 64 ba 05 00        	movq	0x5ba64(%rip), %rsi     ## 0x1000c7e90    ; sel "processInfo"
10006c42c: 48 8b 1d dd 0e 03 00        	movq	0x30edd(%rip), %rbx     ## 0x10009d310    ; import "_objc_msgSend"
10006c433: ff d3                       	callq	*%rbx
10006c435: 48 8b 35 ac eb 05 00        	movq	0x5ebac(%rip), %rsi     ## 0x1000cafe8    ; sel "processIdentifier"
10006c43c: 48 89 c7                    	movq	%rax, %rdi
10006c43f: ff d3                       	callq	*%rbx
10006c441: 41 89 c7                    	movl	%eax, %r15d
10006c444: 4c 8b 25 75 f1 05 00        	movq	0x5f175(%rip), %r12     ## 0x1000cb5c0    ; class "NSString"
10006c44b: 4c 8b 35 56 ba 05 00        	movq	0x5ba56(%rip), %r14     ## 0x1000c7ea8    ; sel "stringQuotedForBash"
10006c452: 48 8b bd 38 fe ff ff        	movq	-0x1c8(%rbp), %rdi
10006c459: 4c 89 f6                    	movq	%r14, %rsi
10006c45c: ff d3                       	callq	*%rbx
10006c45e: 48 8b 35 c3 b5 05 00        	movq	0x5b5c3(%rip), %rsi     ## 0x1000c7a28    ; sel "stringWithFormat:"
10006c465: 48 8d 15 dc 91 03 00        	leaq	0x391dc(%rip), %rdx     ## 0x1000a5648    ; cfstr "(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &"
10006c46c: 4c 89 e7                    	movq	%r12, %rdi
10006c46f: 44 89 f9                    	movl	%r15d, %ecx
10006c472: 49 89 c0                    	movq	%rax, %r8
10006c475: 31 c0                       	xorl	%eax, %eax
10006c477: ff d3                       	callq	*%rbx
10006c479: 4c 8b 2d c8 f3 05 00        	movq	0x5f3c8(%rip), %r13     ## 0x1000cb848    ; class "NSTask"
10006c480: 48 8b 3d 01 f1 05 00        	movq	0x5f101(%rip), %rdi     ## 0x1000cb588    ; class "NSArray"
10006c487: 4c 8b 3d 9a bb 05 00        	movq	0x5bb9a(%rip), %r15     ## 0x1000c8028    ; sel "arrayWithObjects:"
10006c48e: 48 8d 15 33 31 03 00        	leaq	0x33133(%rip), %rdx     ## 0x10009f5c8    ; cfstr "-c"
10006c495: 4c 89 fe                    	movq	%r15, %rsi
10006c498: 48 89 c1                    	movq	%rax, %rcx
10006c49b: 45 31 c0                    	xorl	%r8d, %r8d
10006c49e: 31 c0                       	xorl	%eax, %eax
10006c4a0: ff d3                       	callq	*%rbx
10006c4a2: 4c 8b 25 af c2 05 00        	movq	0x5c2af(%rip), %r12     ## 0x1000c8758    ; sel "launchedTaskWithLaunchPath:arguments:"
10006c4a9: 48 8d 15 f8 30 03 00        	leaq	0x330f8(%rip), %rdx     ## 0x10009f5a8    ; cfstr "/bin/sh"
10006c4b0: 4c 89 ef                    	movq	%r13, %rdi
10006c4b3: 4c 89 e6                    	movq	%r12, %rsi
10006c4b6: 48 89 c1                    	movq	%rax, %rcx
10006c4b9: ff d3                       	callq	*%rbx
10006c4bb: 48 8d bd 50 ff ff ff        	leaq	-0xb0(%rbp), %rdi
10006c4c2: e8 a9 00 00 00              	callq	0x10006c570 <_IsLaunchedFromDMG>    ; call "_IsLaunchedFromDMG"
10006c4c7: 84 c0                       	testb	%al, %al
10006c4c9: 0f 84 e6 fe ff ff           	je	0x10006c3b5 <_PFMoveToApplicationsFolderIfNecessary+0x1095>
10006c4cf: 48 8b bd 50 ff ff ff        	movq	-0xb0(%rbp), %rdi
10006c4d6: 48 8b 35 9b af 05 00        	movq	0x5af9b(%rip), %rsi     ## 0x1000c7478    ; sel "length"
10006c4dd: ff 15 2d 0e 03 00           	callq	*0x30e2d(%rip)          ## 0x10009d310    ; import "_objc_msgSend"
10006c4e3: 48 85 c0                    	testq	%rax, %rax
10006c4e6: 0f 84 c9 fe ff ff           	je	0x10006c3b5 <_PFMoveToApplicationsFolderIfNecessary+0x1095>
10006c4ec: 4c 8b 2d cd f0 05 00        	movq	0x5f0cd(%rip), %r13     ## 0x1000cb5c0    ; class "NSString"
10006c4f3: 48 8b bd 50 ff ff ff        	movq	-0xb0(%rbp), %rdi
10006c4fa: 4c 89 f6                    	movq	%r14, %rsi
10006c4fd: 4c 8b 35 0c 0e 03 00        	movq	0x30e0c(%rip), %r14     ## 0x10009d310    ; import "_objc_msgSend"
10006c504: 41 ff d6                    	callq	*%r14
10006c507: 48 8d 15 5a 91 03 00        	leaq	0x3915a(%rip), %rdx     ## 0x1000a5668    ; cfstr "(sleep 5 && hdiutil detach %@) &"
10006c50e: 4c 89 ef                    	movq	%r13, %rdi
10006c511: 48 8b 35 10 b5 05 00        	movq	0x5b510(%rip), %rsi     ## 0x1000c7a28    ; sel "stringWithFormat:"
10006c518: 48 89 c1                    	movq	%rax, %rcx
10006c51b: 31 c0                       	xorl	%eax, %eax
10006c51d: 41 ff d6                    	callq	*%r14
10006c520: 48 8b 1d 21 f3 05 00        	movq	0x5f321(%rip), %rbx     ## 0x1000cb848    ; class "NSTask"
10006c527: 48 8b 3d 5a f0 05 00        	movq	0x5f05a(%rip), %rdi     ## 0x1000cb588    ; class "NSArray"
10006c52e: 48 8d 15 93 30 03 00        	leaq	0x33093(%rip), %rdx     ## 0x10009f5c8    ; cfstr "-c"
10006c535: 4c 89 fe                    	movq	%r15, %rsi
10006c538: 48 89 c1                    	movq	%rax, %rcx
10006c53b: 45 31 c0                    	xorl	%r8d, %r8d
10006c53e: 31 c0                       	xorl	%eax, %eax
10006c540: 41 ff d6                    	callq	*%r14
10006c543: 48 8d 15 5e 30 03 00        	leaq	0x3305e(%rip), %rdx     ## 0x10009f5a8    ; cfstr "/bin/sh"
10006c54a: 48 89 df                    	movq	%rbx, %rdi
10006c54d: 4c 89 e6                    	movq	%r12, %rsi
10006c550: 48 89 c1                    	movq	%rax, %rcx
10006c553: 41 ff d6                    	callq	*%r14
10006c556: e9 5a fe ff ff              	jmp	0x10006c3b5 <_PFMoveToApplicationsFolderIfNecessary+0x1095>
10006c55b: 48 8b bd b0 fd ff ff        	movq	-0x250(%rbp), %rdi
10006c562: 31 db                       	xorl	%ebx, %ebx
10006c564: 31 f6                       	xorl	%esi, %esi
10006c566: e8 e7 ce 00 00              	callq	0x100079452    ; import "_AuthorizationFree"
10006c56b: e9 83 fe ff ff              	jmp	0x10006c3f3 <_PFMoveToApplicationsFolderIfNecessary+0x10d3>


000000010006c570 <_IsLaunchedFromDMG>:
10006c570: 55                          	pushq	%rbp
10006c571: 48 89 e5                    	movq	%rsp, %rbp
10006c574: 41 57                       	pushq	%r15
10006c576: 41 56                       	pushq	%r14
10006c578: 41 55                       	pushq	%r13
10006c57a: 41 54                       	pushq	%r12
10006c57c: 53                          	pushq	%rbx
10006c57d: 48 81 ec 88 08 00 00        	subq	$0x888, %rsp            ## imm = 0x888
10006c584: 48 89 fb                    	movq	%rdi, %rbx
10006c587: 48 8b 05 02 0d 03 00        	movq	0x30d02(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
10006c58e: 48 8b 00                    	movq	(%rax), %rax
10006c591: 48 89 45 d0                 	movq	%rax, -0x30(%rbp)
10006c595: 48 8b 3d e4 ef 05 00        	movq	0x5efe4(%rip), %rdi     ## 0x1000cb580    ; class "NSBundle"
10006c59c: 48 8b 35 75 b3 05 00        	movq	0x5b375(%rip), %rsi     ## 0x1000c7918    ; sel "mainBundle"
10006c5a3: 4c 8b 2d 66 0d 03 00        	movq	0x30d66(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006c5aa: 41 ff d5                    	callq	*%r13
10006c5ad: 48 8b 35 34 bf 05 00        	movq	0x5bf34(%rip), %rsi     ## 0x1000c84e8    ; sel "bundlePath"
10006c5b4: 48 89 c7                    	movq	%rax, %rdi
10006c5b7: 41 ff d5                    	callq	*%r13
10006c5ba: 48 8b 35 37 b8 05 00        	movq	0x5b837(%rip), %rsi     ## 0x1000c7df8    ; sel "fileSystemRepresentation"
10006c5c1: 48 89 c7                    	movq	%rax, %rdi
10006c5c4: 41 ff d5                    	callq	*%r13
10006c5c7: 48 8d b5 58 f7 ff ff        	leaq	-0x8a8(%rbp), %rsi
10006c5ce: 48 89 c7                    	movq	%rax, %rdi
10006c5d1: e8 90 d2 00 00              	callq	0x100079866    ; import "_statfs$INODE64"
10006c5d6: 85 c0                       	testl	%eax, %eax
10006c5d8: 74 2d                       	je	0x10006c607 <_IsLaunchedFromDMG+0x97>
10006c5da: 45 31 f6                    	xorl	%r14d, %r14d
10006c5dd: 48 8b 05 ac 0c 03 00        	movq	0x30cac(%rip), %rax     ## 0x10009d290    ; import "___stack_chk_guard"
10006c5e4: 48 8b 00                    	movq	(%rax), %rax
10006c5e7: 48 3b 45 d0                 	cmpq	-0x30(%rbp), %rax
10006c5eb: 0f 85 eb 00 00 00           	jne	0x10006c6dc <_IsLaunchedFromDMG+0x16c>
10006c5f1: 41 0f be c6                 	movsbl	%r14b, %eax
10006c5f5: 48 81 c4 88 08 00 00        	addq	$0x888, %rsp            ## imm = 0x888
10006c5fc: 5b                          	popq	%rbx
10006c5fd: 41 5c                       	popq	%r12
10006c5ff: 41 5d                       	popq	%r13
10006c601: 41 5e                       	popq	%r14
10006c603: 41 5f                       	popq	%r15
10006c605: 5d                          	popq	%rbp
10006c606: c3                          	retq
10006c607: 45 31 f6                    	xorl	%r14d, %r14d
10006c60a: 31 ff                       	xorl	%edi, %edi
10006c60c: e8 fb ce 00 00              	callq	0x10007950c    ; import "_DASessionCreate"
10006c611: 48 85 c0                    	testq	%rax, %rax
10006c614: 74 c7                       	je	0x10006c5dd <_IsLaunchedFromDMG+0x6d>
10006c616: 49 89 c7                    	movq	%rax, %r15
10006c619: 48 8d 95 b0 fb ff ff        	leaq	-0x450(%rbp), %rdx
10006c620: 45 31 f6                    	xorl	%r14d, %r14d
10006c623: 31 ff                       	xorl	%edi, %edi
10006c625: 48 89 c6                    	movq	%rax, %rsi
10006c628: e8 d9 ce 00 00              	callq	0x100079506    ; import "_DADiskCreateFromBSDName"
10006c62d: 49 89 c4                    	movq	%rax, %r12
10006c630: 4c 89 ff                    	movq	%r15, %rdi
10006c633: e8 62 ce 00 00              	callq	0x10007949a    ; import "_CFRelease"
10006c638: 4d 85 e4                    	testq	%r12, %r12
10006c63b: 74 a0                       	je	0x10006c5dd <_IsLaunchedFromDMG+0x6d>
10006c63d: 4c 89 e7                    	movq	%r12, %rdi
10006c640: e8 bb ce 00 00              	callq	0x100079500    ; import "_DADiskCopyDescription"
10006c645: 49 89 c7                    	movq	%rax, %r15
10006c648: 4c 89 e7                    	movq	%r12, %rdi
10006c64b: e8 4a ce 00 00              	callq	0x10007949a    ; import "_CFRelease"
10006c650: 4d 85 ff                    	testq	%r15, %r15
10006c653: 74 85                       	je	0x10006c5da <_IsLaunchedFromDMG+0x6a>
10006c655: 48 8b 05 6c 0c 03 00        	movq	0x30c6c(%rip), %rax     ## 0x10009d2c8    ; import "_kDADiskDescriptionDeviceModelKey"
10006c65c: 48 8b 10                    	movq	(%rax), %rdx
10006c65f: 48 8b 35 3a ac 05 00        	movq	0x5ac3a(%rip), %rsi     ## 0x1000c72a0    ; sel "objectForKey:"
10006c666: 4c 89 ff                    	movq	%r15, %rdi
10006c669: 41 ff d5                    	callq	*%r13
10006c66c: 48 8b 35 ed b0 05 00        	movq	0x5b0ed(%rip), %rsi     ## 0x1000c7760    ; sel "isEqualToString:"
10006c673: 48 8d 15 0e 8f 03 00        	leaq	0x38f0e(%rip), %rdx     ## 0x1000a5588    ; cfstr "Disk Image"
10006c67a: 48 89 c7                    	movq	%rax, %rdi
10006c67d: 41 ff d5                    	callq	*%r13
10006c680: 41 89 c6                    	movl	%eax, %r14d
10006c683: 4c 89 ff                    	movq	%r15, %rdi
10006c686: ff 15 8c 0c 03 00           	callq	*0x30c8c(%rip)          ## 0x10009d318    ; import "_objc_release"
10006c68c: 48 85 db                    	testq	%rbx, %rbx
10006c68f: 0f 84 48 ff ff ff           	je	0x10006c5dd <_IsLaunchedFromDMG+0x6d>
10006c695: 45 84 f6                    	testb	%r14b, %r14b
10006c698: 0f 84 3f ff ff ff           	je	0x10006c5dd <_IsLaunchedFromDMG+0x6d>
10006c69e: 48 8b 3d 33 ef 05 00        	movq	0x5ef33(%rip), %rdi     ## 0x1000cb5d8    ; class "NSFileManager"
10006c6a5: 48 8b 35 fc b4 05 00        	movq	0x5b4fc(%rip), %rsi     ## 0x1000c7ba8    ; sel "defaultManager"
10006c6ac: 41 ff d5                    	callq	*%r13
10006c6af: 49 89 c7                    	movq	%rax, %r15
10006c6b2: 4c 8d a5 b0 f7 ff ff        	leaq	-0x850(%rbp), %r12
10006c6b9: 4c 89 e7                    	movq	%r12, %rdi
10006c6bc: e8 b1 d1 00 00              	callq	0x100079872    ; import "_strlen"
10006c6c1: 48 8b 35 50 d3 05 00        	movq	0x5d350(%rip), %rsi     ## 0x1000c9a18    ; sel "stringWithFileSystemRepresentation:length:"
10006c6c8: 4c 89 ff                    	movq	%r15, %rdi
10006c6cb: 4c 89 e2                    	movq	%r12, %rdx
10006c6ce: 48 89 c1                    	movq	%rax, %rcx
10006c6d1: 41 ff d5                    	callq	*%r13
10006c6d4: 48 89 03                    	movq	%rax, (%rbx)
10006c6d7: e9 01 ff ff ff              	jmp	0x10006c5dd <_IsLaunchedFromDMG+0x6d>
10006c6dc: e8 a5 cf 00 00              	callq	0x100079686    ; import "___stack_chk_fail"


000000010006c86c <_CopyBundle>:
10006c86c: 55                          	pushq	%rbp
10006c86d: 48 89 e5                    	movq	%rsp, %rbp
10006c870: 41 57                       	pushq	%r15
10006c872: 41 56                       	pushq	%r14
10006c874: 41 55                       	pushq	%r13
10006c876: 41 54                       	pushq	%r12
10006c878: 53                          	pushq	%rbx
10006c879: 50                          	pushq	%rax
10006c87a: 48 89 f3                    	movq	%rsi, %rbx
10006c87d: 49 89 fe                    	movq	%rdi, %r14
10006c880: 4c 8b 3d 71 b5 05 00        	movq	0x5b571(%rip), %r15     ## 0x1000c7df8    ; sel "fileSystemRepresentation"
10006c887: 4c 8b 2d 82 0a 03 00        	movq	0x30a82(%rip), %r13     ## 0x10009d310    ; import "_objc_msgSend"
10006c88e: 4c 89 fe                    	movq	%r15, %rsi
10006c891: 41 ff d5                    	callq	*%r13
10006c894: 49 89 c4                    	movq	%rax, %r12
10006c897: 48 8b 35 d2 cc 05 00        	movq	0x5ccd2(%rip), %rsi     ## 0x1000c9570    ; sel "stringByDeletingLastPathComponent"
10006c89e: 48 89 df                    	movq	%rbx, %rdi
10006c8a1: 41 ff d5                    	callq	*%r13
10006c8a4: 48 89 c7                    	movq	%rax, %rdi
10006c8a7: 4c 89 fe                    	movq	%r15, %rsi
10006c8aa: 41 ff d5                    	callq	*%r13
10006c8ad: 49 89 c7                    	movq	%rax, %r15
10006c8b0: 48 8b 35 59 b7 05 00        	movq	0x5b759(%rip), %rsi     ## 0x1000c8010    ; sel "lastPathComponent"
10006c8b7: 48 89 df                    	movq	%rbx, %rdi
10006c8ba: 41 ff d5                    	callq	*%r13
10006c8bd: 4c 89 e7                    	movq	%r12, %rdi
10006c8c0: 4c 89 fe                    	movq	%r15, %rsi
10006c8c3: 48 89 c2                    	movq	%rax, %rdx
10006c8c6: 31 c9                       	xorl	%ecx, %ecx
10006c8c8: 45 31 c0                    	xorl	%r8d, %r8d
10006c8cb: e8 66 cc 00 00              	callq	0x100079536    ; import "_FSPathCopyObjectSync"
10006c8d0: 41 89 c7                    	movl	%eax, %r15d
10006c8d3: 85 c0                       	testl	%eax, %eax
10006c8d5: 74 17                       	je	0x10006c8ee <_CopyBundle+0x82>
10006c8d7: 48 8d 3d 0a 8d 03 00        	leaq	0x38d0a(%rip), %rdi     ## 0x1000a55e8    ; cfstr "ERROR -- Could not copy '%@' to '%@' (%d)"
10006c8de: 4c 89 f6                    	movq	%r14, %rsi
10006c8e1: 48 89 da                    	movq	%rbx, %rdx
10006c8e4: 44 89 f9                    	movl	%r15d, %ecx
10006c8e7: 31 c0                       	xorl	%eax, %eax
10006c8e9: e8 c6 cc 00 00              	callq	0x1000795b4    ; import "_NSLog"
10006c8ee: 31 c0                       	xorl	%eax, %eax
10006c8f0: 45 85 ff                    	testl	%r15d, %r15d
10006c8f3: 0f 94 c0                    	sete	%al
10006c8f6: 48 83 c4 08                 	addq	$0x8, %rsp
10006c8fa: 5b                          	popq	%rbx
10006c8fb: 41 5c                       	popq	%r12
10006c8fd: 41 5d                       	popq	%r13
10006c8ff: 41 5e                       	popq	%r14
10006c901: 41 5f                       	popq	%r15
10006c903: 5d                          	popq	%rbp
10006c904: c3                          	retq


; ===== arm64 =====

0000000100012edc <-[CXServer rosettaCheck]>:
100012edc: d10103ff    	sub	sp, sp, #0x40
100012ee0: a90157f6    	stp	x22, x21, [sp, #0x10]
100012ee4: a9024ff4    	stp	x20, x19, [sp, #0x20]
100012ee8: a9037bfd    	stp	x29, x30, [sp, #0x30]
100012eec: 9100c3fd    	add	x29, sp, #0x30
100012ef0: 52800020    	mov	w0, #0x1                ; =1
100012ef4: 52800161    	mov	w1, #0xb                ; =11
100012ef8: 52800002    	mov	w2, #0x0                ; =0
100012efc: 52800003    	mov	w3, #0x0                ; =0
100012f00: 94014697    	bl	0x10006495c <___isPlatformVersionAtLeast>    ; call "___isPlatformVersionAtLeast"
100012f04: 34000200    	cbz	w0, 0x100012f44 <-[CXServer rosettaCheck]+0x68>
100012f08: 528000e0    	mov	w0, #0x7                ; =7
100012f0c: 72a02000    	movk	w0, #0x100, lsl #16
100012f10: 9401487c    	bl	0x100065100    ; import "_CFBundleIsArchitectureLoadable"
100012f14: aa0003f3    	mov	x19, x0
100012f18: b0000408    	adrp	x8, 0x100093000
100012f1c: 911ed108    	add	x8, x8, #0x7b4    ; str "installed"
100012f20: b0000409    	adrp	x9, 0x100093000
100012f24: 911ef929    	add	x9, x9, #0x7be    ; str "not installed"
100012f28: 7100001f    	cmp	w0, #0x0
100012f2c: 9a880128    	csel	x8, x9, x8, eq
100012f30: f90003e8    	str	x8, [sp]
100012f34: 90000480    	adrp	x0, 0x1000a2000
100012f38: 91146000    	add	x0, x0, #0x518    ; cfstr "Running as ARM64: Rosetta is %s.\n"
100012f3c: 9400ba2c    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
100012f40: 340000d3    	cbz	w19, 0x100012f58 <-[CXServer rosettaCheck]+0x7c>
100012f44: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100012f48: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100012f4c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100012f50: 910103ff    	add	sp, sp, #0x40
100012f54: d65f03c0    	ret
100012f58: d0000588    	adrp	x8, 0x1000c4000
100012f5c: f946fd00    	ldr	x0, [x8, #0xdf8]    ; class "RosettaInstallationController"
100012f60: 940149d6    	bl	0x1000656b8    ; import "_objc_alloc_init"
100012f64: aa0003f3    	mov	x19, x0
100012f68: d0000468    	adrp	x8, 0x1000a0000
100012f6c: f9400d08    	ldr	x8, [x8, #0x18]    ; import "_NSApp"
100012f70: f9400114    	ldr	x20, [x8]
100012f74: 94018beb    	bl	0x100075f20 <_objc_msgSend$window>    ; data "_objc_msgSend$window"
100012f78: aa1d03fd    	mov	x29, x29
100012f7c: 94014a17    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100012f80: aa0003f5    	mov	x21, x0
100012f84: aa1403e0    	mov	x0, x20
100012f88: aa1503e2    	mov	x2, x21
100012f8c: 9401765d    	bl	0x100070900 <_objc_msgSend$runModalForWindow:>    ; data "_objc_msgSend$runModalForWindow:"
100012f90: aa1503e0    	mov	x0, x21
100012f94: 94014a05    	bl	0x1000657a8    ; import "_objc_release"
100012f98: aa1303e0    	mov	x0, x19
100012f9c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100012fa0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100012fa4: a94157f6    	ldp	x22, x21, [sp, #0x10]
100012fa8: 910103ff    	add	sp, sp, #0x40
100012fac: 140149ff    	b	0x1000657a8    ; import "_objc_release"


0000000100012fb0 <-[CXServer applicationWillFinishLaunching:]>:
100012fb0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100012fb4: a9014ff4    	stp	x20, x19, [sp, #0x10]
100012fb8: a9027bfd    	stp	x29, x30, [sp, #0x20]
100012fbc: 910083fd    	add	x29, sp, #0x20
100012fc0: aa0003f3    	mov	x19, x0
100012fc4: 940175f7    	bl	0x1000707a0 <_objc_msgSend$rosettaCheck>    ; data "_objc_msgSend$rosettaCheck"
100012fc8: 94011bb4    	bl	0x100059e98 <_PFMoveToApplicationsFolderIfNecessary>    ; call "_PFMoveToApplicationsFolderIfNecessary"
100012fcc: d0000588    	adrp	x8, 0x1000c4000
100012fd0: f9470100    	ldr	x0, [x8, #0xe00]    ; class "NSAppleEventManager"
100012fd4: 9401834b    	bl	0x100073d00 <_objc_msgSend$sharedAppleEventManager>    ; data "_objc_msgSend$sharedAppleEventManager"
100012fd8: aa1d03fd    	mov	x29, x29
100012fdc: 940149ff    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100012fe0: aa0003f4    	mov	x20, x0
100012fe4: d0000588    	adrp	x8, 0x1000c4000
100012fe8: f9448103    	ldr	x3, [x8, #0x900]    ; sel "handleGetURLEvent:withReplyEvent:"
100012fec: aa1303e2    	mov	x2, x19
100012ff0: 528a4984    	mov	w4, #0x524c             ; =21068
100012ff4: 72a8eaa4    	movk	w4, #0x4755, lsl #16
100012ff8: 528a4985    	mov	w5, #0x524c             ; =21068
100012ffc: 72a8eaa5    	movk	w5, #0x4755, lsl #16
100013000: 94017b88    	bl	0x100071e20 <_objc_msgSend$setEventHandler:andSelector:forEventClass:andEventID:>    ; data "_objc_msgSend$setEventHandler:andSelector:forEventClass:andEventID:"
100013004: b0000595    	adrp	x21, 0x1000c4000
100013008: f94706a0    	ldr	x0, [x21, #0xe08]    ; class "CXApplication"
10001300c: 94018345    	bl	0x100073d20 <_objc_msgSend$sharedApplication>    ; data "_objc_msgSend$sharedApplication"
100013010: aa1d03fd    	mov	x29, x29
100013014: 940149f1    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100013018: aa0003f3    	mov	x19, x0
10001301c: 94017ac1    	bl	0x100071b20 <_objc_msgSend$setDaysLeft>    ; data "_objc_msgSend$setDaysLeft"
100013020: aa1303e0    	mov	x0, x19
100013024: 940149e1    	bl	0x1000657a8    ; import "_objc_release"
100013028: f94706a0    	ldr	x0, [x21, #0xe08]    ; class "CXApplication"
10001302c: 9401833d    	bl	0x100073d20 <_objc_msgSend$sharedApplication>    ; data "_objc_msgSend$sharedApplication"
100013030: aa1d03fd    	mov	x29, x29
100013034: 940149e9    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100013038: aa0003f3    	mov	x19, x0
10001303c: 94017d61    	bl	0x1000725c0 <_objc_msgSend$setIsDemo>    ; data "_objc_msgSend$setIsDemo"
100013040: aa1303e0    	mov	x0, x19
100013044: 940149d9    	bl	0x1000657a8    ; import "_objc_release"
100013048: aa1403e0    	mov	x0, x20
10001304c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100013050: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100013054: a8c357f6    	ldp	x22, x21, [sp], #0x30
100013058: 140149d4    	b	0x1000657a8    ; import "_objc_release"


000000010001a364 <-[RunCommandController supportsAVX]>:
10001a364: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
10001a368: 910003fd    	mov	x29, sp
10001a36c: 52800020    	mov	w0, #0x1                ; =1
10001a370: 528001e1    	mov	w1, #0xf                ; =15
10001a374: 52800002    	mov	w2, #0x0                ; =0
10001a378: 52800003    	mov	w3, #0x0                ; =0
10001a37c: 94012978    	bl	0x10006495c <___isPlatformVersionAtLeast>    ; call "___isPlatformVersionAtLeast"
10001a380: 7100001f    	cmp	w0, #0x0
10001a384: 1a9f07e0    	cset	w0, ne
10001a388: a8c17bfd    	ldp	x29, x30, [sp], #0x10
10001a38c: d65f03c0    	ret


0000000100055ae0 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke>:
100055ae0: d10443ff    	sub	sp, sp, #0x110
100055ae4: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
100055ae8: a90c67fa    	stp	x26, x25, [sp, #0xc0]
100055aec: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
100055af0: a90e57f6    	stp	x22, x21, [sp, #0xe0]
100055af4: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
100055af8: a9107bfd    	stp	x29, x30, [sp, #0x100]
100055afc: 910403fd    	add	x29, sp, #0x100
100055b00: f0000248    	adrp	x8, 0x1000a0000
100055b04: f9414908    	ldr	x8, [x8, #0x290]    ; import "___stack_chk_guard"
100055b08: f9400108    	ldr	x8, [x8]
100055b0c: f81a03a8    	stur	x8, [x29, #-0x60]
100055b10: d0000268    	adrp	x8, 0x1000a3000
100055b14: 9111e108    	add	x8, x8, #0x478    ; cfstr "bottleName"
100055b18: f0000269    	adrp	x9, 0x1000a4000
100055b1c: 9120e129    	add	x9, x9, #0x838    ; cfstr "bottlename"
100055b20: d000028a    	adrp	x10, 0x1000a7000
100055b24: 9137614a    	add	x10, x10, #0xdd8    ; cfstr "dependencyOverrides"
100055b28: a9032be8    	stp	x8, x10, [sp, #0x30]
100055b2c: d0000288    	adrp	x8, 0x1000a7000
100055b30: 9137e108    	add	x8, x8, #0xdf8    ; cfstr "dependency_overrides"
100055b34: a906a3e9    	stp	x9, x8, [sp, #0x68]
100055b38: d0000288    	adrp	x8, 0x1000a7000
100055b3c: 91386108    	add	x8, x8, #0xe18    ; cfstr "downloadURL"
100055b40: d0000289    	adrp	x9, 0x1000a7000
100055b44: 9138e129    	add	x9, x9, #0xe38    ; cfstr "download_url"
100055b48: f000026a    	adrp	x10, 0x1000a4000
100055b4c: 911de14a    	add	x10, x10, #0x778    ; cfstr "nameForNewBottle"
100055b50: a9042be8    	stp	x8, x10, [sp, #0x40]
100055b54: d0000288    	adrp	x8, 0x1000a7000
100055b58: 91396108    	add	x8, x8, #0xe58    ; cfstr "newBottleName"
100055b5c: a907a3e9    	stp	x9, x8, [sp, #0x78]
100055b60: d0000288    	adrp	x8, 0x1000a7000
100055b64: 9139e108    	add	x8, x8, #0xe78    ; cfstr "postInstallURL"
100055b68: d0000289    	adrp	x9, 0x1000a7000
100055b6c: 913a6129    	add	x9, x9, #0xe98    ; cfstr "post_install_url"
100055b70: d000028a    	adrp	x10, 0x1000a7000
100055b74: 913ae14a    	add	x10, x10, #0xeb8    ; cfstr "steamID"
100055b78: a9052be8    	stp	x8, x10, [sp, #0x50]
100055b7c: d0000288    	adrp	x8, 0x1000a7000
100055b80: 913b6108    	add	x8, x8, #0xed8    ; cfstr "steamid"
100055b84: a908a3e9    	stp	x9, x8, [sp, #0x88]
100055b88: f0000268    	adrp	x8, 0x1000a4000
100055b8c: 911d6108    	add	x8, x8, #0x758    ; cfstr "targetBottle"
100055b90: f90033e8    	str	x8, [sp, #0x60]
100055b94: d0000288    	adrp	x8, 0x1000a7000
100055b98: 913be108    	add	x8, x8, #0xef8    ; cfstr "target_bottle"
100055b9c: f9004fe8    	str	x8, [sp, #0x98]
100055ba0: f0000368    	adrp	x8, 0x1000c4000
100055ba4: f946d100    	ldr	x0, [x8, #0xda0]    ; class "NSDictionary"
100055ba8: 9101a3e2    	add	x2, sp, #0x68
100055bac: 9100c3e3    	add	x3, sp, #0x30
100055bb0: 528000e4    	mov	w4, #0x7                ; =7
100055bb4: 94004fc3    	bl	0x100069ac0 <_objc_msgSend$dictionaryWithObjects:forKeys:count:>    ; data "_objc_msgSend$dictionaryWithObjects:forKeys:count:"
100055bb8: aa1d03fd    	mov	x29, x29
100055bbc: 94003f07    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055bc0: f90013e0    	str	x0, [sp, #0x20]
100055bc4: f0000368    	adrp	x8, 0x1000c4000
100055bc8: f946e100    	ldr	x0, [x8, #0xdc0]    ; class "NSMutableDictionary"
100055bcc: 94003ebb    	bl	0x1000656b8    ; import "_objc_alloc_init"
100055bd0: aa0003fa    	mov	x26, x0
100055bd4: f0000368    	adrp	x8, 0x1000c4000
100055bd8: f9463500    	ldr	x0, [x8, #0xc68]    ; class "InstallConfiguration"
100055bdc: 94003ee7    	bl	0x100065778    ; import "_objc_opt_class"
100055be0: 9100b3e1    	add	x1, sp, #0x2c
100055be4: 94003e5e    	bl	0x10006555c    ; import "_class_copyPropertyList"
100055be8: aa0003f5    	mov	x21, x0
100055bec: b9402fe8    	ldr	w8, [sp, #0x2c]
100055bf0: 340016e8    	cbz	w8, 0x100055ecc <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x3ec>
100055bf4: d2800013    	mov	x19, #0x0               ; =0
100055bf8: f0000216    	adrp	x22, 0x100098000
100055bfc: 912d1ed6    	add	x22, x22, #0xb47    ; str "D"
100055c00: f0000374    	adrp	x20, 0x1000c4000
100055c04: f9000ffa    	str	x26, [sp, #0x18]
100055c08: 94003eb5    	bl	0x1000656dc    ; import "_objc_autoreleasePoolPush"
100055c0c: aa0003fc    	mov	x28, x0
100055c10: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055c14: aa1603e1    	mov	x1, x22
100055c18: 94003f14    	bl	0x100065868    ; import "_property_copyAttributeValue"
100055c1c: b40014c0    	cbz	x0, 0x100055eb4 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x3d4>
100055c20: 94003e8e    	bl	0x100065658    ; import "_free"
100055c24: f9467697    	ldr	x23, [x20, #0xce8]    ; class "NSString"
100055c28: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055c2c: 94003f12    	bl	0x100065874    ; import "_property_getName"
100055c30: aa0003e2    	mov	x2, x0
100055c34: aa1703e0    	mov	x0, x23
100055c38: 94007b7a    	bl	0x100074a20 <_objc_msgSend$stringWithUTF8String:>    ; data "_objc_msgSend$stringWithUTF8String:"
100055c3c: aa1d03fd    	mov	x29, x29
100055c40: 94003ee6    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055c44: aa0003fb    	mov	x27, x0
100055c48: 90000388    	adrp	x8, 0x1000c5000
100055c4c: f9405100    	ldr	x0, [x8, #0xa0]    ; class "PropertyDescriptor"
100055c50: 94003e9a    	bl	0x1000656b8    ; import "_objc_alloc_init"
100055c54: aa0003f7    	mov	x23, x0
100055c58: f94013e0    	ldr	x0, [sp, #0x20]
100055c5c: aa1b03e2    	mov	x2, x27
100055c60: 94006348    	bl	0x10006e980 <_objc_msgSend$objectForKey:>    ; data "_objc_msgSend$objectForKey:"
100055c64: aa1d03fd    	mov	x29, x29
100055c68: 94003edc    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055c6c: aa0003f8    	mov	x24, x0
100055c70: aa1703e0    	mov	x0, x23
100055c74: aa1803e2    	mov	x2, x24
100055c78: 940071fa    	bl	0x100072460 <_objc_msgSend$setInstallTaskAttribute:>    ; data "_objc_msgSend$setInstallTaskAttribute:"
100055c7c: aa1803e0    	mov	x0, x24
100055c80: 94003eca    	bl	0x1000657a8    ; import "_objc_release"
100055c84: aa1703e0    	mov	x0, x23
100055c88: 940059ee    	bl	0x10006c440 <_objc_msgSend$installTaskAttribute>    ; data "_objc_msgSend$installTaskAttribute"
100055c8c: aa1d03fd    	mov	x29, x29
100055c90: 94003ed2    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055c94: aa0003f8    	mov	x24, x0
100055c98: 94003ec4    	bl	0x1000657a8    ; import "_objc_release"
100055c9c: b5000098    	cbnz	x24, 0x100055cac <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x1cc>
100055ca0: aa1703e0    	mov	x0, x23
100055ca4: aa1b03e2    	mov	x2, x27
100055ca8: 940071ee    	bl	0x100072460 <_objc_msgSend$setInstallTaskAttribute:>    ; data "_objc_msgSend$setInstallTaskAttribute:"
100055cac: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055cb0: f0000201    	adrp	x1, 0x100098000
100055cb4: 912d2421    	add	x1, x1, #0xb49    ; str "T"
100055cb8: 94003eec    	bl	0x100065868    ; import "_property_copyAttributeValue"
100055cbc: aa0003f8    	mov	x24, x0
100055cc0: f0000201    	adrp	x1, 0x100098000
100055cc4: 912d2c21    	add	x1, x1, #0xb4b    ; str "B"
100055cc8: 94003f06    	bl	0x1000658e0    ; import "_strcmp"
100055ccc: 7100001f    	cmp	w0, #0x0
100055cd0: 1a9f17e2    	cset	w2, eq
100055cd4: aa1703e0    	mov	x0, x23
100055cd8: 94006dca    	bl	0x100071400 <_objc_msgSend$setBoolTyped:>    ; data "_objc_msgSend$setBoolTyped:"
100055cdc: aa1803e0    	mov	x0, x24
100055ce0: 94003e5e    	bl	0x100065658    ; import "_free"
100055ce4: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055ce8: f0000201    	adrp	x1, 0x100098000
100055cec: 912d3421    	add	x1, x1, #0xb4d    ; str "G"
100055cf0: 94003ede    	bl	0x100065868    ; import "_property_copyAttributeValue"
100055cf4: b4000200    	cbz	x0, 0x100055d34 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x254>
100055cf8: aa0003f8    	mov	x24, x0
100055cfc: f9467680    	ldr	x0, [x20, #0xce8]    ; class "NSString"
100055d00: aa1803e2    	mov	x2, x24
100055d04: 94007b47    	bl	0x100074a20 <_objc_msgSend$stringWithUTF8String:>    ; data "_objc_msgSend$stringWithUTF8String:"
100055d08: aa1d03fd    	mov	x29, x29
100055d0c: 94003eb3    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055d10: aa0003f9    	mov	x25, x0
100055d14: aa1703e0    	mov	x0, x23
100055d18: aa1903e2    	mov	x2, x25
100055d1c: 940070d1    	bl	0x100072060 <_objc_msgSend$setGetter:>    ; data "_objc_msgSend$setGetter:"
100055d20: aa1903e0    	mov	x0, x25
100055d24: 94003ea1    	bl	0x1000657a8    ; import "_objc_release"
100055d28: aa1803e0    	mov	x0, x24
100055d2c: 94003e4b    	bl	0x100065658    ; import "_free"
100055d30: 14000004    	b	0x100055d40 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x260>
100055d34: aa1703e0    	mov	x0, x23
100055d38: aa1b03e2    	mov	x2, x27
100055d3c: 940070c9    	bl	0x100072060 <_objc_msgSend$setGetter:>    ; data "_objc_msgSend$setGetter:"
100055d40: aa1703e0    	mov	x0, x23
100055d44: 940054ff    	bl	0x10006b140 <_objc_msgSend$getter>    ; data "_objc_msgSend$getter"
100055d48: aa1d03fd    	mov	x29, x29
100055d4c: 94003ea3    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055d50: aa0003f8    	mov	x24, x0
100055d54: aa1a03e0    	mov	x0, x26
100055d58: aa1703e2    	mov	x2, x23
100055d5c: aa1803e3    	mov	x3, x24
100055d60: 940073b8    	bl	0x100072c40 <_objc_msgSend$setObject:forKey:>    ; data "_objc_msgSend$setObject:forKey:"
100055d64: aa1803e0    	mov	x0, x24
100055d68: 94003e90    	bl	0x1000657a8    ; import "_objc_release"
100055d6c: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055d70: f0000201    	adrp	x1, 0x100098000
100055d74: 912d3c21    	add	x1, x1, #0xb4f    ; str "R"
100055d78: 94003ebc    	bl	0x100065868    ; import "_property_copyAttributeValue"
100055d7c: b4000060    	cbz	x0, 0x100055d88 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x2a8>
100055d80: 94003e36    	bl	0x100065658    ; import "_free"
100055d84: 14000048    	b	0x100055ea4 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x3c4>
100055d88: aa1403f6    	mov	x22, x20
100055d8c: f8737aa0    	ldr	x0, [x21, x19, lsl #3]
100055d90: f0000201    	adrp	x1, 0x100098000
100055d94: 912d4421    	add	x1, x1, #0xb51    ; str "S"
100055d98: 94003eb4    	bl	0x100065868    ; import "_property_copyAttributeValue"
100055d9c: f9467698    	ldr	x24, [x20, #0xce8]    ; class "NSString"
100055da0: b4000200    	cbz	x0, 0x100055de0 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x300>
100055da4: aa0003f9    	mov	x25, x0
100055da8: aa1803e0    	mov	x0, x24
100055dac: aa1903e2    	mov	x2, x25
100055db0: 94007b1c    	bl	0x100074a20 <_objc_msgSend$stringWithUTF8String:>    ; data "_objc_msgSend$stringWithUTF8String:"
100055db4: aa1d03fd    	mov	x29, x29
100055db8: 94003e88    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055dbc: aa0003f8    	mov	x24, x0
100055dc0: aa1703e0    	mov	x0, x23
100055dc4: aa1803e2    	mov	x2, x24
100055dc8: 9400754e    	bl	0x100073300 <_objc_msgSend$setSetter:>    ; data "_objc_msgSend$setSetter:"
100055dcc: aa1803e0    	mov	x0, x24
100055dd0: 94003e76    	bl	0x1000657a8    ; import "_objc_release"
100055dd4: aa1903e0    	mov	x0, x25
100055dd8: 94003e20    	bl	0x100065658    ; import "_free"
100055ddc: 14000025    	b	0x100055e70 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x390>
100055de0: aa1b03e0    	mov	x0, x27
100055de4: 52800022    	mov	w2, #0x1                ; =1
100055de8: 94007b2e    	bl	0x100074aa0 <_objc_msgSend$substringToIndex:>    ; data "_objc_msgSend$substringToIndex:"
100055dec: aa1d03fd    	mov	x29, x29
100055df0: 94003e7a    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055df4: aa0003f9    	mov	x25, x0
100055df8: 94007f32    	bl	0x100075ac0 <_objc_msgSend$uppercaseString>    ; data "_objc_msgSend$uppercaseString"
100055dfc: aa1d03fd    	mov	x29, x29
100055e00: 94003e76    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055e04: aa0003fa    	mov	x26, x0
100055e08: aa1b03e0    	mov	x0, x27
100055e0c: 52800022    	mov	w2, #0x1                ; =1
100055e10: 94007b1c    	bl	0x100074a80 <_objc_msgSend$substringFromIndex:>    ; data "_objc_msgSend$substringFromIndex:"
100055e14: aa1d03fd    	mov	x29, x29
100055e18: 94003e70    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055e1c: aa0003f6    	mov	x22, x0
100055e20: a90003fa    	stp	x26, x0, [sp]
100055e24: aa1803e0    	mov	x0, x24
100055e28: d0000282    	adrp	x2, 0x1000a7000
100055e2c: 913c6042    	add	x2, x2, #0xf18    ; cfstr "set%@%@:"
100055e30: 94007aec    	bl	0x1000749e0 <_objc_msgSend$stringWithFormat:>    ; data "_objc_msgSend$stringWithFormat:"
100055e34: aa1d03fd    	mov	x29, x29
100055e38: 94003e68    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055e3c: aa0003f8    	mov	x24, x0
100055e40: aa1703e0    	mov	x0, x23
100055e44: aa1803e2    	mov	x2, x24
100055e48: 9400752e    	bl	0x100073300 <_objc_msgSend$setSetter:>    ; data "_objc_msgSend$setSetter:"
100055e4c: aa1803e0    	mov	x0, x24
100055e50: 94003e56    	bl	0x1000657a8    ; import "_objc_release"
100055e54: aa1603e0    	mov	x0, x22
100055e58: 94003e54    	bl	0x1000657a8    ; import "_objc_release"
100055e5c: aa1a03e0    	mov	x0, x26
100055e60: f9400ffa    	ldr	x26, [sp, #0x18]
100055e64: 94003e51    	bl	0x1000657a8    ; import "_objc_release"
100055e68: aa1903e0    	mov	x0, x25
100055e6c: 94003e4f    	bl	0x1000657a8    ; import "_objc_release"
100055e70: aa1703e0    	mov	x0, x23
100055e74: 94007783    	bl	0x100073c80 <_objc_msgSend$setter>    ; data "_objc_msgSend$setter"
100055e78: aa1d03fd    	mov	x29, x29
100055e7c: 94003e57    	bl	0x1000657d8    ; import "_objc_retainAutoreleasedReturnValue"
100055e80: aa0003f6    	mov	x22, x0
100055e84: aa1a03e0    	mov	x0, x26
100055e88: aa1703e2    	mov	x2, x23
100055e8c: aa1603e3    	mov	x3, x22
100055e90: 9400736c    	bl	0x100072c40 <_objc_msgSend$setObject:forKey:>    ; data "_objc_msgSend$setObject:forKey:"
100055e94: aa1603e0    	mov	x0, x22
100055e98: 94003e44    	bl	0x1000657a8    ; import "_objc_release"
100055e9c: f0000216    	adrp	x22, 0x100098000
100055ea0: 912d1ed6    	add	x22, x22, #0xb47    ; str "D"
100055ea4: aa1703e0    	mov	x0, x23
100055ea8: 94003e40    	bl	0x1000657a8    ; import "_objc_release"
100055eac: aa1b03e0    	mov	x0, x27
100055eb0: 94003e3e    	bl	0x1000657a8    ; import "_objc_release"
100055eb4: aa1c03e0    	mov	x0, x28
100055eb8: 94003e06    	bl	0x1000656d0    ; import "_objc_autoreleasePoolPop"
100055ebc: 91000673    	add	x19, x19, #0x1
100055ec0: b9402fe8    	ldr	w8, [sp, #0x2c]
100055ec4: eb08027f    	cmp	x19, x8
100055ec8: 54ffea03    	b.lo	0x100055c08 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x128>
100055ecc: aa1503e0    	mov	x0, x21
100055ed0: 94003de2    	bl	0x100065658    ; import "_free"
100055ed4: f0000388    	adrp	x8, 0x1000c8000 <__OBJC_PROTOCOL_$_CXUpdaterDelegate+0x30>
100055ed8: f9422100    	ldr	x0, [x8, #0x440]    ; data "_selectorToProperty"
100055edc: f902211a    	str	x26, [x8, #0x440]
100055ee0: 94003e32    	bl	0x1000657a8    ; import "_objc_release"
100055ee4: f94013e0    	ldr	x0, [sp, #0x20]
100055ee8: 94003e30    	bl	0x1000657a8    ; import "_objc_release"
100055eec: f85a03a8    	ldur	x8, [x29, #-0x60]
100055ef0: f0000249    	adrp	x9, 0x1000a0000
100055ef4: f9414929    	ldr	x9, [x9, #0x290]    ; import "___stack_chk_guard"
100055ef8: f9400129    	ldr	x9, [x9]
100055efc: eb08013f    	cmp	x9, x8
100055f00: 54000121    	b.ne	0x100055f24 <___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke+0x444>
100055f04: a9507bfd    	ldp	x29, x30, [sp, #0x100]
100055f08: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
100055f0c: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
100055f10: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
100055f14: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
100055f18: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
100055f1c: 910443ff    	add	sp, sp, #0x110
100055f20: d65f03c0    	ret
100055f24: 94003d7c    	bl	0x100065514    ; import "___stack_chk_fail"


0000000100059ca4 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]>:
100059ca4: d10303ff    	sub	sp, sp, #0xc0
100059ca8: a90957f6    	stp	x22, x21, [sp, #0x90]
100059cac: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
100059cb0: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
100059cb4: 9102c3fd    	add	x29, sp, #0xb0
100059cb8: aa0003f3    	mov	x19, x0
100059cbc: f0000356    	adrp	x22, 0x1000c4000
100059cc0: f94682c0    	ldr	x0, [x22, #0xd00]    ; class "NSFileManager"
100059cc4: 94003e3f    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
100059cc8: aa1303e2    	mov	x2, x19
100059ccc: 940042ed    	bl	0x10006a880 <_objc_msgSend$fileSystemRepresentationWithPath:>    ; data "_objc_msgSend$fileSystemRepresentationWithPath:"
100059cd0: 910003e1    	mov	x1, sp
100059cd4: 94002e70    	bl	0x100065694    ; import "_lstat"
100059cd8: 37f803c0    	tbnz	w0, #0x1f, 0x100059d50 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xac>
100059cdc: d2800014    	mov	x20, #0x0               ; =0
100059ce0: 79400be8    	ldrh	w8, [sp, #0x4]
100059ce4: 12140d09    	and	w9, w8, #0xf000
100059ce8: 7140293f    	cmp	w9, #0xa, lsl #12       ; =0xa000
100059cec: 54000100    	b.eq	0x100059d0c <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x68>
100059cf0: 7140113f    	cmp	w9, #0x4, lsl #12       ; =0x4000
100059cf4: 54000300    	b.eq	0x100059d54 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xb0>
100059cf8: aa1303e0    	mov	x0, x19
100059cfc: 94006a69    	bl	0x1000746a0 <_objc_msgSend$stringByConditionallyResolvingAlias>    ; data "_objc_msgSend$stringByConditionallyResolvingAlias"
100059d00: b40002a0    	cbz	x0, 0x100059d54 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xb0>
100059d04: aa0003f4    	mov	x20, x0
100059d08: 79400be8    	ldrh	w8, [sp, #0x4]
100059d0c: 12140d08    	and	w8, w8, #0xf000
100059d10: aa1403f5    	mov	x21, x20
100059d14: 7140291f    	cmp	w8, #0xa, lsl #12       ; =0xa000
100059d18: 540000a1    	b.ne	0x100059d2c <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x88>
100059d1c: aa1303e0    	mov	x0, x19
100059d20: 94006a68    	bl	0x1000746c0 <_objc_msgSend$stringByConditionallyResolvingSymlink>    ; data "_objc_msgSend$stringByConditionallyResolvingSymlink"
100059d24: aa0003f5    	mov	x21, x0
100059d28: b4000140    	cbz	x0, 0x100059d50 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0xac>
100059d2c: f94682c0    	ldr	x0, [x22, #0xd00]    ; class "NSFileManager"
100059d30: 94003e24    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
100059d34: aa1503e2    	mov	x2, x21
100059d38: 940042d2    	bl	0x10006a880 <_objc_msgSend$fileSystemRepresentationWithPath:>    ; data "_objc_msgSend$fileSystemRepresentationWithPath:"
100059d3c: 910003e1    	mov	x1, sp
100059d40: 94002e55    	bl	0x100065694    ; import "_lstat"
100059d44: 7100001f    	cmp	w0, #0x0
100059d48: 9a95b3f3    	csel	x19, xzr, x21, lt
100059d4c: 17ffffe5    	b	0x100059ce0 <-[NSString(SymlinksAndAliases) stringByIterativelyResolvingSymlinkOrAlias]+0x3c>
100059d50: d2800013    	mov	x19, #0x0               ; =0
100059d54: aa1303e0    	mov	x0, x19
100059d58: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
100059d5c: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
100059d60: a94957f6    	ldp	x22, x21, [sp, #0x90]
100059d64: 910303ff    	add	sp, sp, #0xc0
100059d68: d65f03c0    	ret


0000000100059e98 <_PFMoveToApplicationsFolderIfNecessary>:
100059e98: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
100059e9c: a9016ffc    	stp	x28, x27, [sp, #0x10]
100059ea0: a90267fa    	stp	x26, x25, [sp, #0x20]
100059ea4: a9035ff8    	stp	x24, x23, [sp, #0x30]
100059ea8: a90457f6    	stp	x22, x21, [sp, #0x40]
100059eac: a9054ff4    	stp	x20, x19, [sp, #0x50]
100059eb0: a9067bfd    	stp	x29, x30, [sp, #0x60]
100059eb4: 910183fd    	add	x29, sp, #0x60
100059eb8: d10a83ff    	sub	sp, sp, #0x2a0
100059ebc: f0000228    	adrp	x8, 0x1000a0000
100059ec0: f9414908    	ldr	x8, [x8, #0x290]    ; import "___stack_chk_guard"
100059ec4: f9400108    	ldr	x8, [x8]
100059ec8: f81903a8    	stur	x8, [x29, #-0x70]
100059ecc: f0000348    	adrp	x8, 0x1000c4000
100059ed0: f9461900    	ldr	x0, [x8, #0xc30]    ; class "NSUserDefaults"
100059ed4: 9400690b    	bl	0x100074300 <_objc_msgSend$standardUserDefaults>    ; data "_objc_msgSend$standardUserDefaults"
100059ed8: aa0003f6    	mov	x22, x0
100059edc: f0000262    	adrp	x2, 0x1000a8000
100059ee0: 91146042    	add	x2, x2, #0x518    ; cfstr "moveToApplicationsFolderAlertSuppress"
100059ee4: 940036c7    	bl	0x100067a00 <_objc_msgSend$boolForKey:>    ; data "_objc_msgSend$boolForKey:"
100059ee8: 36000200    	tbz	w0, #0x0, 0x100059f28 <_PFMoveToApplicationsFolderIfNecessary+0x90>
100059eec: f85903a8    	ldur	x8, [x29, #-0x70]
100059ef0: f0000229    	adrp	x9, 0x1000a0000
100059ef4: f9414929    	ldr	x9, [x9, #0x290]    ; import "___stack_chk_guard"
100059ef8: f9400129    	ldr	x9, [x9]
100059efc: eb08013f    	cmp	x9, x8
100059f00: 54005941    	b.ne	0x10005aa28 <_PFMoveToApplicationsFolderIfNecessary+0xb90>
100059f04: 910a83ff    	add	sp, sp, #0x2a0
100059f08: a9467bfd    	ldp	x29, x30, [sp, #0x60]
100059f0c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
100059f10: a94457f6    	ldp	x22, x21, [sp, #0x40]
100059f14: a9435ff8    	ldp	x24, x23, [sp, #0x30]
100059f18: a94267fa    	ldp	x26, x25, [sp, #0x20]
100059f1c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
100059f20: 6cc723e9    	ldp	d9, d8, [sp], #0x70
100059f24: d65f03c0    	ret
100059f28: f000035c    	adrp	x28, 0x1000c4000
100059f2c: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
100059f30: 94004fc4    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
100059f34: 940037fb    	bl	0x100067f20 <_objc_msgSend$bundlePath>    ; data "_objc_msgSend$bundlePath"
100059f38: aa0003f3    	mov	x19, x0
100059f3c: 52800020    	mov	w0, #0x1                ; =1
100059f40: 529fffe1    	mov	w1, #0xffff             ; =65535
100059f44: 52800022    	mov	w2, #0x1                ; =1
100059f48: 94002d16    	bl	0x1000653a0    ; import "_NSSearchPathForDirectoriesInDomains"
100059f4c: aa0003f4    	mov	x20, x0
100059f50: 6f00e400    	movi.2d	v0, #0000000000000000
100059f54: ad0603e0    	stp	q0, q0, [sp, #0xc0]
100059f58: ad0703e0    	stp	q0, q0, [sp, #0xe0]
100059f5c: 910303e2    	add	x2, sp, #0xc0
100059f60: d103c3a3    	sub	x3, x29, #0xf0
100059f64: 52800204    	mov	w4, #0x10               ; =16
100059f68: 94003bce    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
100059f6c: b4000340    	cbz	x0, 0x100059fd4 <_PFMoveToApplicationsFolderIfNecessary+0x13c>
100059f70: aa0003f5    	mov	x21, x0
100059f74: f9406be8    	ldr	x8, [sp, #0xd0]
100059f78: f9400117    	ldr	x23, [x8]
100059f7c: d2800018    	mov	x24, #0x0               ; =0
100059f80: f9406be8    	ldr	x8, [sp, #0xd0]
100059f84: f9400108    	ldr	x8, [x8]
100059f88: eb17011f    	cmp	x8, x23
100059f8c: 54000060    	b.eq	0x100059f98 <_PFMoveToApplicationsFolderIfNecessary+0x100>
100059f90: aa1403e0    	mov	x0, x20
100059f94: 94002de4    	bl	0x100065724    ; import "_objc_enumerationMutation"
100059f98: f94067e8    	ldr	x8, [sp, #0xc8]
100059f9c: f8787901    	ldr	x1, [x8, x24, lsl #3]
100059fa0: aa1303e0    	mov	x0, x19
100059fa4: 9400033b    	bl	0x10005ac90 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
100059fa8: 3707fa20    	tbnz	w0, #0x0, 0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
100059fac: 91000718    	add	x24, x24, #0x1
100059fb0: eb1802bf    	cmp	x21, x24
100059fb4: 54fffe61    	b.ne	0x100059f80 <_PFMoveToApplicationsFolderIfNecessary+0xe8>
100059fb8: 910303e2    	add	x2, sp, #0xc0
100059fbc: d103c3a3    	sub	x3, x29, #0xf0
100059fc0: aa1403e0    	mov	x0, x20
100059fc4: 52800204    	mov	w4, #0x10               ; =16
100059fc8: 94003bb6    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
100059fcc: aa0003f5    	mov	x21, x0
100059fd0: b5fffd60    	cbnz	x0, 0x100059f7c <_PFMoveToApplicationsFolderIfNecessary+0xe4>
100059fd4: aa1303e0    	mov	x0, x19
100059fd8: 940053fa    	bl	0x10006efc0 <_objc_msgSend$pathComponents>    ; data "_objc_msgSend$pathComponents"
100059fdc: aa0003f4    	mov	x20, x0
100059fe0: f0000262    	adrp	x2, 0x1000a8000
100059fe4: 9114e042    	add	x2, x2, #0x538    ; cfstr "Applications"
100059fe8: 94003ab6    	bl	0x100068ac0 <_objc_msgSend$containsObject:>    ; data "_objc_msgSend$containsObject:"
100059fec: 3707f800    	tbnz	w0, #0x0, 0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
100059ff0: 6f00e400    	movi.2d	v0, #0000000000000000
100059ff4: ad0503e0    	stp	q0, q0, [sp, #0xa0]
100059ff8: ad0403e0    	stp	q0, q0, [sp, #0x80]
100059ffc: 910203e2    	add	x2, sp, #0x80
10005a000: 910643e3    	add	x3, sp, #0x190
10005a004: aa1403e0    	mov	x0, x20
10005a008: 52800204    	mov	w4, #0x10               ; =16
10005a00c: 94003ba5    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a010: b4000380    	cbz	x0, 0x10005a080 <_PFMoveToApplicationsFolderIfNecessary+0x1e8>
10005a014: aa0003f7    	mov	x23, x0
10005a018: f9404be8    	ldr	x8, [sp, #0x90]
10005a01c: f9400118    	ldr	x24, [x8]
10005a020: d0000275    	adrp	x21, 0x1000a8000
10005a024: 911562b5    	add	x21, x21, #0x558    ; cfstr "SteamApps"
10005a028: d2800019    	mov	x25, #0x0               ; =0
10005a02c: f9404be8    	ldr	x8, [sp, #0x90]
10005a030: f9400108    	ldr	x8, [x8]
10005a034: eb18011f    	cmp	x8, x24
10005a038: 54000060    	b.eq	0x10005a044 <_PFMoveToApplicationsFolderIfNecessary+0x1ac>
10005a03c: aa1403e0    	mov	x0, x20
10005a040: 94002db9    	bl	0x100065724    ; import "_objc_enumerationMutation"
10005a044: f94047e8    	ldr	x8, [sp, #0x88]
10005a048: f8797900    	ldr	x0, [x8, x25, lsl #3]
10005a04c: aa1503e2    	mov	x2, x21
10005a050: 940038c4    	bl	0x100068360 <_objc_msgSend$caseInsensitiveCompare:>    ; data "_objc_msgSend$caseInsensitiveCompare:"
10005a054: b4fff4c0    	cbz	x0, 0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
10005a058: 91000739    	add	x25, x25, #0x1
10005a05c: eb1902ff    	cmp	x23, x25
10005a060: 54fffe61    	b.ne	0x10005a02c <_PFMoveToApplicationsFolderIfNecessary+0x194>
10005a064: 910203e2    	add	x2, sp, #0x80
10005a068: 910643e3    	add	x3, sp, #0x190
10005a06c: aa1403e0    	mov	x0, x20
10005a070: 52800204    	mov	w4, #0x10               ; =16
10005a074: 94003b8b    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a078: aa0003f7    	mov	x23, x0
10005a07c: b5fffd60    	cbnz	x0, 0x10005a028 <_PFMoveToApplicationsFolderIfNecessary+0x190>
10005a080: d0000354    	adrp	x20, 0x1000c4000
10005a084: f9468280    	ldr	x0, [x20, #0xd00]    ; class "NSFileManager"
10005a088: 94003d4e    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005a08c: aa0003f7    	mov	x23, x0
10005a090: d2800000    	mov	x0, #0x0                ; =0
10005a094: 940002ae    	bl	0x10005ab4c <_IsLaunchedFromDMG>    ; call "_IsLaunchedFromDMG"
10005a098: b9001fe0    	str	w0, [sp, #0x1c]
10005a09c: f9468280    	ldr	x0, [x20, #0xd00]    ; class "NSFileManager"
10005a0a0: 94003d48    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005a0a4: aa0003f8    	mov	x24, x0
10005a0a8: 52800020    	mov	w0, #0x1                ; =1
10005a0ac: 52800021    	mov	w1, #0x1                ; =1
10005a0b0: 52800022    	mov	w2, #0x1                ; =1
10005a0b4: 94002cbb    	bl	0x1000653a0    ; import "_NSSearchPathForDirectoriesInDomains"
10005a0b8: aa0003f5    	mov	x21, x0
10005a0bc: 94003b71    	bl	0x100068e80 <_objc_msgSend$count>    ; data "_objc_msgSend$count"
10005a0c0: f90013f7    	str	x23, [sp, #0x20]
10005a0c4: b40008a0    	cbz	x0, 0x10005a1d8 <_PFMoveToApplicationsFolderIfNecessary+0x340>
10005a0c8: aa1503e0    	mov	x0, x21
10005a0cc: d2800002    	mov	x2, #0x0                ; =0
10005a0d0: 94005214    	bl	0x10006e920 <_objc_msgSend$objectAtIndex:>    ; data "_objc_msgSend$objectAtIndex:"
10005a0d4: aa0003f5    	mov	x21, x0
10005a0d8: 910303e3    	add	x3, sp, #0xc0
10005a0dc: aa1803e0    	mov	x0, x24
10005a0e0: aa1503e2    	mov	x2, x21
10005a0e4: 940041af    	bl	0x10006a7a0 <_objc_msgSend$fileExistsAtPath:isDirectory:>    ; data "_objc_msgSend$fileExistsAtPath:isDirectory:"
10005a0e8: 34000780    	cbz	w0, 0x10005a1d8 <_PFMoveToApplicationsFolderIfNecessary+0x340>
10005a0ec: 394303e8    	ldrb	w8, [sp, #0xc0]
10005a0f0: 34000748    	cbz	w8, 0x10005a1d8 <_PFMoveToApplicationsFolderIfNecessary+0x340>
10005a0f4: aa1803e0    	mov	x0, x24
10005a0f8: aa1503e2    	mov	x2, x21
10005a0fc: d2800003    	mov	x3, #0x0                ; =0
10005a100: 94003aa0    	bl	0x100068b80 <_objc_msgSend$contentsOfDirectoryAtPath:error:>    ; data "_objc_msgSend$contentsOfDirectoryAtPath:error:"
10005a104: aa0003f8    	mov	x24, x0
10005a108: d0000348    	adrp	x8, 0x1000c4000
10005a10c: f9467d00    	ldr	x0, [x8, #0xcf8]    ; class "NSWorkspace"
10005a110: 94006744    	bl	0x100073e20 <_objc_msgSend$sharedWorkspace>    ; data "_objc_msgSend$sharedWorkspace"
10005a114: aa0003f9    	mov	x25, x0
10005a118: 6f00e400    	movi.2d	v0, #0000000000000000
10005a11c: ad0c83e0    	stp	q0, q0, [sp, #0x190]
10005a120: ad0d83e0    	stp	q0, q0, [sp, #0x1b0]
10005a124: 910643e2    	add	x2, sp, #0x190
10005a128: d103c3a3    	sub	x3, x29, #0xf0
10005a12c: aa1803e0    	mov	x0, x24
10005a130: 52800204    	mov	w4, #0x10               ; =16
10005a134: 94003b5b    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a138: b4000500    	cbz	x0, 0x10005a1d8 <_PFMoveToApplicationsFolderIfNecessary+0x340>
10005a13c: aa0003fa    	mov	x26, x0
10005a140: f940d3e8    	ldr	x8, [sp, #0x1a0]
10005a144: f9400114    	ldr	x20, [x8]
10005a148: d0000228    	adrp	x8, 0x1000a0000
10005a14c: f9418108    	ldr	x8, [x8, #0x300]    ; import "_kUTTypeApplication"
10005a150: f940011b    	ldr	x27, [x8]
10005a154: d2800017    	mov	x23, #0x0               ; =0
10005a158: f940d3e8    	ldr	x8, [sp, #0x1a0]
10005a15c: f9400108    	ldr	x8, [x8]
10005a160: eb14011f    	cmp	x8, x20
10005a164: 54000060    	b.eq	0x10005a170 <_PFMoveToApplicationsFolderIfNecessary+0x2d8>
10005a168: aa1803e0    	mov	x0, x24
10005a16c: 94002d6e    	bl	0x100065724    ; import "_objc_enumerationMutation"
10005a170: f940cfe8    	ldr	x8, [sp, #0x198]
10005a174: f8777902    	ldr	x2, [x8, x23, lsl #3]
10005a178: aa1503e0    	mov	x0, x21
10005a17c: 94006931    	bl	0x100074640 <_objc_msgSend$stringByAppendingPathComponent:>    ; data "_objc_msgSend$stringByAppendingPathComponent:"
10005a180: 940069a8    	bl	0x100074820 <_objc_msgSend$stringByResolvingSymlinksAndAliases>    ; data "_objc_msgSend$stringByResolvingSymlinksAndAliases"
10005a184: aa0003e2    	mov	x2, x0
10005a188: aa1903e0    	mov	x0, x25
10005a18c: d2800003    	mov	x3, #0x0                ; =0
10005a190: 94006c74    	bl	0x100075360 <_objc_msgSend$typeOfFile:error:>    ; data "_objc_msgSend$typeOfFile:error:"
10005a194: b40000c0    	cbz	x0, 0x10005a1ac <_PFMoveToApplicationsFolderIfNecessary+0x314>
10005a198: aa0003e2    	mov	x2, x0
10005a19c: aa1903e0    	mov	x0, x25
10005a1a0: aa1b03e3    	mov	x3, x27
10005a1a4: 94006c67    	bl	0x100075340 <_objc_msgSend$type:conformsToType:>    ; data "_objc_msgSend$type:conformsToType:"
10005a1a8: 35001320    	cbnz	w0, 0x10005a40c <_PFMoveToApplicationsFolderIfNecessary+0x574>
10005a1ac: 910006f7    	add	x23, x23, #0x1
10005a1b0: eb17035f    	cmp	x26, x23
10005a1b4: 54fffd21    	b.ne	0x10005a158 <_PFMoveToApplicationsFolderIfNecessary+0x2c0>
10005a1b8: 910643e2    	add	x2, sp, #0x190
10005a1bc: d103c3a3    	sub	x3, x29, #0xf0
10005a1c0: aa1803e0    	mov	x0, x24
10005a1c4: 52800204    	mov	w4, #0x10               ; =16
10005a1c8: 94003b36    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a1cc: aa0003fa    	mov	x26, x0
10005a1d0: f94013f7    	ldr	x23, [sp, #0x20]
10005a1d4: b5fffc00    	cbnz	x0, 0x10005a154 <_PFMoveToApplicationsFolderIfNecessary+0x2bc>
10005a1d8: 52800020    	mov	w0, #0x1                ; =1
10005a1dc: 52800041    	mov	w1, #0x2                ; =2
10005a1e0: 52800022    	mov	w2, #0x1                ; =1
10005a1e4: 94002c6f    	bl	0x1000653a0    ; import "_NSSearchPathForDirectoriesInDomains"
10005a1e8: 94004cce    	bl	0x10006d520 <_objc_msgSend$lastObject>    ; data "_objc_msgSend$lastObject"
10005a1ec: 9400698d    	bl	0x100074820 <_objc_msgSend$stringByResolvingSymlinksAndAliases>    ; data "_objc_msgSend$stringByResolvingSymlinksAndAliases"
10005a1f0: aa0003f8    	mov	x24, x0
10005a1f4: d0000279    	adrp	x25, 0x1000a8000
10005a1f8: 910d6339    	add	x25, x25, #0x358    ; cfstr "Move to Applications folder?"
10005a1fc: aa1303e0    	mov	x0, x19
10005a200: 94004cd0    	bl	0x10006d540 <_objc_msgSend$lastPathComponent>    ; data "_objc_msgSend$lastPathComponent"
10005a204: aa0003e2    	mov	x2, x0
10005a208: aa1803e0    	mov	x0, x24
10005a20c: 9400690d    	bl	0x100074640 <_objc_msgSend$stringByAppendingPathComponent:>    ; data "_objc_msgSend$stringByAppendingPathComponent:"
10005a210: aa0003f5    	mov	x21, x0
10005a214: aa1703e0    	mov	x0, x23
10005a218: aa1803e2    	mov	x2, x24
10005a21c: 94004c19    	bl	0x10006d280 <_objc_msgSend$isWritableFileAtPath:>    ; data "_objc_msgSend$isWritableFileAtPath:"
10005a220: 340001c0    	cbz	w0, 0x10005a258 <_PFMoveToApplicationsFolderIfNecessary+0x3c0>
10005a224: 9101ffe3    	add	x3, sp, #0x7f
10005a228: aa1703e0    	mov	x0, x23
10005a22c: aa1503e2    	mov	x2, x21
10005a230: 9400415c    	bl	0x10006a7a0 <_objc_msgSend$fileExistsAtPath:isDirectory:>    ; data "_objc_msgSend$fileExistsAtPath:isDirectory:"
10005a234: 52800014    	mov	w20, #0x0               ; =0
10005a238: 34000120    	cbz	w0, 0x10005a25c <_PFMoveToApplicationsFolderIfNecessary+0x3c4>
10005a23c: 3941ffe8    	ldrb	w8, [sp, #0x7f]
10005a240: 340000e8    	cbz	w8, 0x10005a25c <_PFMoveToApplicationsFolderIfNecessary+0x3c4>
10005a244: aa1703e0    	mov	x0, x23
10005a248: aa1503e2    	mov	x2, x21
10005a24c: 94004c0d    	bl	0x10006d280 <_objc_msgSend$isWritableFileAtPath:>    ; data "_objc_msgSend$isWritableFileAtPath:"
10005a250: 52000014    	eor	w20, w0, #0x1
10005a254: 14000002    	b	0x10005a25c <_PFMoveToApplicationsFolderIfNecessary+0x3c4>
10005a258: 52800034    	mov	w20, #0x1               ; =1
10005a25c: d0000357    	adrp	x23, 0x1000c4000
10005a260: f94696e0    	ldr	x0, [x23, #0xd28]    ; class "NSAlert"
10005a264: 94002d15    	bl	0x1000656b8    ; import "_objc_alloc_init"
10005a268: 94002d17    	bl	0x1000656c4    ; import "_objc_autorelease"
10005a26c: aa0003f8    	mov	x24, x0
10005a270: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a274: 94004ef3    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a278: d000023a    	adrp	x26, 0x1000a0000
10005a27c: 9139635a    	add	x26, x26, #0xe58    ; cfstr ""
10005a280: d000027b    	adrp	x27, 0x1000a8000
10005a284: 910ce37b    	add	x27, x27, #0x338    ; cfstr "MoveApplication"
10005a288: aa1903e2    	mov	x2, x25
10005a28c: aa1a03e3    	mov	x3, x26
10005a290: aa1b03e4    	mov	x4, x27
10005a294: 94004e4b    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a298: aa0003e2    	mov	x2, x0
10005a29c: aa1803e0    	mov	x0, x24
10005a2a0: 940061e0    	bl	0x100072a20 <_objc_msgSend$setMessageText:>    ; data "_objc_msgSend$setMessageText:"
10005a2a4: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a2a8: 94004ee6    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a2ac: d0000262    	adrp	x2, 0x1000a8000
10005a2b0: 910de042    	add	x2, x2, #0x378    ; cfstr "I can move myself to the Applications folder if you'd like."
10005a2b4: aa1a03e3    	mov	x3, x26
10005a2b8: aa1b03e4    	mov	x4, x27
10005a2bc: 94004e41    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a2c0: aa0003f9    	mov	x25, x0
10005a2c4: f000021b    	adrp	x27, 0x10009d000
10005a2c8: b9002ff4    	str	w20, [sp, #0x2c]
10005a2cc: 34000314    	cbz	w20, 0x10005a32c <_PFMoveToApplicationsFolderIfNecessary+0x494>
10005a2d0: d0000222    	adrp	x2, 0x1000a0000
10005a2d4: 9138e042    	add	x2, x2, #0xe38    ; cfstr " "
10005a2d8: aa1903e0    	mov	x0, x25
10005a2dc: 940068e9    	bl	0x100074680 <_objc_msgSend$stringByAppendingString:>    ; data "_objc_msgSend$stringByAppendingString:"
10005a2e0: aa0003f9    	mov	x25, x0
10005a2e4: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a2e8: 94004ed6    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a2ec: d0000262    	adrp	x2, 0x1000a8000
10005a2f0: 910e6042    	add	x2, x2, #0x398    ; cfstr "Note that this will require an administrator password."
10005a2f4: d0000223    	adrp	x3, 0x1000a0000
10005a2f8: 91396063    	add	x3, x3, #0xe58    ; cfstr ""
10005a2fc: d0000264    	adrp	x4, 0x1000a8000
10005a300: 910ce084    	add	x4, x4, #0x338    ; cfstr "MoveApplication"
10005a304: 94004e2f    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a308: aa0003e2    	mov	x2, x0
10005a30c: aa1903e0    	mov	x0, x25
10005a310: 940068dc    	bl	0x100074680 <_objc_msgSend$stringByAppendingString:>    ; data "_objc_msgSend$stringByAppendingString:"
10005a314: aa0003f9    	mov	x25, x0
10005a318: d0000228    	adrp	x8, 0x1000a0000
10005a31c: f9401108    	ldr	x8, [x8, #0x20]    ; import "_NSAppKitVersionNumber"
10005a320: fd400100    	ldr	d0, [x8]
10005a324: 1e654008    	frintm	d8, d0
10005a328: 14000054    	b	0x10005a478 <_PFMoveToApplicationsFolderIfNecessary+0x5e0>
10005a32c: d0000228    	adrp	x8, 0x1000a0000
10005a330: f9401108    	ldr	x8, [x8, #0x20]    ; import "_NSAppKitVersionNumber"
10005a334: fd400100    	ldr	d0, [x8]
10005a338: 1e654008    	frintm	d8, d0
10005a33c: fd466f60    	ldr	d0, [x27, #0xcd8]
10005a340: 1e602100    	fcmp	d8, d0
10005a344: 5400054d    	b.le	0x10005a3ec <_PFMoveToApplicationsFolderIfNecessary+0x554>
10005a348: 528001e0    	mov	w0, #0xf                ; =15
10005a34c: 529fffe1    	mov	w1, #0xffff             ; =65535
10005a350: 52800022    	mov	w2, #0x1                ; =1
10005a354: 94002c13    	bl	0x1000653a0    ; import "_NSSearchPathForDirectoriesInDomains"
10005a358: aa0003fa    	mov	x26, x0
10005a35c: 6f00e400    	movi.2d	v0, #0000000000000000
10005a360: ad0c83e0    	stp	q0, q0, [sp, #0x190]
10005a364: ad0d83e0    	stp	q0, q0, [sp, #0x1b0]
10005a368: 910643e2    	add	x2, sp, #0x190
10005a36c: d103c3a3    	sub	x3, x29, #0xf0
10005a370: 52800204    	mov	w4, #0x10               ; =16
10005a374: 94003acb    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a378: b4000340    	cbz	x0, 0x10005a3e0 <_PFMoveToApplicationsFolderIfNecessary+0x548>
10005a37c: aa0003fb    	mov	x27, x0
10005a380: f940d3e8    	ldr	x8, [sp, #0x1a0]
10005a384: f9400117    	ldr	x23, [x8]
10005a388: d2800014    	mov	x20, #0x0               ; =0
10005a38c: f940d3e8    	ldr	x8, [sp, #0x1a0]
10005a390: f9400108    	ldr	x8, [x8]
10005a394: eb17011f    	cmp	x8, x23
10005a398: 54000060    	b.eq	0x10005a3a4 <_PFMoveToApplicationsFolderIfNecessary+0x50c>
10005a39c: aa1a03e0    	mov	x0, x26
10005a3a0: 94002ce1    	bl	0x100065724    ; import "_objc_enumerationMutation"
10005a3a4: f940cfe8    	ldr	x8, [sp, #0x198]
10005a3a8: f8747901    	ldr	x1, [x8, x20, lsl #3]
10005a3ac: aa1303e0    	mov	x0, x19
10005a3b0: 94000238    	bl	0x10005ac90 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
10005a3b4: 350003a0    	cbnz	w0, 0x10005a428 <_PFMoveToApplicationsFolderIfNecessary+0x590>
10005a3b8: 91000694    	add	x20, x20, #0x1
10005a3bc: eb14037f    	cmp	x27, x20
10005a3c0: 54fffe61    	b.ne	0x10005a38c <_PFMoveToApplicationsFolderIfNecessary+0x4f4>
10005a3c4: 910643e2    	add	x2, sp, #0x190
10005a3c8: d103c3a3    	sub	x3, x29, #0xf0
10005a3cc: aa1a03e0    	mov	x0, x26
10005a3d0: 52800204    	mov	w4, #0x10               ; =16
10005a3d4: 94003ab3    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a3d8: aa0003fb    	mov	x27, x0
10005a3dc: b5fffd60    	cbnz	x0, 0x10005a388 <_PFMoveToApplicationsFolderIfNecessary+0x4f0>
10005a3e0: d0000357    	adrp	x23, 0x1000c4000
10005a3e4: f000021b    	adrp	x27, 0x10009d000
10005a3e8: 14000024    	b	0x10005a478 <_PFMoveToApplicationsFolderIfNecessary+0x5e0>
10005a3ec: aa1303e0    	mov	x0, x19
10005a3f0: 940068bc    	bl	0x1000746e0 <_objc_msgSend$stringByDeletingLastPathComponent>    ; data "_objc_msgSend$stringByDeletingLastPathComponent"
10005a3f4: 94004c53    	bl	0x10006d540 <_objc_msgSend$lastPathComponent>    ; data "_objc_msgSend$lastPathComponent"
10005a3f8: d0000262    	adrp	x2, 0x1000a8000
10005a3fc: 9115e042    	add	x2, x2, #0x578    ; cfstr "Downloads"
10005a400: 940049b8    	bl	0x10006cae0 <_objc_msgSend$isEqualToString:>    ; data "_objc_msgSend$isEqualToString:"
10005a404: 35000160    	cbnz	w0, 0x10005a430 <_PFMoveToApplicationsFolderIfNecessary+0x598>
10005a408: 1400001c    	b	0x10005a478 <_PFMoveToApplicationsFolderIfNecessary+0x5e0>
10005a40c: aa1503e0    	mov	x0, x21
10005a410: 94006904    	bl	0x100074820 <_objc_msgSend$stringByResolvingSymlinksAndAliases>    ; data "_objc_msgSend$stringByResolvingSymlinksAndAliases"
10005a414: aa0003f8    	mov	x24, x0
10005a418: d0000279    	adrp	x25, 0x1000a8000
10005a41c: 910c6339    	add	x25, x25, #0x318    ; cfstr "Move to Applications folder in your Home folder?"
10005a420: f94013f7    	ldr	x23, [sp, #0x20]
10005a424: 17ffff76    	b	0x10005a1fc <_PFMoveToApplicationsFolderIfNecessary+0x364>
10005a428: d0000357    	adrp	x23, 0x1000c4000
10005a42c: f000021b    	adrp	x27, 0x10009d000
10005a430: d0000222    	adrp	x2, 0x1000a0000
10005a434: 9138e042    	add	x2, x2, #0xe38    ; cfstr " "
10005a438: aa1903e0    	mov	x0, x25
10005a43c: 94006891    	bl	0x100074680 <_objc_msgSend$stringByAppendingString:>    ; data "_objc_msgSend$stringByAppendingString:"
10005a440: aa0003f9    	mov	x25, x0
10005a444: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a448: 94004e7e    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a44c: d0000262    	adrp	x2, 0x1000a8000
10005a450: 910ee042    	add	x2, x2, #0x3b8    ; cfstr "This will keep your Downloads folder uncluttered."
10005a454: d0000223    	adrp	x3, 0x1000a0000
10005a458: 91396063    	add	x3, x3, #0xe58    ; cfstr ""
10005a45c: d0000264    	adrp	x4, 0x1000a8000
10005a460: 910ce084    	add	x4, x4, #0x338    ; cfstr "MoveApplication"
10005a464: 94004dd7    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a468: aa0003e2    	mov	x2, x0
10005a46c: aa1903e0    	mov	x0, x25
10005a470: 94006884    	bl	0x100074680 <_objc_msgSend$stringByAppendingString:>    ; data "_objc_msgSend$stringByAppendingString:"
10005a474: aa0003f9    	mov	x25, x0
10005a478: aa1803e0    	mov	x0, x24
10005a47c: aa1903e2    	mov	x2, x25
10005a480: 94005fb8    	bl	0x100072360 <_objc_msgSend$setInformativeText:>    ; data "_objc_msgSend$setInformativeText:"
10005a484: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a488: 94004e6e    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a48c: d0000262    	adrp	x2, 0x1000a8000
10005a490: 910f6042    	add	x2, x2, #0x3d8    ; cfstr "Move to Applications Folder"
10005a494: d0000239    	adrp	x25, 0x1000a0000
10005a498: 91396339    	add	x25, x25, #0xe58    ; cfstr ""
10005a49c: d000027a    	adrp	x26, 0x1000a8000
10005a4a0: 910ce35a    	add	x26, x26, #0x338    ; cfstr "MoveApplication"
10005a4a4: aa1903e3    	mov	x3, x25
10005a4a8: aa1a03e4    	mov	x4, x26
10005a4ac: 94004dc5    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a4b0: aa0003e2    	mov	x2, x0
10005a4b4: aa1803e0    	mov	x0, x24
10005a4b8: 940030b2    	bl	0x100066780 <_objc_msgSend$addButtonWithTitle:>    ; data "_objc_msgSend$addButtonWithTitle:"
10005a4bc: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a4c0: 94004e60    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a4c4: d0000262    	adrp	x2, 0x1000a8000
10005a4c8: 910fe042    	add	x2, x2, #0x3f8    ; cfstr "Do Not Move"
10005a4cc: aa1903e3    	mov	x3, x25
10005a4d0: aa1a03e4    	mov	x4, x26
10005a4d4: 94004dbb    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a4d8: aa0003e2    	mov	x2, x0
10005a4dc: aa1803e0    	mov	x0, x24
10005a4e0: 940030a8    	bl	0x100066780 <_objc_msgSend$addButtonWithTitle:>    ; data "_objc_msgSend$addButtonWithTitle:"
10005a4e4: d0000262    	adrp	x2, 0x1000a8000
10005a4e8: 91106042    	add	x2, x2, #0x418    ; cfstr "\u001b"
10005a4ec: 9400605d    	bl	0x100072660 <_objc_msgSend$setKeyEquivalent:>    ; data "_objc_msgSend$setKeyEquivalent:"
10005a4f0: fd466f69    	ldr	d9, [x27, #0xcd8]
10005a4f4: 1e692100    	fcmp	d8, d9
10005a4f8: 540002cd    	b.le	0x10005a550 <_PFMoveToApplicationsFolderIfNecessary+0x6b8>
10005a4fc: aa1803e0    	mov	x0, x24
10005a500: 52800022    	mov	w2, #0x1                ; =1
10005a504: 940063af    	bl	0x1000733c0 <_objc_msgSend$setShowsSuppressionButton:>    ; data "_objc_msgSend$setShowsSuppressionButton:"
10005a508: aa1803e0    	mov	x0, x24
10005a50c: 940069b5    	bl	0x100074be0 <_objc_msgSend$suppressionButton>    ; data "_objc_msgSend$suppressionButton"
10005a510: 940037a4    	bl	0x1000683a0 <_objc_msgSend$cell>    ; data "_objc_msgSend$cell"
10005a514: 52800022    	mov	w2, #0x1                ; =1
10005a518: 94005d12    	bl	0x100071960 <_objc_msgSend$setControlSize:>    ; data "_objc_msgSend$setControlSize:"
10005a51c: aa1803e0    	mov	x0, x24
10005a520: 940069b0    	bl	0x100074be0 <_objc_msgSend$suppressionButton>    ; data "_objc_msgSend$suppressionButton"
10005a524: 9400379f    	bl	0x1000683a0 <_objc_msgSend$cell>    ; data "_objc_msgSend$cell"
10005a528: aa0003f9    	mov	x25, x0
10005a52c: d0000348    	adrp	x8, 0x1000c4000
10005a530: f946151a    	ldr	x26, [x8, #0xc28]    ; class "NSFont"
10005a534: aa1a03e0    	mov	x0, x26
10005a538: 940066ba    	bl	0x100074020 <_objc_msgSend$smallSystemFontSize>    ; data "_objc_msgSend$smallSystemFontSize"
10005a53c: aa1a03e0    	mov	x0, x26
10005a540: 940069d0    	bl	0x100074c80 <_objc_msgSend$systemFontOfSize:>    ; data "_objc_msgSend$systemFontOfSize:"
10005a544: aa0003e2    	mov	x2, x0
10005a548: aa1903e0    	mov	x0, x25
10005a54c: 94005e95    	bl	0x100071fa0 <_objc_msgSend$setFont:>    ; data "_objc_msgSend$setFont:"
10005a550: d0000234    	adrp	x20, 0x1000a0000
10005a554: f9400e94    	ldr	x20, [x20, #0x18]    ; import "_NSApp"
10005a558: f9400280    	ldr	x0, [x20]
10005a55c: 940048d9    	bl	0x10006c8c0 <_objc_msgSend$isActive>    ; data "_objc_msgSend$isActive"
10005a560: 37000080    	tbnz	w0, #0x0, 0x10005a570 <_PFMoveToApplicationsFolderIfNecessary+0x6d8>
10005a564: f9400280    	ldr	x0, [x20]
10005a568: 52800022    	mov	w2, #0x1                ; =1
10005a56c: 94003045    	bl	0x100066680 <_objc_msgSend$activateIgnoringOtherApps:>    ; data "_objc_msgSend$activateIgnoringOtherApps:"
10005a570: aa1803e0    	mov	x0, x24
10005a574: 940058db    	bl	0x1000708e0 <_objc_msgSend$runModal>    ; data "_objc_msgSend$runModal"
10005a578: aa0003f9    	mov	x25, x0
10005a57c: 1e692100    	fcmp	d8, d9
10005a580: 5400022d    	b.le	0x10005a5c4 <_PFMoveToApplicationsFolderIfNecessary+0x72c>
10005a584: aa1803e0    	mov	x0, x24
10005a588: 94006996    	bl	0x100074be0 <_objc_msgSend$suppressionButton>    ; data "_objc_msgSend$suppressionButton"
10005a58c: 940067cd    	bl	0x1000744c0 <_objc_msgSend$state>    ; data "_objc_msgSend$state"
10005a590: f100041f    	cmp	x0, #0x1
10005a594: b9402ff4    	ldr	w20, [sp, #0x2c]
10005a598: 54000101    	b.ne	0x10005a5b8 <_PFMoveToApplicationsFolderIfNecessary+0x720>
10005a59c: d0000263    	adrp	x3, 0x1000a8000
10005a5a0: 91146063    	add	x3, x3, #0x518    ; cfstr "moveToApplicationsFolderAlertSuppress"
10005a5a4: aa1603e0    	mov	x0, x22
10005a5a8: 52800022    	mov	w2, #0x1                ; =1
10005a5ac: 94005b8d    	bl	0x1000713e0 <_objc_msgSend$setBool:forKey:>    ; data "_objc_msgSend$setBool:forKey:"
10005a5b0: aa1603e0    	mov	x0, x22
10005a5b4: 9400699b    	bl	0x100074c20 <_objc_msgSend$synchronize>    ; data "_objc_msgSend$synchronize"
10005a5b8: f10fa33f    	cmp	x25, #0x3e8
10005a5bc: 54ffc981    	b.ne	0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
10005a5c0: 14000004    	b	0x10005a5d0 <_PFMoveToApplicationsFolderIfNecessary+0x738>
10005a5c4: f10fa33f    	cmp	x25, #0x3e8
10005a5c8: b9402ff4    	ldr	w20, [sp, #0x2c]
10005a5cc: 54000a41    	b.ne	0x10005a714 <_PFMoveToApplicationsFolderIfNecessary+0x87c>
10005a5d0: d0000260    	adrp	x0, 0x1000a8000
10005a5d4: 9110e000    	add	x0, x0, #0x438    ; cfstr "INFO -- Moving myself to the Applications folder"
10005a5d8: 97ff9c85    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
10005a5dc: 34000ad4    	cbz	w20, 0x10005a734 <_PFMoveToApplicationsFolderIfNecessary+0x89c>
10005a5e0: d0000262    	adrp	x2, 0x1000a8000
10005a5e4: 91176042    	add	x2, x2, #0x5d8    ; cfstr ".app"
10005a5e8: aa1503e0    	mov	x0, x21
10005a5ec: 94004375    	bl	0x10006b3c0 <_objc_msgSend$hasSuffix:>    ; data "_objc_msgSend$hasSuffix:"
10005a5f0: 340008a0    	cbz	w0, 0x10005a704 <_PFMoveToApplicationsFolderIfNecessary+0x86c>
10005a5f4: d0000354    	adrp	x20, 0x1000c4000
10005a5f8: f946da80    	ldr	x0, [x20, #0xdb0]    ; class "NSCharacterSet"
10005a5fc: 94006e31    	bl	0x100075ec0 <_objc_msgSend$whitespaceCharacterSet>    ; data "_objc_msgSend$whitespaceCharacterSet"
10005a600: aa0003e2    	mov	x2, x0
10005a604: aa1503e0    	mov	x0, x21
10005a608: 94006896    	bl	0x100074860 <_objc_msgSend$stringByTrimmingCharactersInSet:>    ; data "_objc_msgSend$stringByTrimmingCharactersInSet:"
10005a60c: 94004cb5    	bl	0x10006d8e0 <_objc_msgSend$length>    ; data "_objc_msgSend$length"
10005a610: b40007a0    	cbz	x0, 0x10005a704 <_PFMoveToApplicationsFolderIfNecessary+0x86c>
10005a614: f946da80    	ldr	x0, [x20, #0xdb0]    ; class "NSCharacterSet"
10005a618: 94006e2a    	bl	0x100075ec0 <_objc_msgSend$whitespaceCharacterSet>    ; data "_objc_msgSend$whitespaceCharacterSet"
10005a61c: aa0003e2    	mov	x2, x0
10005a620: aa1303e0    	mov	x0, x19
10005a624: 9400688f    	bl	0x100074860 <_objc_msgSend$stringByTrimmingCharactersInSet:>    ; data "_objc_msgSend$stringByTrimmingCharactersInSet:"
10005a628: 94004cae    	bl	0x10006d8e0 <_objc_msgSend$length>    ; data "_objc_msgSend$length"
10005a62c: b40006c0    	cbz	x0, 0x10005a704 <_PFMoveToApplicationsFolderIfNecessary+0x86c>
10005a630: 910203e3    	add	x3, sp, #0x80
10005a634: d2800000    	mov	x0, #0x0                ; =0
10005a638: d2800001    	mov	x1, #0x0                ; =0
10005a63c: 52800002    	mov	w2, #0x0                ; =0
10005a640: 94002a95    	bl	0x100065094    ; import "_AuthorizationCreate"
10005a644: 35000600    	cbnz	w0, 0x10005a704 <_PFMoveToApplicationsFolderIfNecessary+0x86c>
10005a648: d0000228    	adrp	x8, 0x1000a0000
10005a64c: 9134a108    	add	x8, x8, #0xd28
10005a650: ad400500    	ldp	q0, q1, [x8]
10005a654: ad0c87e0    	stp	q0, q1, [sp, #0x190]
10005a658: 52800028    	mov	w8, #0x1                ; =1
10005a65c: b900c3e8    	str	w8, [sp, #0xc0]
10005a660: 910643e8    	add	x8, sp, #0x190
10005a664: f90067e8    	str	x8, [sp, #0xc8]
10005a668: f94043e0    	ldr	x0, [sp, #0x80]
10005a66c: 910303e1    	add	x1, sp, #0xc0
10005a670: d2800002    	mov	x2, #0x0                ; =0
10005a674: 52800263    	mov	w3, #0x13               ; =19
10005a678: d2800004    	mov	x4, #0x0                ; =0
10005a67c: 94002a83    	bl	0x100065088    ; import "_AuthorizationCopyRights"
10005a680: 129d4ca8    	mov	w8, #-0xea66            ; =-60006
10005a684: 6b08001f    	cmp	w0, w8
10005a688: 54001680    	b.eq	0x10005a958 <_PFMoveToApplicationsFolderIfNecessary+0xac0>
10005a68c: 35000360    	cbnz	w0, 0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a690: d0000374    	adrp	x20, 0x1000c8000 <__OBJC_PROTOCOL_$_CXUpdaterDelegate+0x30>
10005a694: f9422688    	ldr	x8, [x20, #0x448]    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10005a698: b50000e8    	cbnz	x8, 0x10005a6b4 <_PFMoveToApplicationsFolderIfNecessary+0x81c>
10005a69c: f00001e1    	adrp	x1, 0x100099000
10005a6a0: 91064821    	add	x1, x1, #0x192    ; str "AuthorizationExecuteWithPrivileges"
10005a6a4: 92800020    	mov	x0, #-0x2               ; =-2
10005a6a8: 94002bd7    	bl	0x100065604    ; import "_dlsym"
10005a6ac: f9022680    	str	x0, [x20, #0x448]
10005a6b0: b4000240    	cbz	x0, 0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a6b4: f00001e8    	adrp	x8, 0x100099000
10005a6b8: 9106d508    	add	x8, x8, #0x1b5    ; str "-rf"
10005a6bc: b00001d6    	adrp	x22, 0x100093000
10005a6c0: 913e2ad6    	add	x22, x22, #0xf8a    ; str "--"
10005a6c4: a9315ba8    	stp	x8, x22, [x29, #-0xf0]
10005a6c8: aa1503e0    	mov	x0, x21
10005a6cc: 94004065    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005a6d0: a9327fa0    	stp	x0, xzr, [x29, #-0xe0]
10005a6d4: f9422688    	ldr	x8, [x20, #0x448]    ; data "_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges"
10005a6d8: f94043e0    	ldr	x0, [sp, #0x80]
10005a6dc: f00001e1    	adrp	x1, 0x100099000
10005a6e0: 9106e421    	add	x1, x1, #0x1b9    ; str "/bin/rm"
10005a6e4: d103c3a3    	sub	x3, x29, #0xf0
10005a6e8: 52800002    	mov	w2, #0x0                ; =0
10005a6ec: d2800004    	mov	x4, #0x0                ; =0
10005a6f0: d63f0100    	blr	x8
10005a6f4: 34001400    	cbz	w0, 0x10005a974 <_PFMoveToApplicationsFolderIfNecessary+0xadc>
10005a6f8: f94043e0    	ldr	x0, [sp, #0x80]
10005a6fc: 52800001    	mov	w1, #0x0                ; =0
10005a700: 94002a6b    	bl	0x1000650ac    ; import "_AuthorizationFree"
10005a704: d0000260    	adrp	x0, 0x1000a8000
10005a708: 9111e000    	add	x0, x0, #0x478    ; cfstr "ERROR -- Could not copy myself to /Applications with authorization"
10005a70c: 94002b19    	bl	0x100065370    ; import "_NSLog"
10005a710: 1400007f    	b	0x10005a90c <_PFMoveToApplicationsFolderIfNecessary+0xa74>
10005a714: d0000263    	adrp	x3, 0x1000a8000
10005a718: 91146063    	add	x3, x3, #0x518    ; cfstr "moveToApplicationsFolderAlertSuppress"
10005a71c: aa1603e0    	mov	x0, x22
10005a720: 52800022    	mov	w2, #0x1                ; =1
10005a724: 94005b2f    	bl	0x1000713e0 <_objc_msgSend$setBool:forKey:>    ; data "_objc_msgSend$setBool:forKey:"
10005a728: aa1603e0    	mov	x0, x22
10005a72c: 9400693d    	bl	0x100074c20 <_objc_msgSend$synchronize>    ; data "_objc_msgSend$synchronize"
10005a730: 17fffdef    	b	0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
10005a734: f94013e0    	ldr	x0, [sp, #0x20]
10005a738: aa1503e2    	mov	x2, x21
10005a73c: 94004011    	bl	0x10006a780 <_objc_msgSend$fileExistsAtPath:>    ; data "_objc_msgSend$fileExistsAtPath:"
10005a740: 340005c0    	cbz	w0, 0x10005a7f8 <_PFMoveToApplicationsFolderIfNecessary+0x960>
10005a744: aa1703fa    	mov	x26, x23
10005a748: 6f00e400    	movi.2d	v0, #0000000000000000
10005a74c: ad0283e0    	stp	q0, q0, [sp, #0x50]
10005a750: ad0183e0    	stp	q0, q0, [sp, #0x30]
10005a754: d0000354    	adrp	x20, 0x1000c4000
10005a758: f9467e80    	ldr	x0, [x20, #0xcf8]    ; class "NSWorkspace"
10005a75c: 940065b1    	bl	0x100073e20 <_objc_msgSend$sharedWorkspace>    ; data "_objc_msgSend$sharedWorkspace"
10005a760: 94005888    	bl	0x100070980 <_objc_msgSend$runningApplications>    ; data "_objc_msgSend$runningApplications"
10005a764: aa0003f6    	mov	x22, x0
10005a768: 9100c3e2    	add	x2, sp, #0x30
10005a76c: 910443e3    	add	x3, sp, #0x110
10005a770: 52800204    	mov	w4, #0x10               ; =16
10005a774: 940039cb    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a778: b4000380    	cbz	x0, 0x10005a7e8 <_PFMoveToApplicationsFolderIfNecessary+0x950>
10005a77c: aa0003f7    	mov	x23, x0
10005a780: f94023e8    	ldr	x8, [sp, #0x40]
10005a784: f9400118    	ldr	x24, [x8]
10005a788: d2800019    	mov	x25, #0x0               ; =0
10005a78c: f94023e8    	ldr	x8, [sp, #0x40]
10005a790: f9400108    	ldr	x8, [x8]
10005a794: eb18011f    	cmp	x8, x24
10005a798: 54000060    	b.eq	0x10005a7a4 <_PFMoveToApplicationsFolderIfNecessary+0x90c>
10005a79c: aa1603e0    	mov	x0, x22
10005a7a0: 94002be1    	bl	0x100065724    ; import "_objc_enumerationMutation"
10005a7a4: f9401fe8    	ldr	x8, [sp, #0x38]
10005a7a8: f8797900    	ldr	x0, [x8, x25, lsl #3]
10005a7ac: 94003f5d    	bl	0x10006a520 <_objc_msgSend$executableURL>    ; data "_objc_msgSend$executableURL"
10005a7b0: 940051fc    	bl	0x10006efa0 <_objc_msgSend$path>    ; data "_objc_msgSend$path"
10005a7b4: aa1503e1    	mov	x1, x21
10005a7b8: 94000136    	bl	0x10005ac90 <_PathIsWithinPath>    ; call "_PathIsWithinPath"
10005a7bc: 37001240    	tbnz	w0, #0x0, 0x10005aa04 <_PFMoveToApplicationsFolderIfNecessary+0xb6c>
10005a7c0: 91000739    	add	x25, x25, #0x1
10005a7c4: eb1902ff    	cmp	x23, x25
10005a7c8: 54fffe21    	b.ne	0x10005a78c <_PFMoveToApplicationsFolderIfNecessary+0x8f4>
10005a7cc: 9100c3e2    	add	x2, sp, #0x30
10005a7d0: 910443e3    	add	x3, sp, #0x110
10005a7d4: aa1603e0    	mov	x0, x22
10005a7d8: 52800204    	mov	w4, #0x10               ; =16
10005a7dc: 940039b1    	bl	0x100068ea0 <_objc_msgSend$countByEnumeratingWithState:objects:count:>    ; data "_objc_msgSend$countByEnumeratingWithState:objects:count:"
10005a7e0: aa0003f7    	mov	x23, x0
10005a7e4: b5fffd20    	cbnz	x0, 0x10005a788 <_PFMoveToApplicationsFolderIfNecessary+0x8f0>
10005a7e8: aa1503e0    	mov	x0, x21
10005a7ec: 9400014e    	bl	0x10005ad24 <_Trash>    ; call "_Trash"
10005a7f0: aa1a03f7    	mov	x23, x26
10005a7f4: 340008c0    	cbz	w0, 0x10005a90c <_PFMoveToApplicationsFolderIfNecessary+0xa74>
10005a7f8: aa1703f9    	mov	x25, x23
10005a7fc: d0000354    	adrp	x20, 0x1000c4000
10005a800: f9468280    	ldr	x0, [x20, #0xd00]    ; class "NSFileManager"
10005a804: 94003b6f    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005a808: aa0003f6    	mov	x22, x0
10005a80c: aa1303e2    	mov	x2, x19
10005a810: d2800003    	mov	x3, #0x0                ; =0
10005a814: 94003333    	bl	0x1000674e0 <_objc_msgSend$attributesOfFileSystemForPath:error:>    ; data "_objc_msgSend$attributesOfFileSystemForPath:error:"
10005a818: d0000228    	adrp	x8, 0x1000a0000
10005a81c: f9408508    	ldr	x8, [x8, #0x108]    ; import "_NSFileSystemNumber"
10005a820: f9400117    	ldr	x23, [x8]
10005a824: aa1703e2    	mov	x2, x23
10005a828: 94005056    	bl	0x10006e980 <_objc_msgSend$objectForKey:>    ; data "_objc_msgSend$objectForKey:"
10005a82c: aa0003f8    	mov	x24, x0
10005a830: aa1503e0    	mov	x0, x21
10005a834: 940067ab    	bl	0x1000746e0 <_objc_msgSend$stringByDeletingLastPathComponent>    ; data "_objc_msgSend$stringByDeletingLastPathComponent"
10005a838: aa0003e2    	mov	x2, x0
10005a83c: aa1603e0    	mov	x0, x22
10005a840: d2800003    	mov	x3, #0x0                ; =0
10005a844: 94003327    	bl	0x1000674e0 <_objc_msgSend$attributesOfFileSystemForPath:error:>    ; data "_objc_msgSend$attributesOfFileSystemForPath:error:"
10005a848: aa1703e2    	mov	x2, x23
10005a84c: 9400504d    	bl	0x10006e980 <_objc_msgSend$objectForKey:>    ; data "_objc_msgSend$objectForKey:"
10005a850: aa0003e2    	mov	x2, x0
10005a854: aa1803e0    	mov	x0, x24
10005a858: 94004872    	bl	0x10006ca20 <_objc_msgSend$isEqual:>    ; data "_objc_msgSend$isEqual:"
10005a85c: 360001c0    	tbz	w0, #0x0, 0x10005a894 <_PFMoveToApplicationsFolderIfNecessary+0x9fc>
10005a860: f81103bf    	stur	xzr, [x29, #-0xf0]
10005a864: d103c3a4    	sub	x4, x29, #0xf0
10005a868: aa1603e0    	mov	x0, x22
10005a86c: aa1303e2    	mov	x2, x19
10005a870: aa1503e3    	mov	x3, x21
10005a874: 94004e9b    	bl	0x10006e2e0 <_objc_msgSend$moveItemAtPath:toPath:error:>    ; data "_objc_msgSend$moveItemAtPath:toPath:error:"
10005a878: 35000f40    	cbnz	w0, 0x10005aa60 <_PFMoveToApplicationsFolderIfNecessary+0xbc8>
10005a87c: f85103a8    	ldur	x8, [x29, #-0xf0]
10005a880: a900a3f5    	stp	x21, x8, [sp, #0x8]
10005a884: f90003f3    	str	x19, [sp]
10005a888: d0000260    	adrp	x0, 0x1000a8000
10005a88c: 9118e000    	add	x0, x0, #0x638    ; cfstr "WARNING -- Could not move '%@' to '%@' (%@)"
10005a890: 14000004    	b	0x10005a8a0 <_PFMoveToApplicationsFolderIfNecessary+0xa08>
10005a894: a90057f3    	stp	x19, x21, [sp]
10005a898: d0000260    	adrp	x0, 0x1000a8000
10005a89c: 91186000    	add	x0, x0, #0x618    ; cfstr "INFO -- Not moving '%@' to '%@' on different file system"
10005a8a0: 97ff9bd3    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
10005a8a4: aa1303e0    	mov	x0, x19
10005a8a8: 94003fee    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005a8ac: aa0003f6    	mov	x22, x0
10005a8b0: aa1503e0    	mov	x0, x21
10005a8b4: 9400678b    	bl	0x1000746e0 <_objc_msgSend$stringByDeletingLastPathComponent>    ; data "_objc_msgSend$stringByDeletingLastPathComponent"
10005a8b8: 94003fea    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005a8bc: aa0003f7    	mov	x23, x0
10005a8c0: aa1503e0    	mov	x0, x21
10005a8c4: 94004b1f    	bl	0x10006d540 <_objc_msgSend$lastPathComponent>    ; data "_objc_msgSend$lastPathComponent"
10005a8c8: aa0003e2    	mov	x2, x0
10005a8cc: aa1603e0    	mov	x0, x22
10005a8d0: aa1703e1    	mov	x1, x23
10005a8d4: d2800003    	mov	x3, #0x0                ; =0
10005a8d8: 52800004    	mov	w4, #0x0                ; =0
10005a8dc: 94002a66    	bl	0x100065274    ; import "_FSPathCopyObjectSync"
10005a8e0: 34000a60    	cbz	w0, 0x10005aa2c <_PFMoveToApplicationsFolderIfNecessary+0xb94>
10005a8e4: a90083f5    	stp	x21, x0, [sp, #0x8]
10005a8e8: f90003f3    	str	x19, [sp]
10005a8ec: d0000260    	adrp	x0, 0x1000a8000
10005a8f0: 9117e000    	add	x0, x0, #0x5f8    ; cfstr "ERROR -- Could not copy '%@' to '%@' (%d)"
10005a8f4: 94002a9f    	bl	0x100065370    ; import "_NSLog"
10005a8f8: f90003f5    	str	x21, [sp]
10005a8fc: d0000260    	adrp	x0, 0x1000a8000
10005a900: 9112e000    	add	x0, x0, #0x4b8    ; cfstr "ERROR -- Could not copy myself to %@"
10005a904: 94002a9b    	bl	0x100065370    ; import "_NSLog"
10005a908: aa1903f7    	mov	x23, x25
10005a90c: f94696e0    	ldr	x0, [x23, #0xd28]    ; class "NSAlert"
10005a910: 94002b6a    	bl	0x1000656b8    ; import "_objc_alloc_init"
10005a914: 94002b6c    	bl	0x1000656c4    ; import "_objc_autorelease"
10005a918: aa0003f3    	mov	x19, x0
10005a91c: f9465780    	ldr	x0, [x28, #0xca8]    ; class "NSBundle"
10005a920: 94004d48    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005a924: d0000262    	adrp	x2, 0x1000a8000
10005a928: 9113e042    	add	x2, x2, #0x4f8    ; cfstr "Could not move to Applications folder"
10005a92c: d0000223    	adrp	x3, 0x1000a0000
10005a930: 91396063    	add	x3, x3, #0xe58    ; cfstr ""
10005a934: d0000264    	adrp	x4, 0x1000a8000
10005a938: 910ce084    	add	x4, x4, #0x338    ; cfstr "MoveApplication"
10005a93c: 94004ca1    	bl	0x10006dbc0 <_objc_msgSend$localizedStringForKey:value:table:>    ; data "_objc_msgSend$localizedStringForKey:value:table:"
10005a940: aa0003e2    	mov	x2, x0
10005a944: aa1303e0    	mov	x0, x19
10005a948: 94006036    	bl	0x100072a20 <_objc_msgSend$setMessageText:>    ; data "_objc_msgSend$setMessageText:"
10005a94c: aa1303e0    	mov	x0, x19
10005a950: 940057e4    	bl	0x1000708e0 <_objc_msgSend$runModal>    ; data "_objc_msgSend$runModal"
10005a954: 17fffd66    	b	0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
10005a958: f94043e0    	ldr	x0, [sp, #0x80]
10005a95c: 52800001    	mov	w1, #0x0                ; =0
10005a960: 940029d3    	bl	0x1000650ac    ; import "_AuthorizationFree"
10005a964: d0000260    	adrp	x0, 0x1000a8000
10005a968: 91116000    	add	x0, x0, #0x458    ; cfstr "INFO -- Not moving because user canceled authorization"
10005a96c: 97ff9ba0    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
10005a970: 17fffd5f    	b	0x100059eec <_PFMoveToApplicationsFolderIfNecessary+0x54>
10005a974: 910433e0    	add	x0, sp, #0x10c
10005a978: 94002be9    	bl	0x10006591c    ; import "_wait"
10005a97c: 3100041f    	cmn	w0, #0x1
10005a980: 54ffebc0    	b.eq	0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a984: 394433e8    	ldrb	w8, [sp, #0x10c]
10005a988: 7200191f    	tst	w8, #0x7f
10005a98c: 54ffeb61    	b.ne	0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a990: d00001e8    	adrp	x8, 0x100098000
10005a994: 91038d08    	add	x8, x8, #0xe3    ; str "--noqtn"
10005a998: a9315ba8    	stp	x8, x22, [x29, #-0xf0]
10005a99c: aa1303e0    	mov	x0, x19
10005a9a0: 94003fb0    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005a9a4: f81203a0    	stur	x0, [x29, #-0xe0]
10005a9a8: aa1503e0    	mov	x0, x21
10005a9ac: 94003fad    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005a9b0: a932ffa0    	stp	x0, xzr, [x29, #-0xd8]
10005a9b4: f9422688    	ldr	x8, [x20, #0x448]    ; sel "loading"
10005a9b8: f94043e0    	ldr	x0, [sp, #0x80]
10005a9bc: d00001e1    	adrp	x1, 0x100098000
10005a9c0: 91034421    	add	x1, x1, #0xd1    ; str "/usr/bin/ditto"
10005a9c4: d103c3a3    	sub	x3, x29, #0xf0
10005a9c8: 52800002    	mov	w2, #0x0                ; =0
10005a9cc: d2800004    	mov	x4, #0x0                ; =0
10005a9d0: d63f0100    	blr	x8
10005a9d4: 35ffe920    	cbnz	w0, 0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a9d8: 910433e0    	add	x0, sp, #0x10c
10005a9dc: 94002bd0    	bl	0x10006591c    ; import "_wait"
10005a9e0: 3100041f    	cmn	w0, #0x1
10005a9e4: 54ffe8a0    	b.eq	0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a9e8: 79421be8    	ldrh	w8, [sp, #0x10c]
10005a9ec: 7218791f    	tst	w8, #0xffffff7f
10005a9f0: 54ffe841    	b.ne	0x10005a6f8 <_PFMoveToApplicationsFolderIfNecessary+0x860>
10005a9f4: f94043e0    	ldr	x0, [sp, #0x80]
10005a9f8: 52800001    	mov	w1, #0x0                ; =0
10005a9fc: 940029ac    	bl	0x1000650ac    ; import "_AuthorizationFree"
10005aa00: 1400000f    	b	0x10005aa3c <_PFMoveToApplicationsFolderIfNecessary+0xba4>
10005aa04: d0000260    	adrp	x0, 0x1000a8000
10005aa08: 91126000    	add	x0, x0, #0x498    ; cfstr "INFO -- Switching to an already running version"
10005aa0c: 97ff9b78    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
10005aa10: f9467e80    	ldr	x0, [x20, #0xcf8]    ; class "NSWorkspace"
10005aa14: 94006503    	bl	0x100073e20 <_objc_msgSend$sharedWorkspace>    ; data "_objc_msgSend$sharedWorkspace"
10005aa18: aa1503e2    	mov	x2, x21
10005aa1c: 94005031    	bl	0x10006eae0 <_objc_msgSend$openFile:>    ; data "_objc_msgSend$openFile:"
10005aa20: 52800000    	mov	w0, #0x0                ; =0
10005aa24: 94002afb    	bl	0x100065610    ; import "_exit"
10005aa28: 94002abb    	bl	0x100065514    ; import "___stack_chk_fail"
10005aa2c: f9468280    	ldr	x0, [x20, #0xd00]    ; class "NSFileManager"
10005aa30: 94003ae4    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005aa34: aa1503e2    	mov	x2, x21
10005aa38: 9400370a    	bl	0x100068660 <_objc_msgSend$clearQuarantine:>    ; data "_objc_msgSend$clearQuarantine:"
10005aa3c: b9401fe8    	ldr	w8, [sp, #0x1c]
10005aa40: 37000188    	tbnz	w8, #0x0, 0x10005aa70 <_PFMoveToApplicationsFolderIfNecessary+0xbd8>
10005aa44: aa1303e0    	mov	x0, x19
10005aa48: 940000b7    	bl	0x10005ad24 <_Trash>    ; call "_Trash"
10005aa4c: 37000120    	tbnz	w0, #0x0, 0x10005aa70 <_PFMoveToApplicationsFolderIfNecessary+0xbd8>
10005aa50: d0000260    	adrp	x0, 0x1000a8000
10005aa54: 91136000    	add	x0, x0, #0x4d8    ; cfstr "WARNING -- Could not delete application after moving it to Applications folder"
10005aa58: 97ff9b65    	bl	0x1000417ec <_CXLog>    ; call "_CXLog"
10005aa5c: 14000005    	b	0x10005aa70 <_PFMoveToApplicationsFolderIfNecessary+0xbd8>
10005aa60: f9468280    	ldr	x0, [x20, #0xd00]    ; class "NSFileManager"
10005aa64: 94003ad7    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005aa68: aa1503e2    	mov	x2, x21
10005aa6c: 940036fd    	bl	0x100068660 <_objc_msgSend$clearQuarantine:>    ; data "_objc_msgSend$clearQuarantine:"
10005aa70: d0000348    	adrp	x8, 0x1000c4000
10005aa74: f946b100    	ldr	x0, [x8, #0xd60]    ; class "NSProcessInfo"
10005aa78: 9400528a    	bl	0x10006f4a0 <_objc_msgSend$processInfo>    ; data "_objc_msgSend$processInfo"
10005aa7c: 94005281    	bl	0x10006f480 <_objc_msgSend$processIdentifier>    ; data "_objc_msgSend$processIdentifier"
10005aa80: aa0003f3    	mov	x19, x0
10005aa84: d0000356    	adrp	x22, 0x1000c4000
10005aa88: f94676d4    	ldr	x20, [x22, #0xce8]    ; class "NSString"
10005aa8c: aa1503e0    	mov	x0, x21
10005aa90: 940067b4    	bl	0x100074960 <_objc_msgSend$stringQuotedForBash>    ; data "_objc_msgSend$stringQuotedForBash"
10005aa94: a90003f3    	stp	x19, x0, [sp]
10005aa98: d0000262    	adrp	x2, 0x1000a8000
10005aa9c: 91196042    	add	x2, x2, #0x658    ; cfstr "(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &"
10005aaa0: aa1403e0    	mov	x0, x20
10005aaa4: 940067cf    	bl	0x1000749e0 <_objc_msgSend$stringWithFormat:>    ; data "_objc_msgSend$stringWithFormat:"
10005aaa8: d0000354    	adrp	x20, 0x1000c4000
10005aaac: f947be93    	ldr	x19, [x20, #0xf78]    ; class "NSTask"
10005aab0: d0000355    	adrp	x21, 0x1000c4000
10005aab4: f9465aa8    	ldr	x8, [x21, #0xcb0]    ; class "NSArray"
10005aab8: a9007fe0    	stp	x0, xzr, [sp]
10005aabc: 90000242    	adrp	x2, 0x1000a2000
10005aac0: 91176042    	add	x2, x2, #0x5d8    ; cfstr "-c"
10005aac4: aa0803e0    	mov	x0, x8
10005aac8: 94003236    	bl	0x1000673a0 <_objc_msgSend$arrayWithObjects:>    ; data "_objc_msgSend$arrayWithObjects:"
10005aacc: aa0003e3    	mov	x3, x0
10005aad0: 90000242    	adrp	x2, 0x1000a2000
10005aad4: 9116e042    	add	x2, x2, #0x5b8    ; cfstr "/bin/sh"
10005aad8: aa1303e0    	mov	x0, x19
10005aadc: 94004ae9    	bl	0x10006d680 <_objc_msgSend$launchedTaskWithLaunchPath:arguments:>    ; data "_objc_msgSend$launchedTaskWithLaunchPath:arguments:"
10005aae0: d103c3a0    	sub	x0, x29, #0xf0
10005aae4: 9400001a    	bl	0x10005ab4c <_IsLaunchedFromDMG>    ; call "_IsLaunchedFromDMG"
10005aae8: 34fff9c0    	cbz	w0, 0x10005aa20 <_PFMoveToApplicationsFolderIfNecessary+0xb88>
10005aaec: f85103a0    	ldur	x0, [x29, #-0xf0]
10005aaf0: 94004b7c    	bl	0x10006d8e0 <_objc_msgSend$length>    ; data "_objc_msgSend$length"
10005aaf4: b4fff960    	cbz	x0, 0x10005aa20 <_PFMoveToApplicationsFolderIfNecessary+0xb88>
10005aaf8: f94676d3    	ldr	x19, [x22, #0xce8]    ; class "NSString"
10005aafc: f85103a0    	ldur	x0, [x29, #-0xf0]
10005ab00: 94006798    	bl	0x100074960 <_objc_msgSend$stringQuotedForBash>    ; data "_objc_msgSend$stringQuotedForBash"
10005ab04: f90003e0    	str	x0, [sp]
10005ab08: d0000262    	adrp	x2, 0x1000a8000
10005ab0c: 9119e042    	add	x2, x2, #0x678    ; cfstr "(sleep 5 && hdiutil detach %@) &"
10005ab10: aa1303e0    	mov	x0, x19
10005ab14: 940067b3    	bl	0x1000749e0 <_objc_msgSend$stringWithFormat:>    ; data "_objc_msgSend$stringWithFormat:"
10005ab18: f947be93    	ldr	x19, [x20, #0xf78]    ; class "NSTask"
10005ab1c: f9465aa8    	ldr	x8, [x21, #0xcb0]    ; class "NSArray"
10005ab20: a9007fe0    	stp	x0, xzr, [sp]
10005ab24: 90000242    	adrp	x2, 0x1000a2000
10005ab28: 91176042    	add	x2, x2, #0x5d8    ; cfstr "-c"
10005ab2c: aa0803e0    	mov	x0, x8
10005ab30: 9400321c    	bl	0x1000673a0 <_objc_msgSend$arrayWithObjects:>    ; data "_objc_msgSend$arrayWithObjects:"
10005ab34: aa0003e3    	mov	x3, x0
10005ab38: 90000242    	adrp	x2, 0x1000a2000
10005ab3c: 9116e042    	add	x2, x2, #0x5b8    ; cfstr "/bin/sh"
10005ab40: aa1303e0    	mov	x0, x19
10005ab44: 94004acf    	bl	0x10006d680 <_objc_msgSend$launchedTaskWithLaunchPath:arguments:>    ; data "_objc_msgSend$launchedTaskWithLaunchPath:arguments:"
10005ab48: 17ffffb6    	b	0x10005aa20 <_PFMoveToApplicationsFolderIfNecessary+0xb88>


000000010005ab4c <_IsLaunchedFromDMG>:
10005ab4c: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
10005ab50: a90157f6    	stp	x22, x21, [sp, #0x10]
10005ab54: a9024ff4    	stp	x20, x19, [sp, #0x20]
10005ab58: a9037bfd    	stp	x29, x30, [sp, #0x30]
10005ab5c: 9100c3fd    	add	x29, sp, #0x30
10005ab60: d12203ff    	sub	sp, sp, #0x880
10005ab64: aa0003f3    	mov	x19, x0
10005ab68: d0000228    	adrp	x8, 0x1000a0000
10005ab6c: f9414908    	ldr	x8, [x8, #0x290]    ; import "___stack_chk_guard"
10005ab70: f9400108    	ldr	x8, [x8]
10005ab74: f81c83a8    	stur	x8, [x29, #-0x38]
10005ab78: d0000348    	adrp	x8, 0x1000c4000
10005ab7c: f9465500    	ldr	x0, [x8, #0xca8]    ; class "NSBundle"
10005ab80: 94004cb0    	bl	0x10006de40 <_objc_msgSend$mainBundle>    ; data "_objc_msgSend$mainBundle"
10005ab84: 940034e7    	bl	0x100067f20 <_objc_msgSend$bundlePath>    ; data "_objc_msgSend$bundlePath"
10005ab88: 94003f36    	bl	0x10006a860 <_objc_msgSend$fileSystemRepresentation>    ; data "_objc_msgSend$fileSystemRepresentation"
10005ab8c: 910003e1    	mov	x1, sp
10005ab90: 94002b51    	bl	0x1000658d4    ; import "_statfs"
10005ab94: 340001e0    	cbz	w0, 0x10005abd0 <_IsLaunchedFromDMG+0x84>
10005ab98: 52800014    	mov	w20, #0x0               ; =0
10005ab9c: f85c83a8    	ldur	x8, [x29, #-0x38]
10005aba0: d0000229    	adrp	x9, 0x1000a0000
10005aba4: f9414929    	ldr	x9, [x9, #0x290]    ; import "___stack_chk_guard"
10005aba8: f9400129    	ldr	x9, [x9]
10005abac: eb08013f    	cmp	x9, x8
10005abb0: 540006e1    	b.ne	0x10005ac8c <_IsLaunchedFromDMG+0x140>
10005abb4: aa1403e0    	mov	x0, x20
10005abb8: 912203ff    	add	sp, sp, #0x880
10005abbc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10005abc0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10005abc4: a94157f6    	ldp	x22, x21, [sp, #0x10]
10005abc8: a8c46ffc    	ldp	x28, x27, [sp], #0x40
10005abcc: d65f03c0    	ret
10005abd0: d2800000    	mov	x0, #0x0                ; =0
10005abd4: 94002993    	bl	0x100065220    ; import "_DASessionCreate"
10005abd8: aa0003f4    	mov	x20, x0
10005abdc: b4fffe00    	cbz	x0, 0x10005ab9c <_IsLaunchedFromDMG+0x50>
10005abe0: 910003e8    	mov	x8, sp
10005abe4: 91116102    	add	x2, x8, #0x458    ; sel "setNoResultsLabel:"
10005abe8: d2800000    	mov	x0, #0x0                ; =0
10005abec: aa1403e1    	mov	x1, x20
10005abf0: 94002989    	bl	0x100065214    ; import "_DADiskCreateFromBSDName"
10005abf4: aa0003f6    	mov	x22, x0
10005abf8: aa1403e0    	mov	x0, x20
10005abfc: 94002950    	bl	0x10006513c    ; import "_CFRelease"
10005ac00: b4fffcd6    	cbz	x22, 0x10005ab98 <_IsLaunchedFromDMG+0x4c>
10005ac04: aa1603e0    	mov	x0, x22
10005ac08: 94002980    	bl	0x100065208    ; import "_DADiskCopyDescription"
10005ac0c: aa0003f5    	mov	x21, x0
10005ac10: aa1603e0    	mov	x0, x22
10005ac14: 9400294a    	bl	0x10006513c    ; import "_CFRelease"
10005ac18: b4fffc15    	cbz	x21, 0x10005ab98 <_IsLaunchedFromDMG+0x4c>
10005ac1c: d0000228    	adrp	x8, 0x1000a0000
10005ac20: f9416508    	ldr	x8, [x8, #0x2c8]    ; import "_kDADiskDescriptionDeviceModelKey"
10005ac24: f9400102    	ldr	x2, [x8]
10005ac28: aa1503e0    	mov	x0, x21
10005ac2c: 94004f55    	bl	0x10006e980 <_objc_msgSend$objectForKey:>    ; data "_objc_msgSend$objectForKey:"
10005ac30: d0000262    	adrp	x2, 0x1000a8000
10005ac34: 91166042    	add	x2, x2, #0x598    ; cfstr "Disk Image"
10005ac38: 940047aa    	bl	0x10006cae0 <_objc_msgSend$isEqualToString:>    ; data "_objc_msgSend$isEqualToString:"
10005ac3c: aa0003f4    	mov	x20, x0
10005ac40: aa1503e0    	mov	x0, x21
10005ac44: 94002ad9    	bl	0x1000657a8    ; import "_objc_release"
10005ac48: b4fffab3    	cbz	x19, 0x10005ab9c <_IsLaunchedFromDMG+0x50>
10005ac4c: 34fffa94    	cbz	w20, 0x10005ab9c <_IsLaunchedFromDMG+0x50>
10005ac50: d0000348    	adrp	x8, 0x1000c4000
10005ac54: f9468100    	ldr	x0, [x8, #0xd00]    ; class "NSFileManager"
10005ac58: 94003a5a    	bl	0x1000695c0 <_objc_msgSend$defaultManager>    ; data "_objc_msgSend$defaultManager"
10005ac5c: aa0003f4    	mov	x20, x0
10005ac60: 910003e8    	mov	x8, sp
10005ac64: 91016115    	add	x21, x8, #0x58    ; sel "setNotesField:"
10005ac68: aa1503e0    	mov	x0, x21
10005ac6c: 94002b20    	bl	0x1000658ec    ; import "_strlen"
10005ac70: aa0003e3    	mov	x3, x0
10005ac74: aa1403e0    	mov	x0, x20
10005ac78: aa1503e2    	mov	x2, x21
10005ac7c: 94006751    	bl	0x1000749c0 <_objc_msgSend$stringWithFileSystemRepresentation:length:>    ; data "_objc_msgSend$stringWithFileSystemRepresentation:length:"
10005ac80: f9000260    	str	x0, [x19]
10005ac84: 52800034    	mov	w20, #0x1               ; =1
10005ac88: 17ffffc5    	b	0x10005ab9c <_IsLaunchedFromDMG+0x50>
10005ac8c: 94002a22    	bl	0x100065514    ; import "___stack_chk_fail"

