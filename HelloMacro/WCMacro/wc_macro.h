//
//  wc_macro.h
//  HelloMacro
//
//  Created by wesley_chen on 2023/1/1.
//

#ifndef wc_macro_h
#define wc_macro_h

#define WC_DISALLOW_COPY_AND_ASSIGN(TypeName) \
  TypeName(const TypeName&) = delete;          \
  TypeName& operator=(const TypeName&) = delete

#endif /* wc_macro_h */
