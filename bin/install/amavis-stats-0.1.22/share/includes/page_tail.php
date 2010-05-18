<?php
/***************************************************************************
 *                              page_tail.php
 *                            -------------------
 *   begin                : Tue, Oct 25, 2005
 *   copyright            : (C) 2005 The Dale Walsh
 *   email                : buildsmart@daleenterprise.com
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 ***************************************************************************/

if ( !defined('IN_AS') )
{
	die('Hacking attempt');
}

//
// Show the overall footer.
//
$template->set_filenames(array(
	'overall_footer' => ( empty($gen_simple_header) ) ? 'overall_footer.tpl' : 'simple_footer.tpl')
);

$template->assign_vars(array(
	'DOWNLOAD_LINK' => "<table style=\"font-size:13;\" cellpadding=0 border=0>\n\t<tr>\n\t\t<td>Generated by&nbsp;</td>\n\t\t<td>&nbsp;<a href=\"http://downloads.topicdesk.com/amavis_stats/$as_pkg-$as_version.tar.gz\" target=\"download\"><img src=\"$me?text=$as_pkg-$as_version&ttsize=8&button=blue&button_name=bullet\"></a>&nbsp;</td>\n\t\t<td>&nbsp;using $rrd rrdtool</td>\n\t</tr>\n</table><br>",
	'OUT_MSG' => $out_msg ? $out_msg : NULL)
	);

$template->pparse('overall_footer');

exit;

?>