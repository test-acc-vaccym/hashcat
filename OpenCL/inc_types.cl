/**
 * Author......: See docs/credits.txt
 * License.....: MIT
 */

typedef uchar  u8;
typedef ushort u16;
typedef uint   u32;
typedef ulong  u64;

//testwise disabled
//typedef u8  u8a  __attribute__ ((aligned (8)));
//typedef u16 u16a __attribute__ ((aligned (8)));
//typedef u32 u32a __attribute__ ((aligned (8)));
//typedef u64 u64a __attribute__ ((aligned (8)));

typedef u8  u8a;
typedef u16 u16a;
typedef u32 u32a;
typedef u64 u64a;

#ifndef NEW_SIMD_CODE
#undef  VECT_SIZE
#define VECT_SIZE 1
#endif

#define CONCAT(a, b)       a##b
#define VTYPE(type, width) CONCAT(type, width)

#if VECT_SIZE == 1
typedef uchar   u8x;
typedef ushort  u16x;
typedef uint    u32x;
typedef ulong   u64x;
#else
typedef VTYPE(uchar,  VECT_SIZE)  u8x;
typedef VTYPE(ushort, VECT_SIZE) u16x;
typedef VTYPE(uint,   VECT_SIZE) u32x;
typedef VTYPE(ulong,  VECT_SIZE) u64x;
#endif

// unions

typedef union vconv32
{
  u64 v32;

  struct
  {
    u16 v16a;
    u16 v16b;
  };

  struct
  {
    u8 v8a;
    u8 v8b;
    u8 v8c;
    u8 v8d;
  };

} vconv32_t;

typedef union vconv64
{
  u64 v64;

  struct
  {
    u32 v32a;
    u32 v32b;
  };

  struct
  {
    u16 v16a;
    u16 v16b;
    u16 v16c;
    u16 v16d;
  };

  struct
  {
    u8 v8a;
    u8 v8b;
    u8 v8c;
    u8 v8d;
    u8 v8e;
    u8 v8f;
    u8 v8g;
    u8 v8h;
  };

} vconv64_t;

DECLSPEC u32 l32_from_64_S (u64 a);
DECLSPEC u32 l32_from_64_S (u64 a)
{
  const u32 r = (u32) (a);

  return r;
}

DECLSPEC u32 h32_from_64_S (u64 a);
DECLSPEC u32 h32_from_64_S (u64 a)
{
  a >>= 32;

  const u32 r = (u32) (a);

  return r;
}

DECLSPEC u64 hl32_to_64_S (const u32 a, const u32 b);
DECLSPEC u64 hl32_to_64_S (const u32 a, const u32 b)
{
  return as_ulong ((uint2) (b, a));
}

DECLSPEC u32x l32_from_64 (u64x a);
DECLSPEC u32x l32_from_64 (u64x a)
{
  u32x r;

  #if VECT_SIZE == 1
  r    = (u32) a;
  #endif

  #if VECT_SIZE >= 2
  r.s0 = (u32) a.s0;
  r.s1 = (u32) a.s1;
  #endif

  #if VECT_SIZE >= 4
  r.s2 = (u32) a.s2;
  r.s3 = (u32) a.s3;
  #endif

  #if VECT_SIZE >= 8
  r.s4 = (u32) a.s4;
  r.s5 = (u32) a.s5;
  r.s6 = (u32) a.s6;
  r.s7 = (u32) a.s7;
  #endif

  #if VECT_SIZE >= 16
  r.s8 = (u32) a.s8;
  r.s9 = (u32) a.s9;
  r.sa = (u32) a.sa;
  r.sb = (u32) a.sb;
  r.sc = (u32) a.sc;
  r.sd = (u32) a.sd;
  r.se = (u32) a.se;
  r.sf = (u32) a.sf;
  #endif

  return r;
}

DECLSPEC u32x h32_from_64 (u64x a);
DECLSPEC u32x h32_from_64 (u64x a)
{
  a >>= 32;

  u32x r;

  #if VECT_SIZE == 1
  r    = (u32) a;
  #endif

  #if VECT_SIZE >= 2
  r.s0 = (u32) a.s0;
  r.s1 = (u32) a.s1;
  #endif

  #if VECT_SIZE >= 4
  r.s2 = (u32) a.s2;
  r.s3 = (u32) a.s3;
  #endif

  #if VECT_SIZE >= 8
  r.s4 = (u32) a.s4;
  r.s5 = (u32) a.s5;
  r.s6 = (u32) a.s6;
  r.s7 = (u32) a.s7;
  #endif

  #if VECT_SIZE >= 16
  r.s8 = (u32) a.s8;
  r.s9 = (u32) a.s9;
  r.sa = (u32) a.sa;
  r.sb = (u32) a.sb;
  r.sc = (u32) a.sc;
  r.sd = (u32) a.sd;
  r.se = (u32) a.se;
  r.sf = (u32) a.sf;
  #endif

  return r;
}

DECLSPEC u64x hl32_to_64 (const u32x a, const u32x b);
DECLSPEC u64x hl32_to_64 (const u32x a, const u32x b)
{
  u64x r;

  #if VECT_SIZE == 1
  r    = as_ulong ((uint2) (b,    a));
  #endif

  #if VECT_SIZE >= 2
  r.s0 = as_ulong ((uint2) (b.s0, a.s0));
  r.s1 = as_ulong ((uint2) (b.s1, a.s1));
  #endif

  #if VECT_SIZE >= 4
  r.s2 = as_ulong ((uint2) (b.s2, a.s2));
  r.s3 = as_ulong ((uint2) (b.s3, a.s3));
  #endif

  #if VECT_SIZE >= 8
  r.s4 = as_ulong ((uint2) (b.s4, a.s4));
  r.s5 = as_ulong ((uint2) (b.s5, a.s5));
  r.s6 = as_ulong ((uint2) (b.s6, a.s6));
  r.s7 = as_ulong ((uint2) (b.s7, a.s7));
  #endif

  #if VECT_SIZE >= 16
  r.s8 = as_ulong ((uint2) (b.s8, a.s8));
  r.s9 = as_ulong ((uint2) (b.s9, a.s9));
  r.sa = as_ulong ((uint2) (b.sa, a.sa));
  r.sb = as_ulong ((uint2) (b.sb, a.sb));
  r.sc = as_ulong ((uint2) (b.sc, a.sc));
  r.sd = as_ulong ((uint2) (b.sd, a.sd));
  r.se = as_ulong ((uint2) (b.se, a.se));
  r.sf = as_ulong ((uint2) (b.sf, a.sf));
  #endif

  return r;
}

#ifdef IS_AMD

#if HAS_VPERM
DECLSPEC u32 swap32_S (const u32 v);
DECLSPEC u32 swap32_S (const u32 v)
{
  u32 r;

  __asm__ ("V_PERM_B32 %0, 0, %1, %2;" : "=v"(r) : "v"(v), "v"(0x00010203));

  return r;
}

DECLSPEC u64 swap64_S (const u64 v);
DECLSPEC u64 swap64_S (const u64 v)
{
  const u32 v0 = h32_from_64_S (v);
  const u32 v1 = l32_from_64_S (v);

  u32 t0;
  u32 t1;

  __asm__ ("V_PERM_B32 %0, 0, %1, %2;" : "=v"(t0) : "v"(v0), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, 0, %1, %2;" : "=v"(t1) : "v"(v1), "v"(0x00010203));

  const u64 r = hl32_to_64_S (t1, t0);

  return r;
}
#else
DECLSPEC u32 swap32_S (const u32 v);
DECLSPEC u32 swap32_S (const u32 v)
{
  return as_uint (as_uchar4 (v).s3210);
}

DECLSPEC u64 swap64_S (const u64 v);
DECLSPEC u64 swap64_S (const u64 v)
{
  return (as_ulong (as_uchar8 (v).s76543210));
}
#endif

DECLSPEC u32 rotr32_S (const u32 a, const u32 n);
DECLSPEC u32 rotr32_S (const u32 a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32 rotl32_S (const u32 a, const u32 n);
DECLSPEC u32 rotl32_S (const u32 a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64 rotr64_S (const u64 a, const u32 n);
DECLSPEC u64 rotr64_S (const u64 a, const u32 n)
{
  const u32 a0 = h32_from_64_S (a);
  const u32 a1 = l32_from_64_S (a);

  const u32 t0 = (n >= 32) ? amd_bitalign (a0, a1, n - 32) : amd_bitalign (a1, a0, n);
  const u32 t1 = (n >= 32) ? amd_bitalign (a1, a0, n - 32) : amd_bitalign (a0, a1, n);

  const u64 r = hl32_to_64_S (t0, t1);

  return r;
}

DECLSPEC u64 rotl64_S (const u64 a, const u32 n);
DECLSPEC u64 rotl64_S (const u64 a, const u32 n)
{
  return rotr64_S (a, 64 - n);
}

#if HAS_VPERM
DECLSPEC u32x swap32 (const u32x v);
DECLSPEC u32x swap32 (const u32x v)
{
  return bitselect (rotate (v, 24u), rotate (v, 8u), 0x00ff00ffu);
}

DECLSPEC u64x swap64 (const u64x v);
DECLSPEC u64x swap64 (const u64x v)
{
  const u32x a0 = h32_from_64 (v);
  const u32x a1 = l32_from_64 (v);

  u32x t0;
  u32x t1;

  #if VECT_SIZE == 1
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0) : "v"(0), "v"(a0), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1) : "v"(0), "v"(a1), "v"(0x00010203));
  #endif

  #if VECT_SIZE >= 2
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s0) : "v"(0), "v"(a0.s0), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s0) : "v"(0), "v"(a1.s0), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s1) : "v"(0), "v"(a0.s1), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s1) : "v"(0), "v"(a1.s1), "v"(0x00010203));
  #endif

  #if VECT_SIZE >= 4
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s2) : "v"(0), "v"(a0.s2), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s2) : "v"(0), "v"(a1.s2), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s3) : "v"(0), "v"(a0.s3), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s3) : "v"(0), "v"(a1.s3), "v"(0x00010203));
  #endif

  #if VECT_SIZE >= 8
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s4) : "v"(0), "v"(a0.s4), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s4) : "v"(0), "v"(a1.s4), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s5) : "v"(0), "v"(a0.s5), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s5) : "v"(0), "v"(a1.s5), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s6) : "v"(0), "v"(a0.s6), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s6) : "v"(0), "v"(a1.s6), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s7) : "v"(0), "v"(a0.s7), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s7) : "v"(0), "v"(a1.s7), "v"(0x00010203));
  #endif

  #if VECT_SIZE >= 16
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s8) : "v"(0), "v"(a0.s8), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s8) : "v"(0), "v"(a1.s8), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.s9) : "v"(0), "v"(a0.s9), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.s9) : "v"(0), "v"(a1.s9), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.sa) : "v"(0), "v"(a0.sa), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.sa) : "v"(0), "v"(a1.sa), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.sb) : "v"(0), "v"(a0.sb), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.sb) : "v"(0), "v"(a1.sb), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.sc) : "v"(0), "v"(a0.sc), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.sc) : "v"(0), "v"(a1.sc), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.sd) : "v"(0), "v"(a0.sd), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.sd) : "v"(0), "v"(a1.sd), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.se) : "v"(0), "v"(a0.se), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.se) : "v"(0), "v"(a1.se), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t0.sf) : "v"(0), "v"(a0.sf), "v"(0x00010203));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(t1.sf) : "v"(0), "v"(a1.sf), "v"(0x00010203));
  #endif

  const u64x r = hl32_to_64 (t1, t0);

  return r;
}
#else
DECLSPEC u32x swap32 (const u32x v);
DECLSPEC u32x swap32 (const u32x v)
{
  return bitselect (rotate (v, 24u), rotate (v, 8u), 0x00ff00ffu);
}

DECLSPEC u64x swap64 (const u64x v);
DECLSPEC u64x swap64 (const u64x v)
{
  return bitselect (bitselect (rotate (v, 24ul),
                               rotate (v,  8ul), 0x000000ff000000fful),
                    bitselect (rotate (v, 56ul),
                               rotate (v, 40ul), 0x00ff000000ff0000ul),
                                                 0xffff0000ffff0000ul);
}
#endif

DECLSPEC u32x rotr32 (const u32x a, const u32 n);
DECLSPEC u32x rotr32 (const u32x a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32x rotl32 (const u32x a, const u32 n);
DECLSPEC u32x rotl32 (const u32x a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64x rotr64 (const u64x a, const u32 n);
DECLSPEC u64x rotr64 (const u64x a, const u32 n)
{
  const u32x a0 = h32_from_64 (a);
  const u32x a1 = l32_from_64 (a);

  const u32x t0 = (n >= 32) ? amd_bitalign (a0, a1, n - 32) : amd_bitalign (a1, a0, n);
  const u32x t1 = (n >= 32) ? amd_bitalign (a1, a0, n - 32) : amd_bitalign (a0, a1, n);

  const u64x r = hl32_to_64 (t0, t1);

  return r;
}

DECLSPEC u64x rotl64 (const u64x a, const u32 n);
DECLSPEC u64x rotl64 (const u64x a, const u32 n)
{
  return rotr64 (a, 64 - n);
}

DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c)
{
  #define BIT(x)      ((u32x) (1u) << (x))
  #define BIT_MASK(x) (BIT (x) - 1)
  #define BFE(x,y,z)  (((x) >> (y)) & BIT_MASK (z))

  return BFE (a, b, c);

  #undef BIT
  #undef BIT_MASK
  #undef BFE
}

DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c)
{
  #define BIT(x)      (1u << (x))
  #define BIT_MASK(x) (BIT (x) - 1)
  #define BFE(x,y,z)  (((x) >> (y)) & BIT_MASK (z))

  return BFE (a, b, c);

  #undef BIT
  #undef BIT_MASK
  #undef BFE
}

DECLSPEC u32x hc_bytealign_be (const u32x a, const u32x b, const u32 c);
DECLSPEC u32x hc_bytealign_be (const u32x a, const u32x b, const u32 c)
{
  u32x r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a << 24) | (b >>  8); break;
    case 2: r = (a << 16) | (b >> 16); break;
    case 3: r = (a <<  8) | (b >> 24); break;
  }

  return r;
}

DECLSPEC u32 hc_bytealign_be_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bytealign_be_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a << 24) | (b >>  8); break;
    case 2: r = (a << 16) | (b >> 16); break;
    case 3: r = (a <<  8) | (b >> 24); break;
  }

  return r;
}

DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32 c);
DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32 c)
{
  u32x r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a >> 24) | (b <<  8); break;
    case 2: r = (a >> 16) | (b << 16); break;
    case 3: r = (a >>  8) | (b << 24); break;
  }

  return r;
}

DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a >> 24) | (b <<  8); break;
    case 2: r = (a >> 16) | (b << 16); break;
    case 3: r = (a >>  8) | (b << 24); break;
  }

  return r;
}

#if HAS_VPERM
DECLSPEC u32x hc_byte_perm (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_byte_perm (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if VECT_SIZE == 1
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r) : "v"(b), "v"(a), "v"(c));
  #endif

  #if VECT_SIZE >= 2
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  #endif

  #if VECT_SIZE >= 4
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  #endif

  #if VECT_SIZE >= 8
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s4) : "v"(b.s4), "v"(a.s4), "v"(c.s4));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s5) : "v"(b.s5), "v"(a.s5), "v"(c.s5));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s6) : "v"(b.s6), "v"(a.s6), "v"(c.s6));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s7) : "v"(b.s7), "v"(a.s7), "v"(c.s7));
  #endif

  #if VECT_SIZE >= 16
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s4) : "v"(b.s4), "v"(a.s4), "v"(c.s4));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s5) : "v"(b.s5), "v"(a.s5), "v"(c.s5));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s6) : "v"(b.s6), "v"(a.s6), "v"(c.s6));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s7) : "v"(b.s7), "v"(a.s7), "v"(c.s7));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s8) : "v"(b.s8), "v"(a.s8), "v"(c.s8));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.s9) : "v"(b.s9), "v"(a.s9), "v"(c.s9));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.sa) : "v"(b.sa), "v"(a.sa), "v"(c.sa));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.sb) : "v"(b.sb), "v"(a.sb), "v"(c.sb));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.sc) : "v"(b.sc), "v"(a.sc), "v"(c.sc));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.sd) : "v"(b.sd), "v"(a.sd), "v"(c.sd));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.se) : "v"(b.se), "v"(a.se), "v"(c.se));
  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r.sf) : "v"(b.sf), "v"(a.sf), "v"(c.sf));
  #endif

  return r;
}

DECLSPEC u32 hc_byte_perm_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_byte_perm_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  __asm__ ("V_PERM_B32 %0, %1, %2, %3;" : "=v"(r) : "v"(b), "v"(a), "v"(c));

  return r;
}
#endif

#if HAS_VADD3
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if VECT_SIZE == 1
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r) : "v"(b), "v"(a), "v"(c));
  #endif

  #if VECT_SIZE >= 2
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  #endif

  #if VECT_SIZE >= 4
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  #endif

  #if VECT_SIZE >= 8
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s4) : "v"(b.s4), "v"(a.s4), "v"(c.s4));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s5) : "v"(b.s5), "v"(a.s5), "v"(c.s5));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s6) : "v"(b.s6), "v"(a.s6), "v"(c.s6));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s7) : "v"(b.s7), "v"(a.s7), "v"(c.s7));
  #endif

  #if VECT_SIZE >= 16
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s0) : "v"(b.s0), "v"(a.s0), "v"(c.s0));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s1) : "v"(b.s1), "v"(a.s1), "v"(c.s1));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s2) : "v"(b.s2), "v"(a.s2), "v"(c.s2));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s3) : "v"(b.s3), "v"(a.s3), "v"(c.s3));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s4) : "v"(b.s4), "v"(a.s4), "v"(c.s4));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s5) : "v"(b.s5), "v"(a.s5), "v"(c.s5));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s6) : "v"(b.s6), "v"(a.s6), "v"(c.s6));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s7) : "v"(b.s7), "v"(a.s7), "v"(c.s7));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s8) : "v"(b.s8), "v"(a.s8), "v"(c.s8));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.s9) : "v"(b.s9), "v"(a.s9), "v"(c.s9));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.sa) : "v"(b.sa), "v"(a.sa), "v"(c.sa));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.sb) : "v"(b.sb), "v"(a.sb), "v"(c.sb));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.sc) : "v"(b.sc), "v"(a.sc), "v"(c.sc));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.sd) : "v"(b.sd), "v"(a.sd), "v"(c.sd));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.se) : "v"(b.se), "v"(a.se), "v"(c.se));
  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r.sf) : "v"(b.sf), "v"(a.sf), "v"(c.sf));
  #endif

  return r;
}

DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  __asm__ ("V_ADD3_U32 %0, %1, %2, %3;" : "=v"(r) : "v"(b), "v"(a), "v"(c));

  return r;
}
#else
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c)
{
  return a + b + c;
}

DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c)
{
  return a + b + c;
}
#endif

DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c)
{
  return a ^ b ^ c;
}

DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c)
{
  return a ^ b ^ c;
}

#endif

#ifdef IS_NV
DECLSPEC u32 swap32_S (const u32 v);
DECLSPEC u32 swap32_S (const u32 v)
{
  u32 r;

  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r) : "r"(v));

  return r;
}

DECLSPEC u64 swap64_S (const u64 v);
DECLSPEC u64 swap64_S (const u64 v)
{
  u32 il;
  u32 ir;

  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il), "=r"(ir) : "l"(v));

  u32 tl;
  u32 tr;

  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl) : "r"(il));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr) : "r"(ir));

  u64 r;

  asm ("mov.b64 %0, {%1, %2};" : "=l"(r) : "r"(tr), "r"(tl));

  return r;
}

DECLSPEC u32 rotr32_S (const u32 a, const u32 n);
DECLSPEC u32 rotr32_S (const u32 a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32 rotl32_S (const u32 a, const u32 n);
DECLSPEC u32 rotl32_S (const u32 a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64 rotr64_S (const u64 a, const u32 n);
DECLSPEC u64 rotr64_S (const u64 a, const u32 n)
{
  return rotate (a, (u64) (64 - n));
}

DECLSPEC u64 rotl64_S (const u64 a, const u32 n);
DECLSPEC u64 rotl64_S (const u64 a, const u32 n)
{
  return rotate (a, (u64) n);
}

DECLSPEC u32x swap32 (const u32x v);
DECLSPEC u32x swap32 (const u32x v)
{
  u32x r;

  #if VECT_SIZE == 1
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r) : "r"(v));
  #endif

  #if VECT_SIZE >= 2
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s0) : "r"(v.s0));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s1) : "r"(v.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s2) : "r"(v.s2));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s3) : "r"(v.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s4) : "r"(v.s4));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s5) : "r"(v.s5));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s6) : "r"(v.s6));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s7) : "r"(v.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s8) : "r"(v.s8));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.s9) : "r"(v.s9));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.sa) : "r"(v.sa));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.sb) : "r"(v.sb));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.sc) : "r"(v.sc));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.sd) : "r"(v.sd));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.se) : "r"(v.se));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(r.sf) : "r"(v.sf));
  #endif

  return r;
}

DECLSPEC u64x swap64 (const u64x v);
DECLSPEC u64x swap64 (const u64x v)
{
  u32x il;
  u32x ir;

  #if VECT_SIZE == 1
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il), "=r"(ir) : "l"(v));
  #endif

  #if VECT_SIZE >= 2
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s0), "=r"(ir.s0) : "l"(v.s0));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s1), "=r"(ir.s1) : "l"(v.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s2), "=r"(ir.s2) : "l"(v.s2));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s3), "=r"(ir.s3) : "l"(v.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s4), "=r"(ir.s4) : "l"(v.s4));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s5), "=r"(ir.s5) : "l"(v.s5));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s6), "=r"(ir.s6) : "l"(v.s6));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s7), "=r"(ir.s7) : "l"(v.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s8), "=r"(ir.s8) : "l"(v.s8));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.s9), "=r"(ir.s9) : "l"(v.s9));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.sa), "=r"(ir.sa) : "l"(v.sa));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.sb), "=r"(ir.sb) : "l"(v.sb));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.sc), "=r"(ir.sc) : "l"(v.sc));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.sd), "=r"(ir.sd) : "l"(v.sd));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.se), "=r"(ir.se) : "l"(v.se));
  asm ("mov.b64 {%0, %1}, %2;" : "=r"(il.sf), "=r"(ir.sf) : "l"(v.sf));
  #endif

  u32x tl;
  u32x tr;

  #if VECT_SIZE == 1
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl) : "r"(il));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr) : "r"(ir));
  #endif

  #if VECT_SIZE >= 2
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s0) : "r"(il.s0));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s0) : "r"(ir.s0));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s1) : "r"(il.s1));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s1) : "r"(ir.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s2) : "r"(il.s2));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s2) : "r"(ir.s2));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s3) : "r"(il.s3));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s3) : "r"(ir.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s4) : "r"(il.s4));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s4) : "r"(ir.s4));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s5) : "r"(il.s5));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s5) : "r"(ir.s5));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s6) : "r"(il.s6));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s6) : "r"(ir.s6));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s7) : "r"(il.s7));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s7) : "r"(ir.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s8) : "r"(il.s8));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s8) : "r"(ir.s8));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.s9) : "r"(il.s9));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.s9) : "r"(ir.s9));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.sa) : "r"(il.sa));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.sa) : "r"(ir.sa));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.sb) : "r"(il.sb));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.sb) : "r"(ir.sb));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.sc) : "r"(il.sc));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.sc) : "r"(ir.sc));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.sd) : "r"(il.sd));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.sd) : "r"(ir.sd));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.se) : "r"(il.se));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.se) : "r"(ir.se));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tl.sf) : "r"(il.sf));
  asm ("prmt.b32 %0, %1, 0, 0x0123;" : "=r"(tr.sf) : "r"(ir.sf));
  #endif

  u64x r;

  #if VECT_SIZE == 1
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r) : "r"(tr), "r"(tl));
  #endif

  #if VECT_SIZE >= 2
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s0) : "r"(tr.s0), "r"(tl.s0));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s1) : "r"(tr.s1), "r"(tl.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s2) : "r"(tr.s2), "r"(tl.s2));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s3) : "r"(tr.s3), "r"(tl.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s4) : "r"(tr.s4), "r"(tl.s4));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s5) : "r"(tr.s5), "r"(tl.s5));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s6) : "r"(tr.s6), "r"(tl.s6));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s7) : "r"(tr.s7), "r"(tl.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s8) : "r"(tr.s8), "r"(tl.s8));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.s9) : "r"(tr.s9), "r"(tl.s9));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.sa) : "r"(tr.sa), "r"(tl.sa));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.sb) : "r"(tr.sb), "r"(tl.sb));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.sc) : "r"(tr.sc), "r"(tl.sc));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.sd) : "r"(tr.sd), "r"(tl.sd));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.se) : "r"(tr.se), "r"(tl.se));
  asm ("mov.b64 %0, {%1, %2};" : "=l"(r.sf) : "r"(tr.sf), "r"(tl.sf));
  #endif

  return r;
}

DECLSPEC u32x rotr32 (const u32x a, const u32 n);
DECLSPEC u32x rotr32 (const u32x a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32x rotl32 (const u32x a, const u32 n);
DECLSPEC u32x rotl32 (const u32x a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64x rotr64 (const u64x a, const u32 n);
DECLSPEC u64x rotr64 (const u64x a, const u32 n)
{
  return rotate (a, (u64x) (64 - n));
}

DECLSPEC u64x rotl64 (const u64x a, const u32 n);
DECLSPEC u64x rotl64 (const u64x a, const u32 n)
{
  return rotate (a, (u64x) n);
}

DECLSPEC u32x hc_byte_perm (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_byte_perm (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if VECT_SIZE == 1
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r)    : "r"(a),    "r"(b),    "r"(c)   );
  #endif

  #if VECT_SIZE >= 2
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s0) : "r"(a.s0), "r"(b.s0), "r"(c.s0));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s1) : "r"(a.s1), "r"(b.s1), "r"(c.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s2) : "r"(a.s2), "r"(b.s2), "r"(c.s2));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s3) : "r"(a.s3), "r"(b.s3), "r"(c.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s4) : "r"(a.s4), "r"(b.s4), "r"(c.s4));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s5) : "r"(a.s5), "r"(b.s5), "r"(c.s5));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s6) : "r"(a.s6), "r"(b.s6), "r"(c.s6));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s7) : "r"(a.s7), "r"(b.s7), "r"(c.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s8) : "r"(a.s8), "r"(b.s8), "r"(c.s8));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.s9) : "r"(a.s9), "r"(b.s9), "r"(c.s9));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.sa) : "r"(a.sa), "r"(b.sa), "r"(c.sa));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.sb) : "r"(a.sb), "r"(b.sb), "r"(c.sb));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.sc) : "r"(a.sc), "r"(b.sc), "r"(c.sc));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.sd) : "r"(a.sd), "r"(b.sd), "r"(c.sd));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.se) : "r"(a.se), "r"(b.se), "r"(c.se));
  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r.sf) : "r"(a.sf), "r"(b.sf), "r"(c.sf));
  #endif

  return r;
}

DECLSPEC u32 hc_byte_perm_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_byte_perm_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  asm ("prmt.b32 %0, %1, %2, %3;" : "=r"(r) : "r"(a), "r"(b), "r"(c));

  return r;
}

DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if VECT_SIZE == 1
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r)    : "r"(a),    "r"(b),    "r"(c));
  #endif

  #if VECT_SIZE >= 2
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s0) : "r"(a.s0), "r"(b.s0), "r"(c.s0));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s1) : "r"(a.s1), "r"(b.s1), "r"(c.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s2) : "r"(a.s2), "r"(b.s2), "r"(c.s2));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s3) : "r"(a.s3), "r"(b.s3), "r"(c.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s4) : "r"(a.s4), "r"(b.s4), "r"(c.s4));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s5) : "r"(a.s5), "r"(b.s5), "r"(c.s5));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s6) : "r"(a.s6), "r"(b.s6), "r"(c.s6));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s7) : "r"(a.s7), "r"(b.s7), "r"(c.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s8) : "r"(a.s8), "r"(b.s8), "r"(c.s8));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.s9) : "r"(a.s9), "r"(b.s9), "r"(c.s9));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.sa) : "r"(a.sa), "r"(b.sa), "r"(c.sa));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.sb) : "r"(a.sb), "r"(b.sb), "r"(c.sb));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.sc) : "r"(a.sc), "r"(b.sc), "r"(c.sc));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.sd) : "r"(a.sd), "r"(b.sd), "r"(c.sd));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.se) : "r"(a.se), "r"(b.se), "r"(c.se));
  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r.sf) : "r"(a.sf), "r"(b.sf), "r"(c.sf));
  #endif

  return r;
}

DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  asm ("bfe.u32 %0, %1, %2, %3;" : "=r"(r) : "r"(a), "r"(b), "r"(c));

  return r;
}

DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if CUDA_ARCH >= 350

  #if VECT_SIZE == 1
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r)    : "r"(b),    "r"(a),    "r"((c & 3) * 8));
  #endif

  #if VECT_SIZE >= 2
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s0) : "r"(b.s0), "r"(a.s0), "r"((c.s0 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s1) : "r"(b.s1), "r"(a.s1), "r"((c.s1 & 3) * 8));
  #endif

  #if VECT_SIZE >= 4
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s2) : "r"(b.s2), "r"(a.s2), "r"((c.s2 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s3) : "r"(b.s3), "r"(a.s3), "r"((c.s3 & 3) * 8));
  #endif

  #if VECT_SIZE >= 8
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s4) : "r"(b.s4), "r"(a.s4), "r"((c.s4 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s5) : "r"(b.s5), "r"(a.s5), "r"((c.s5 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s6) : "r"(b.s6), "r"(a.s6), "r"((c.s6 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s7) : "r"(b.s7), "r"(a.s7), "r"((c.s7 & 3) * 8));
  #endif

  #if VECT_SIZE >= 16
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s8) : "r"(b.s8), "r"(a.s8), "r"((c.s8 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.s9) : "r"(b.s9), "r"(a.s9), "r"((c.s9 & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.sa) : "r"(b.sa), "r"(a.sa), "r"((c.sa & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.sb) : "r"(b.sb), "r"(a.sb), "r"((c.sb & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.sc) : "r"(b.sc), "r"(a.sc), "r"((c.sc & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.sd) : "r"(b.sd), "r"(a.sd), "r"((c.sd & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.se) : "r"(b.se), "r"(a.se), "r"((c.se & 3) * 8));
  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r.sf) : "r"(b.sf), "r"(a.sf), "r"((c.sf & 3) * 8));
  #endif

  #else

  r = hc_byte_perm (b, a, ((u32x) (0x76543210) >> ((c & 3) * 4)) & 0xffff);

  #endif

  return r;
}

DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  #if CUDA_ARCH >= 350

  asm ("shf.r.wrap.b32 %0, %1, %2, %3;" : "=r"(r) : "r"(b), "r"(a), "r"((c & 3) * 8));

  #else

  r = hc_byte_perm_S (b, a, (0x76543210 >> ((c & 3) * 4)) & 0xffff);

  #endif

  return r;
}

DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c)
{
  return a + b + c;
}

DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c)
{
  return a + b + c;
}

DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c)
{
  u32x r;

  #if CUDA_ARCH >= 500

  #if VECT_SIZE == 1
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r): "r"(a), "r"(b), "r"(c));
  #endif

  #if VECT_SIZE >= 2
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s0): "r"(a.s0), "r"(b.s0), "r"(c.s0));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s1): "r"(a.s1), "r"(b.s1), "r"(c.s1));
  #endif

  #if VECT_SIZE >= 4
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s2): "r"(a.s2), "r"(b.s2), "r"(c.s2));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s3): "r"(a.s3), "r"(b.s3), "r"(c.s3));
  #endif

  #if VECT_SIZE >= 8
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s4): "r"(a.s4), "r"(b.s4), "r"(c.s4));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s5): "r"(a.s5), "r"(b.s5), "r"(c.s5));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s6): "r"(a.s6), "r"(b.s6), "r"(c.s6));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s7): "r"(a.s7), "r"(b.s7), "r"(c.s7));
  #endif

  #if VECT_SIZE >= 16
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s8): "r"(a.s8), "r"(b.s8), "r"(c.s8));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.s9): "r"(a.s9), "r"(b.s9), "r"(c.s9));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.sa): "r"(a.sa), "r"(b.sa), "r"(c.sa));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.sb): "r"(a.sb), "r"(b.sb), "r"(c.sb));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.sc): "r"(a.sc), "r"(b.sc), "r"(c.sc));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.sd): "r"(a.sd), "r"(b.sd), "r"(c.sd));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.se): "r"(a.se), "r"(b.se), "r"(c.se));
  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r.sf): "r"(a.sf), "r"(b.sf), "r"(c.sf));
  #endif

  #else

  r = a ^ b ^ c;

  #endif

  return r;
}

DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  #if CUDA_ARCH >= 500

  asm ("lop3.b32 %0, %1, %2, %3, 0x96;" : "=r"(r): "r"(a), "r"(b), "r"(c));

  #else

  r = a ^ b ^ c;

  #endif

  return r;
}

#endif

#ifdef IS_GENERIC
DECLSPEC u32 swap32_S (const u32 v);
DECLSPEC u32 swap32_S (const u32 v)
{
  return (as_uint (as_uchar4 (v).s3210));
}

DECLSPEC u64 swap64_S (const u64 v);
DECLSPEC u64 swap64_S (const u64 v)
{
  return (as_ulong (as_uchar8 (v).s76543210));
}

DECLSPEC u32 rotr32_S (const u32 a, const u32 n);
DECLSPEC u32 rotr32_S (const u32 a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32 rotl32_S (const u32 a, const u32 n);
DECLSPEC u32 rotl32_S (const u32 a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64 rotr64_S (const u64 a, const u32 n);
DECLSPEC u64 rotr64_S (const u64 a, const u32 n)
{
  return rotate (a, (u64) (64 - n));
}

DECLSPEC u64 rotl64_S (const u64 a, const u32 n);
DECLSPEC u64 rotl64_S (const u64 a, const u32 n)
{
  return rotate (a, (u64) n);
}

DECLSPEC u32x swap32 (const u32x v);
DECLSPEC u32x swap32 (const u32x v)
{
  return ((v >> 24) & 0x000000ff)
       | ((v >>  8) & 0x0000ff00)
       | ((v <<  8) & 0x00ff0000)
       | ((v << 24) & 0xff000000);
}

DECLSPEC u64x swap64 (const u64x v);
DECLSPEC u64x swap64 (const u64x v)
{
  return ((v >> 56) & 0x00000000000000ff)
       | ((v >> 40) & 0x000000000000ff00)
       | ((v >> 24) & 0x0000000000ff0000)
       | ((v >>  8) & 0x00000000ff000000)
       | ((v <<  8) & 0x000000ff00000000)
       | ((v << 24) & 0x0000ff0000000000)
       | ((v << 40) & 0x00ff000000000000)
       | ((v << 56) & 0xff00000000000000);
}

DECLSPEC u32x rotr32 (const u32x a, const u32 n);
DECLSPEC u32x rotr32 (const u32x a, const u32 n)
{
  return rotate (a, (32 - n));
}

DECLSPEC u32x rotl32 (const u32x a, const u32 n);
DECLSPEC u32x rotl32 (const u32x a, const u32 n)
{
  return rotate (a, n);
}

DECLSPEC u64x rotr64 (const u64x a, const u32 n);
DECLSPEC u64x rotr64 (const u64x a, const u32 n)
{
  return rotate (a, (u64x) (64 - n));
}

DECLSPEC u64x rotl64 (const u64x a, const u32 n);
DECLSPEC u64x rotl64 (const u64x a, const u32 n)
{
  return rotate (a, (u64x) n);
}

DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_bfe (const u32x a, const u32x b, const u32x c)
{
  #define BIT(x)      ((u32x) (1u) << (x))
  #define BIT_MASK(x) (BIT (x) - 1)
  #define BFE(x,y,z)  (((x) >> (y)) & BIT_MASK (z))

  return BFE (a, b, c);

  #undef BIT
  #undef BIT_MASK
  #undef BFE
}

DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bfe_S (const u32 a, const u32 b, const u32 c)
{
  #define BIT(x)      (1u << (x))
  #define BIT_MASK(x) (BIT (x) - 1)
  #define BFE(x,y,z)  (((x) >> (y)) & BIT_MASK (z))

  return BFE (a, b, c);

  #undef BIT
  #undef BIT_MASK
  #undef BFE
}

DECLSPEC u32x hc_bytealign_be (const u32x a, const u32x b, const u32 c);
DECLSPEC u32x hc_bytealign_be (const u32x a, const u32x b, const u32 c)
{
  u32x r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a << 24) | (b >>  8); break;
    case 2: r = (a << 16) | (b >> 16); break;
    case 3: r = (a <<  8) | (b >> 24); break;
  }

  return r;
}

DECLSPEC u32 hc_bytealign_be_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bytealign_be_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a << 24) | (b >>  8); break;
    case 2: r = (a << 16) | (b >> 16); break;
    case 3: r = (a <<  8) | (b >> 24); break;
  }

  return r;
}

DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32 c);
DECLSPEC u32x hc_bytealign (const u32x a, const u32x b, const u32 c)
{
  u32x r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a >> 24) | (b <<  8); break;
    case 2: r = (a >> 16) | (b << 16); break;
    case 3: r = (a >>  8) | (b << 24); break;
  }

  return r;
}

DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_bytealign_S (const u32 a, const u32 b, const u32 c)
{
  u32 r;

  switch (c & 3)
  {
    case 0: r =              b;        break;
    case 1: r = (a >> 24) | (b <<  8); break;
    case 2: r = (a >> 16) | (b << 16); break;
    case 3: r = (a >>  8) | (b << 24); break;
  }

  return r;
}

DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_add3 (const u32x a, const u32x b, const u32x c)
{
  return a + b + c;
}

DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_add3_S (const u32 a, const u32 b, const u32 c)
{
  return a + b + c;
}

DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c);
DECLSPEC u32x hc_lop_0x96 (const u32x a, const u32x b, const u32x c)
{
  return a ^ b ^ c;
}

DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c);
DECLSPEC u32 hc_lop_0x96_S (const u32 a, const u32 b, const u32 c)
{
  return a ^ b ^ c;
}

#endif

typedef enum combinator_mode
{
  COMBINATOR_MODE_BASE_LEFT  = 10001,
  COMBINATOR_MODE_BASE_RIGHT = 10002

} combinator_mode_t;

typedef struct digest
{
  u32 digest_buf[DGST_ELEM];

} digest_t;

typedef struct salt
{
  u32 salt_buf[64];
  u32 salt_buf_pc[64];

  u32 salt_len;
  u32 salt_len_pc;
  u32 salt_iter;
  u32 salt_iter2;
  u32 salt_sign[2];

  u32 digests_cnt;
  u32 digests_done;

  u32 digests_offset;

  u32 scrypt_N;
  u32 scrypt_r;
  u32 scrypt_p;

} salt_t;

typedef struct
{
  u32 key;
  u64 val;

} hcstat_table_t;

typedef struct
{
  u32 cs_buf[0x100];
  u32 cs_len;

} cs_t;

typedef struct
{
  u32 cmds[32];

} kernel_rule_t;

typedef struct pw
{
  u32 i[64];

  u32 pw_len;

} pw_t;

typedef struct pw_idx
{
  u32 off;
  u32 cnt;
  u32 len;

} pw_idx_t;

typedef struct bf
{
  u32  i;

} bf_t;

typedef struct bs_word
{
  u32  b[32];

} bs_word_t;

typedef struct plain
{
  u64  gidvid;
  u32  il_pos;
  u32  salt_pos;
  u32  digest_pos;
  u32  hash_pos;
  u32  extra1;
  u32  extra2;

} plain_t;

typedef struct keyboard_layout_mapping
{
  u32 src_char;
  int src_len;
  u32 dst_char;
  int dst_len;

} keyboard_layout_mapping_t;

// functions

DECLSPEC u8 v8a_from_v32_S (const u32 v32);
DECLSPEC u8 v8a_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v8a;
}

DECLSPEC u8 v8b_from_v32_S (const u32 v32);
DECLSPEC u8 v8b_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v8b;
}

DECLSPEC u8 v8c_from_v32_S (const u32 v32);
DECLSPEC u8 v8c_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v8c;
}

DECLSPEC u8 v8d_from_v32_S (const u32 v32);
DECLSPEC u8 v8d_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v8d;
}

DECLSPEC u16 v16a_from_v32_S (const u32 v32);
DECLSPEC u16 v16a_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v16a;
}

DECLSPEC u16 v16b_from_v32_S (const u32 v32);
DECLSPEC u16 v16b_from_v32_S (const u32 v32)
{
  vconv32_t v;

  v.v32 = v32;

  return v.v16b;
}

DECLSPEC u32 v32_from_v16ab_S (const u16 v16a, const u16 v16b);
DECLSPEC u32 v32_from_v16ab_S (const u16 v16a, const u16 v16b)
{
  vconv32_t v;

  v.v16a = v16a;
  v.v16b = v16b;

  return v.v32;
}

DECLSPEC u32 v32a_from_v64_S (const u64 v64);
DECLSPEC u32 v32a_from_v64_S (const u64 v64)
{
  vconv64_t v;

  v.v64 = v64;

  return v.v32a;
}

DECLSPEC u32 v32b_from_v64_S (const u64 v64);
DECLSPEC u32 v32b_from_v64_S (const u64 v64)
{
  vconv64_t v;

  v.v64 = v64;

  return v.v32b;
}

DECLSPEC u64 v64_from_v32ab_S (const u32 v32a, const u32 v32b);
DECLSPEC u64 v64_from_v32ab_S (const u32 v32a, const u32 v32b)
{
  vconv64_t v;

  v.v32a = v32a;
  v.v32b = v32b;

  return v.v64;
}

// unpack function are similar, but always return u32

DECLSPEC u32 unpack_v8a_from_v32_S (const u32 v32);
DECLSPEC u32 unpack_v8a_from_v32_S (const u32 v32)
{
  u32 r;

  #if defined IS_NV
  asm ("bfe.u32 %0, %1, 0, 8;" : "=r"(r) : "r"(v32));
  #elif defined IS_AMD
    #if HAS_VBFE
    __asm__ ("V_BFE_U32 %0, %1, 0, 8;" : "=v"(r) : "v"(v32));
    #else
    r = (v32 >> 0) & 0xff;
    #endif
  #else
  r = (v32 >> 0) & 0xff;
  #endif

  return r;
}

DECLSPEC u32 unpack_v8b_from_v32_S (const u32 v32);
DECLSPEC u32 unpack_v8b_from_v32_S (const u32 v32)
{
  u32 r;

  #if defined IS_NV
  asm ("bfe.u32 %0, %1, 8, 8;" : "=r"(r) : "r"(v32));
  #elif defined IS_AMD
    #if HAS_VBFE
    __asm__ ("V_BFE_U32 %0, %1, 8, 8;" : "=v"(r) : "v"(v32));
    #else
    r = (v32 >> 8) & 0xff;
    #endif
  #else
  r = (v32 >> 8) & 0xff;
  #endif

  return r;
}

DECLSPEC u32 unpack_v8c_from_v32_S (const u32 v32);
DECLSPEC u32 unpack_v8c_from_v32_S (const u32 v32)
{
  u32 r;

  #if defined IS_NV
  asm ("bfe.u32 %0, %1, 16, 8;" : "=r"(r) : "r"(v32));
  #elif defined IS_AMD
    #if HAS_VBFE
    __asm__ ("V_BFE_U32 %0, %1, 16, 8;" : "=v"(r) : "v"(v32));
    #else
    r = (v32 >> 16) & 0xff;
    #endif
  #else
  r = (v32 >> 16) & 0xff;
  #endif

  return r;
}

DECLSPEC u32 unpack_v8d_from_v32_S (const u32 v32);
DECLSPEC u32 unpack_v8d_from_v32_S (const u32 v32)
{
  u32 r;

  #if defined IS_NV
  asm ("bfe.u32 %0, %1, 24, 8;" : "=r"(r) : "r"(v32));
  #elif defined IS_AMD
    #if HAS_VBFE
    __asm__ ("V_BFE_U32 %0, %1, 24, 8;" : "=v"(r) : "v"(v32));
    #else
    r = (v32 >> 24) & 0xff;
    #endif
  #else
  r = (v32 >> 24) & 0xff;
  #endif

  return r;
}
