#!/usr/bin/perl -pi 

BEGIN {
	undef $/;
}

s!<listitem>\s*<para>!<li>!gsi;
s!</para>\s*</listitem>!</li>!gsi;
s!<row>!<tr>!gsi;
s!<entry>!<td>!gsi;
s!</row>!</tr>!gsi;
s!</entry>!</td>!gsi;
