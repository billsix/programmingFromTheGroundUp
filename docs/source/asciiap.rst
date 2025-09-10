..
   Copyright 2002 Jonathan Bartlett

   Permission is granted to copy, distribute and/or modify this
   document under the terms of the GNU Free Documentation License,
   Version 1.1 or any later version published by the Free Software
   Foundation; with no Invariant Sections, with no Front-Cover Texts,
   and with no Back-Cover Texts.  A copy of the license is included in fdl.xml

.. _asciilisting:

Table of ASCII Codes
====================

To use this table, simply find the character or escape that you want the
code for, and add the number on the left and the top.

.. table:: Table of ASCII codes in decimal

   === === === === === =========== === =========== ===
   \   +0  +1  +2  +3  +4          +5  +6          +7
   0   NUL SOH STX ETX EOT         ENQ ACK         BEL
   8   BS  HT  LF  VT  FF          CR  SO          SI
   16  DLE DC1 DC2 DC3 DC4         NAK SYN         ETB
   24  CAN EM  SUB ESC FS          GS  RS          US
   32      !   "   #   $           %   &    '
   40  (   )   \*  +   ,           -   .           /
   48  0   1   2   3   4           5   6           7
   56  8   9   :   ;   < =   > ?
   64  @   A   B   C   D           E   F           G
   72  H   I   J   K   L           M   N           O
   80  P   Q   R   S   T           U   V           W
   88  X   Y   Z   [   \\          ]   ^           \_
   96  \`  a   b   c   d           e   f           g
   104 h   i   j   k   l           m   n           o
   112 p   q   r   s   t           u   v           w
   120 x   y   z   {   \|          }   ~           DEL
   === === === === === =========== === =========== ===

ASCII is actually being phased out in favor of an international standard
known as Unicode, which allows you to display any character from any
known writing system in the world. As you may have noticed, ASCII only
has support for English characters. Unicode is much more complicated,
however, because it requires more than one byte to encode a single
character. There are several different methods for encoding Unicode
characters. The most common is UTF-8 and UTF-32. UTF-8 is somewhat
backwards-compatible with ASCII (it is stored the same for English
characters, but expands into multiple byte for international
characters). UTF-32 simply requires four bytes for each character rather
than one. Windows uses UTF-16, which is a variable-length encoding which
requires at least 2 bytes per character, so it is not
backwards-compatible with ASCII.

A good tutorial on internationalization issues, fonts, and Unicode is
available in a great Article by Joe Spolsky, called "The Absolute
Minimum Every Software Developer Absolutely, Positively Must Know About
Unicode and Character Sets (No Excuses!)", available online at
http://www.joelonsoftware.com/articles/Unicode.html
