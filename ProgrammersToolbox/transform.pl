#!/usr/bin/perl -pi 

BEGIN {
	undef $/;
}

s!<(chapter|article)>!<dw-document xsi:noNamespaceSchemaLocation="http://dw.raleigh.ibm.com/developerworks/library/schema/4.0/dw-document-4.0.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dw-article local-site="worldwide" ratings-form="auto" related-contents="auto" toc="auto" skill-level="3"><id cma-id="" domino-uid="" content-id="" original="yes"/><keywords content="memory,malloc,garbage collection,pooling,pools,reference counting,allocator,allocation,memory management,free,boehm,gc" /><meta-last-updated day="16" month="10" year="2004" initials="jlb"/><content-area-primary name="linux" />!si;

s!</title>\s*<para>(.*?)</para>!</title><abstract>$1</abstract><docbody>!si;
s!</title>!</title><author jobtitle="Director of Technology" company="New Media Worx" email="johnnyb@eskimo.com"  ><bio>Jonathan Bartlett is the author of the book <a href="http://www.cafeshops.com/bartlettpublish.8640017"><i>Programming from the Ground Up</i></a> which is an introduction to programming using Linux assembly language.  He is the lead developer at New Media Worx, developing web, video, kiosk, and desktop applications for clients.</bio><name>Jonathan Bartlett</name> </author><date-published day="01" month="09" year="2004" />!si;



s!<listitem>\s*<para>!<li>!gsi;
s!</para>\s*</listitem>!</li>!gsi;
s!<row>!<tr>!gsi;
s!<entry>!<td>!gsi;
s!</row>!</tr>!gsi;
s!</entry>!</td>!gsi;
s!<(/)?emphasis>!<${1}i>!gsi;
s!<sect1>\s*<title>(.*?)</title>!<heading refname="" type="major" toc="yes" alttoc="">${1}</heading>!gsi;
s!</sect1>!!;
s!<sect2>\s*<title>(.*?)</title>!<heading refname="" type="minor" toc="no" alttoc="">${1}</heading>!gsi;
s!</sect2>!!;
s!<(/)?itemizedlist>!<${1}ul>!gsi;
s!<(/)?orderedlist>!<${1}ol>!gsi;
$lnum = 0;
sub make_code_section
{
	my ($heading, $code) = @_;

	$lnum++;
	return (<<EOF);
<code type="section"><heading refname="" type="code" toc="no">Listing ${lnum}: ${heading}</heading>${code}</code>
EOF
}
s!<example>\s*<title>(.*?)</title>\s*<programlisting>(.*?)</programlisting>\s*</example>!make_code_section($1, $2)!gsie;
s!<(/)?para>!<${1}p>!gsi;

