struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

struct __Block_byref_btn_0 {
  void *__isa;
__Block_byref_btn_0 *__forwarding;
 int __flags;
 int __size;
 void (*__Block_byref_id_object_copy)(void*, void*);
 void (*__Block_byref_id_object_dispose)(void*);
 NSButton *__strong btn;
};

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  __Block_byref_btn_0 *btn; // by ref
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_btn_0 *_btn, int flags=0) : btn(_btn->__forwarding) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};

static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  __Block_byref_btn_0 *btn = __cself->btn; // bound by ref

    NSLog((NSString *)&__NSConstantStringImpl__var_folders_fj_03n4zg_x4tv33bsws1sfxlkw0000gn_T_main_1e3380_mi_0, (btn->__forwarding->btn));

}

static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->btn, (void*)src->btn, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->btn, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};


int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;

        __attribute__((__blocks__(byref))) __Block_byref_btn_0 btn = {(void*)0,(__Block_byref_btn_0 *)&btn, 33554432, sizeof(__Block_byref_btn_0), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, ((NSButton *(*)(id, SEL))(void *)objc_msgSend)((id)((NSButton *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSButton"), sel_registerName("alloc")), sel_registerName("init"))};

        void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_btn_0 *)&btn, 570425344));
        ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_fj_03n4zg_x4tv33bsws1sfxlkw0000gn_T_main_1e3380_mi_1);
    }
    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
