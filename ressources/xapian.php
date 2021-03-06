<?php

/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 1.3.32
 * 
 * This file is not intended to be easily readable and contains a number of 
 * coding conventions designed to improve portability and efficiency. Do not make
 * changes to this file unless you know what you are doing--modify the SWIG 
 * interface file instead. 
 * ----------------------------------------------------------------------------- */

// Try to load our extension if it's not already loaded.
if (!extension_loaded("xapian")) {
  if (strtolower(substr(PHP_OS, 0, 3)) === 'win') {
    if (!dl('php_xapian.dll')) return;
  } else {
    // PHP_SHLIB_SUFFIX is available as of PHP 4.3.0, for older PHP assume 'so'.
    // It gives 'dylib' on MacOS X which is for libraries, modules are 'so'.
    if (PHP_SHLIB_SUFFIX === 'PHP_SHLIB_SUFFIX' || PHP_SHLIB_SUFFIX === 'dylib') {
      if (!dl('xapian.so')) return;
    } else {
      if (!dl('xapian.'.PHP_SHLIB_SUFFIX)) return;
    }
  }
}



abstract class Xapian {
	static function BAD_VALUENO_get() {
		return BAD_VALUENO_get();
	}

	static function version_string() {
		return version_string();
	}

	static function major_version() {
		return major_version();
	}

	static function minor_version() {
		return minor_version();
	}

	static function revision() {
		return revision();
	}

	const DB_CREATE_OR_OPEN = DB_CREATE_OR_OPEN;

	const DB_CREATE = DB_CREATE;

	const DB_CREATE_OR_OVERWRITE = DB_CREATE_OR_OVERWRITE;

	const DB_OPEN = DB_OPEN;

	static function auto_open_stub($file) {
		$r=auto_open_stub($file);
		return is_resource($r) ? new XapianDatabase($r) : $r;
	}

	static function quartz_open($dir,$action=null,$block_size=8192) {
		switch (func_num_args()) {
		case 1: $r=quartz_open($dir); break;
		default: $r=quartz_open($dir,$action,$block_size);
		}
		if (!is_resource($r)) return $r;
		switch (get_resource_type($r)) {
		case "_p_Xapian__WritableDatabase": return new XapianWritableDatabase($r);
		default: return new XapianDatabase($r);
		}
	}

	static function flint_open($dir,$action=null,$block_size=8192) {
		switch (func_num_args()) {
		case 1: $r=flint_open($dir); break;
		default: $r=flint_open($dir,$action,$block_size);
		}
		if (!is_resource($r)) return $r;
		switch (get_resource_type($r)) {
		case "_p_Xapian__WritableDatabase": return new XapianWritableDatabase($r);
		default: return new XapianDatabase($r);
		}
	}

	static function inmemory_open() {
		$r=inmemory_open();
		return is_resource($r) ? new XapianWritableDatabase($r) : $r;
	}

	static function remote_open($host_or_program,$port_or_args,$timeout=10000,$connect_timeout=null) {
		switch (func_num_args()) {
		case 2: case 3: $r=remote_open($host_or_program,$port_or_args,$timeout); break;
		default: $r=remote_open($host_or_program,$port_or_args,$timeout,$connect_timeout);
		}
		return is_resource($r) ? new XapianDatabase($r) : $r;
	}

	static function remote_open_writable($host_or_program,$port_or_args,$timeout=10000,$connect_timeout=null) {
		switch (func_num_args()) {
		case 2: case 3: $r=remote_open_writable($host_or_program,$port_or_args,$timeout); break;
		default: $r=remote_open_writable($host_or_program,$port_or_args,$timeout,$connect_timeout);
		}
		return is_resource($r) ? new XapianWritableDatabase($r) : $r;
	}

	static function sortable_serialise($value) {
		return sortable_serialise($value);
	}

	static function sortable_unserialise($value) {
		return sortable_unserialise($value);
	}
}

/* PHP Proxy Classes */
class XapianPositionIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_PositionIterator(); break;
		default: $r=new_PositionIterator($other);
		}
		$this->_cPtr=$r;
	}

	function get_termpos() {
		return PositionIterator_get_termpos($this->_cPtr);
	}

	function next() {
		PositionIterator_next($this->_cPtr);
	}

	function equals($other) {
		return PositionIterator_equals($this->_cPtr,$other);
	}

	function skip_to($pos) {
		PositionIterator_skip_to($this->_cPtr,$pos);
	}

	function get_description() {
		return PositionIterator_get_description($this->_cPtr);
	}
}

class XapianPostingIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_PostingIterator(); break;
		default: $r=new_PostingIterator($other);
		}
		$this->_cPtr=$r;
	}

	function skip_to($did) {
		PostingIterator_skip_to($this->_cPtr,$did);
	}

	function get_doclength() {
		return PostingIterator_get_doclength($this->_cPtr);
	}

	function get_wdf() {
		return PostingIterator_get_wdf($this->_cPtr);
	}

	function positionlist_begin() {
		$r=PostingIterator_positionlist_begin($this->_cPtr);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function positionlist_end() {
		$r=PostingIterator_positionlist_end($this->_cPtr);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function get_description() {
		return PostingIterator_get_description($this->_cPtr);
	}

	function get_docid() {
		return PostingIterator_get_docid($this->_cPtr);
	}

	function next() {
		PostingIterator_next($this->_cPtr);
	}

	function equals($other) {
		return PostingIterator_equals($this->_cPtr,$other);
	}
}

class XapianTermIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_TermIterator(); break;
		default: $r=new_TermIterator($other);
		}
		$this->_cPtr=$r;
	}

	function get_term() {
		return TermIterator_get_term($this->_cPtr);
	}

	function next() {
		TermIterator_next($this->_cPtr);
	}

	function equals($other) {
		return TermIterator_equals($this->_cPtr,$other);
	}

	function skip_to($tname) {
		TermIterator_skip_to($this->_cPtr,$tname);
	}

	function get_wdf() {
		return TermIterator_get_wdf($this->_cPtr);
	}

	function get_termfreq() {
		return TermIterator_get_termfreq($this->_cPtr);
	}

	function positionlist_begin() {
		$r=TermIterator_positionlist_begin($this->_cPtr);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function positionlist_end() {
		$r=TermIterator_positionlist_end($this->_cPtr);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function get_description() {
		return TermIterator_get_description($this->_cPtr);
	}
}

class XapianValueIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_ValueIterator(); break;
		default: $r=new_ValueIterator($other);
		}
		$this->_cPtr=$r;
	}

	function get_value() {
		return ValueIterator_get_value($this->_cPtr);
	}

	function next() {
		ValueIterator_next($this->_cPtr);
	}

	function equals($other) {
		return ValueIterator_equals($this->_cPtr,$other);
	}

	function get_valueno() {
		return ValueIterator_get_valueno($this->_cPtr);
	}

	function get_description() {
		return ValueIterator_get_description($this->_cPtr);
	}
}

class XapianDocument {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_Document(); break;
		default: $r=new_Document($other);
		}
		$this->_cPtr=$r;
	}

	function get_value($valueno) {
		return Document_get_value($this->_cPtr,$valueno);
	}

	function add_value($valueno,$value) {
		Document_add_value($this->_cPtr,$valueno,$value);
	}

	function remove_value($valueno) {
		Document_remove_value($this->_cPtr,$valueno);
	}

	function clear_values() {
		Document_clear_values($this->_cPtr);
	}

	function get_data() {
		return Document_get_data($this->_cPtr);
	}

	function set_data($data) {
		Document_set_data($this->_cPtr,$data);
	}

	function add_posting($tname,$tpos,$wdfinc=1) {
		Document_add_posting($this->_cPtr,$tname,$tpos,$wdfinc);
	}

	function add_term($tname,$wdfinc=1) {
		Document_add_term($this->_cPtr,$tname,$wdfinc);
	}

	function remove_posting($tname,$tpos,$wdfdec=1) {
		Document_remove_posting($this->_cPtr,$tname,$tpos,$wdfdec);
	}

	function remove_term($tname) {
		Document_remove_term($this->_cPtr,$tname);
	}

	function clear_terms() {
		Document_clear_terms($this->_cPtr);
	}

	function termlist_count() {
		return Document_termlist_count($this->_cPtr);
	}

	function termlist_begin() {
		$r=Document_termlist_begin($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function termlist_end() {
		$r=Document_termlist_end($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function values_count() {
		return Document_values_count($this->_cPtr);
	}

	function values_begin() {
		$r=Document_values_begin($this->_cPtr);
		return is_resource($r) ? new XapianValueIterator($r) : $r;
	}

	function values_end() {
		$r=Document_values_end($this->_cPtr);
		return is_resource($r) ? new XapianValueIterator($r) : $r;
	}

	function get_docid() {
		return Document_get_docid($this->_cPtr);
	}

	function get_description() {
		return Document_get_description($this->_cPtr);
	}
}

class XapianMSet {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_MSet(); break;
		default: $r=new_MSet($other);
		}
		$this->_cPtr=$r;
	}

	function fetch($begin_or_item=null,$end=null) {
		switch (func_num_args()) {
		case 0: MSet_fetch($this->_cPtr); break;
		case 1: MSet_fetch($this->_cPtr,$begin_or_item); break;
		default: MSet_fetch($this->_cPtr,$begin_or_item,$end);
		}
	}

	function convert_to_percent($wt_or_item) {
		return MSet_convert_to_percent($this->_cPtr,$wt_or_item);
	}

	function get_termfreq($tname) {
		return MSet_get_termfreq($this->_cPtr,$tname);
	}

	function get_termweight($tname) {
		return MSet_get_termweight($this->_cPtr,$tname);
	}

	function get_firstitem() {
		return MSet_get_firstitem($this->_cPtr);
	}

	function get_matches_lower_bound() {
		return MSet_get_matches_lower_bound($this->_cPtr);
	}

	function get_matches_estimated() {
		return MSet_get_matches_estimated($this->_cPtr);
	}

	function get_matches_upper_bound() {
		return MSet_get_matches_upper_bound($this->_cPtr);
	}

	function get_max_possible() {
		return MSet_get_max_possible($this->_cPtr);
	}

	function get_max_attained() {
		return MSet_get_max_attained($this->_cPtr);
	}

	function size() {
		return MSet_size($this->_cPtr);
	}

	function is_empty() {
		return MSet_is_empty($this->_cPtr);
	}

	function begin() {
		$r=MSet_begin($this->_cPtr);
		return is_resource($r) ? new XapianMSetIterator($r) : $r;
	}

	function end() {
		$r=MSet_end($this->_cPtr);
		return is_resource($r) ? new XapianMSetIterator($r) : $r;
	}

	function back() {
		$r=MSet_back($this->_cPtr);
		return is_resource($r) ? new XapianMSetIterator($r) : $r;
	}

	function get_hit($i) {
		$r=MSet_get_hit($this->_cPtr,$i);
		return is_resource($r) ? new XapianMSetIterator($r) : $r;
	}

	function get_document_percentage($i) {
		return MSet_get_document_percentage($this->_cPtr,$i);
	}

	function get_document($i) {
		$r=MSet_get_document($this->_cPtr,$i);
		return is_resource($r) ? new XapianDocument($r) : $r;
	}

	function get_docid($i) {
		return MSet_get_docid($this->_cPtr,$i);
	}

	function get_document_id($i) {
		return MSet_get_document_id($this->_cPtr,$i);
	}

	function get_description() {
		return MSet_get_description($this->_cPtr);
	}
}

class XapianMSetIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_MSetIterator(); break;
		default: $r=new_MSetIterator($other);
		}
		$this->_cPtr=$r;
	}

	function get_docid() {
		return MSetIterator_get_docid($this->_cPtr);
	}

	function next() {
		MSetIterator_next($this->_cPtr);
	}

	function prev() {
		MSetIterator_prev($this->_cPtr);
	}

	function equals($other) {
		return MSetIterator_equals($this->_cPtr,$other);
	}

	function get_document() {
		$r=MSetIterator_get_document($this->_cPtr);
		return is_resource($r) ? new XapianDocument($r) : $r;
	}

	function get_rank() {
		return MSetIterator_get_rank($this->_cPtr);
	}

	function get_weight() {
		return MSetIterator_get_weight($this->_cPtr);
	}

	function get_collapse_key() {
		return MSetIterator_get_collapse_key($this->_cPtr);
	}

	function get_collapse_count() {
		return MSetIterator_get_collapse_count($this->_cPtr);
	}

	function get_percent() {
		return MSetIterator_get_percent($this->_cPtr);
	}

	function get_description() {
		return MSetIterator_get_description($this->_cPtr);
	}
}

class XapianESet {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_ESet(); break;
		default: $r=new_ESet($other);
		}
		$this->_cPtr=$r;
	}

	function get_ebound() {
		return ESet_get_ebound($this->_cPtr);
	}

	function size() {
		return ESet_size($this->_cPtr);
	}

	function is_empty() {
		return ESet_is_empty($this->_cPtr);
	}

	function begin() {
		$r=ESet_begin($this->_cPtr);
		return is_resource($r) ? new XapianESetIterator($r) : $r;
	}

	function end() {
		$r=ESet_end($this->_cPtr);
		return is_resource($r) ? new XapianESetIterator($r) : $r;
	}

	function back() {
		$r=ESet_back($this->_cPtr);
		return is_resource($r) ? new XapianESetIterator($r) : $r;
	}

	function get_description() {
		return ESet_get_description($this->_cPtr);
	}
}

class XapianESetIterator {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_ESetIterator(); break;
		default: $r=new_ESetIterator($other);
		}
		$this->_cPtr=$r;
	}

	function get_termname() {
		return ESetIterator_get_termname($this->_cPtr);
	}

	function get_term() {
		return ESetIterator_get_term($this->_cPtr);
	}

	function next() {
		ESetIterator_next($this->_cPtr);
	}

	function prev() {
		ESetIterator_prev($this->_cPtr);
	}

	function equals($other) {
		return ESetIterator_equals($this->_cPtr,$other);
	}

	function get_weight() {
		return ESetIterator_get_weight($this->_cPtr);
	}

	function get_description() {
		return ESetIterator_get_description($this->_cPtr);
	}
}

class XapianRSet {
	public $_cPtr=null;

	function __construct($other=null) {
		switch (func_num_args()) {
		case 0: $r=new_RSet(); break;
		default: $r=new_RSet($other);
		}
		$this->_cPtr=$r;
	}

	function size() {
		return RSet_size($this->_cPtr);
	}

	function is_empty() {
		return RSet_is_empty($this->_cPtr);
	}

	function add_document($did_or_i) {
		RSet_add_document($this->_cPtr,$did_or_i);
	}

	function remove_document($did_or_i) {
		RSet_remove_document($this->_cPtr,$did_or_i);
	}

	function contains($did_or_i) {
		return RSet_contains($this->_cPtr,$did_or_i);
	}

	function get_description() {
		return RSet_get_description($this->_cPtr);
	}
}

abstract class XapianMatchDecider {
	public $_cPtr=null;
	function __construct($h) {
		$this->_cPtr=$h;
	}

	function apply($doc) {
		return MatchDecider_apply($this->_cPtr,$doc);
	}
}

class XapianEnquire {
	public $_cPtr=null;

	function __construct($databases) {
		$this->_cPtr=new_Enquire($databases);
	}

	function set_query($query,$qlen=0) {
		Enquire_set_query($this->_cPtr,$query,$qlen);
	}

	function get_query() {
		$r=Enquire_get_query($this->_cPtr);
		return is_resource($r) ? new XapianQuery($r) : $r;
	}

	function set_weighting_scheme($weight) {
		Enquire_set_weighting_scheme($this->_cPtr,$weight);
	}

	function set_collapse_key($collapse_key) {
		Enquire_set_collapse_key($this->_cPtr,$collapse_key);
	}

	const ASCENDING = 1;

	const DESCENDING = 0;

	const DONT_CARE = 2;

	function set_docid_order($order) {
		Enquire_set_docid_order($this->_cPtr,$order);
	}

	function set_cutoff($percent_cutoff,$weight_cutoff=0.0) {
		Enquire_set_cutoff($this->_cPtr,$percent_cutoff,$weight_cutoff);
	}

	function set_sort_by_relevance() {
		Enquire_set_sort_by_relevance($this->_cPtr);
	}

	function set_sort_by_value($sort_key,$ascending=true) {
		Enquire_set_sort_by_value($this->_cPtr,$sort_key,$ascending);
	}

	function set_sort_by_value_then_relevance($sort_key,$ascending=true) {
		Enquire_set_sort_by_value_then_relevance($this->_cPtr,$sort_key,$ascending);
	}

	function set_sort_by_relevance_then_value($sort_key,$ascending=true) {
		Enquire_set_sort_by_relevance_then_value($this->_cPtr,$sort_key,$ascending);
	}

	function set_sort_by_key($sorter,$ascending=true) {
		Enquire_set_sort_by_key($this->_cPtr,$sorter,$ascending);
	}

	function set_sort_by_key_then_relevance($sorter,$ascending=true) {
		Enquire_set_sort_by_key_then_relevance($this->_cPtr,$sorter,$ascending);
	}

	function set_sort_by_relevance_then_key($sorter,$ascending=true) {
		Enquire_set_sort_by_relevance_then_key($this->_cPtr,$sorter,$ascending);
	}

	const INCLUDE_QUERY_TERMS = Enquire_INCLUDE_QUERY_TERMS;

	const USE_EXACT_TERMFREQ = Enquire_USE_EXACT_TERMFREQ;

	function get_mset($first,$maxitems,$checkatleast_or_omrset=null,$omrset=null) {
		switch (func_num_args()) {
		case 2: $r=Enquire_get_mset($this->_cPtr,$first,$maxitems); break;
		case 3: $r=Enquire_get_mset($this->_cPtr,$first,$maxitems,$checkatleast_or_omrset); break;
		default: $r=Enquire_get_mset($this->_cPtr,$first,$maxitems,$checkatleast_or_omrset,$omrset);
		}
		return is_resource($r) ? new XapianMSet($r) : $r;
	}

	function get_eset($maxitems,$omrset,$flags=0,$k=1.0) {
		$r=Enquire_get_eset($this->_cPtr,$maxitems,$omrset,$flags,$k);
		return is_resource($r) ? new XapianESet($r) : $r;
	}

	function get_matching_terms_begin($did_or_i) {
		$r=Enquire_get_matching_terms_begin($this->_cPtr,$did_or_i);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function get_matching_terms_end($did_or_i) {
		$r=Enquire_get_matching_terms_end($this->_cPtr,$did_or_i);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function get_matching_terms($hit) {
		return Enquire_get_matching_terms($this->_cPtr,$hit);
	}

	function get_description() {
		return Enquire_get_description($this->_cPtr);
	}
}

abstract class XapianWeight {
	public $_cPtr=null;
	function __construct($h) {
		$this->_cPtr=$h;
	}

	function name() {
		return Weight_name($this->_cPtr);
	}

	function serialise() {
		return Weight_serialise($this->_cPtr);
	}

	function unserialise($s) {
		$r=Weight_unserialise($this->_cPtr,$s);
		return is_resource($r) ? new XapianWeight($r) : $r;
	}

	function get_sumpart($wdf,$len) {
		return Weight_get_sumpart($this->_cPtr,$wdf,$len);
	}

	function get_maxpart() {
		return Weight_get_maxpart($this->_cPtr);
	}

	function get_sumextra($len) {
		return Weight_get_sumextra($this->_cPtr,$len);
	}

	function get_maxextra() {
		return Weight_get_maxextra($this->_cPtr);
	}

	function get_sumpart_needs_doclength() {
		return Weight_get_sumpart_needs_doclength($this->_cPtr);
	}
}

class XapianBoolWeight extends XapianWeight {
	public $_cPtr=null;

	function clone_object() {
		$r=BoolWeight_clone_object($this->_cPtr);
		return is_resource($r) ? new XapianBoolWeight($r) : $r;
	}

	function __construct() {
		$this->_cPtr=new_BoolWeight();
	}

	function name() {
		return BoolWeight_name($this->_cPtr);
	}

	function serialise() {
		return BoolWeight_serialise($this->_cPtr);
	}

	function unserialise($s) {
		$r=BoolWeight_unserialise($this->_cPtr,$s);
		return is_resource($r) ? new XapianBoolWeight($r) : $r;
	}

	function get_sumpart($wdf,$len) {
		return BoolWeight_get_sumpart($this->_cPtr,$wdf,$len);
	}

	function get_maxpart() {
		return BoolWeight_get_maxpart($this->_cPtr);
	}

	function get_sumextra($len) {
		return BoolWeight_get_sumextra($this->_cPtr,$len);
	}

	function get_maxextra() {
		return BoolWeight_get_maxextra($this->_cPtr);
	}

	function get_sumpart_needs_doclength() {
		return BoolWeight_get_sumpart_needs_doclength($this->_cPtr);
	}
}

class XapianBM25Weight extends XapianWeight {
	public $_cPtr=null;

	function __construct($k1_=null,$k2_=null,$k3_=null,$b_=null,$min_normlen_=null) {
		switch (func_num_args()) {
		case 0: $r=new_BM25Weight(); break;
		case 1: $r=new_BM25Weight($k1_); break;
		case 2: $r=new_BM25Weight($k1_,$k2_); break;
		case 3: $r=new_BM25Weight($k1_,$k2_,$k3_); break;
		case 4: $r=new_BM25Weight($k1_,$k2_,$k3_,$b_); break;
		default: $r=new_BM25Weight($k1_,$k2_,$k3_,$b_,$min_normlen_);
		}
		$this->_cPtr=$r;
	}

	function clone_object() {
		$r=BM25Weight_clone_object($this->_cPtr);
		return is_resource($r) ? new XapianBM25Weight($r) : $r;
	}

	function name() {
		return BM25Weight_name($this->_cPtr);
	}

	function serialise() {
		return BM25Weight_serialise($this->_cPtr);
	}

	function unserialise($s) {
		$r=BM25Weight_unserialise($this->_cPtr,$s);
		return is_resource($r) ? new XapianBM25Weight($r) : $r;
	}

	function get_sumpart($wdf,$len) {
		return BM25Weight_get_sumpart($this->_cPtr,$wdf,$len);
	}

	function get_maxpart() {
		return BM25Weight_get_maxpart($this->_cPtr);
	}

	function get_sumextra($len) {
		return BM25Weight_get_sumextra($this->_cPtr,$len);
	}

	function get_maxextra() {
		return BM25Weight_get_maxextra($this->_cPtr);
	}

	function get_sumpart_needs_doclength() {
		return BM25Weight_get_sumpart_needs_doclength($this->_cPtr);
	}
}

class XapianTradWeight extends XapianWeight {
	public $_cPtr=null;

	function __construct($k=null) {
		switch (func_num_args()) {
		case 0: $r=new_TradWeight(); break;
		default: $r=new_TradWeight($k);
		}
		$this->_cPtr=$r;
	}

	function clone_object() {
		$r=TradWeight_clone_object($this->_cPtr);
		return is_resource($r) ? new XapianTradWeight($r) : $r;
	}

	function name() {
		return TradWeight_name($this->_cPtr);
	}

	function serialise() {
		return TradWeight_serialise($this->_cPtr);
	}

	function unserialise($s) {
		$r=TradWeight_unserialise($this->_cPtr,$s);
		return is_resource($r) ? new XapianTradWeight($r) : $r;
	}

	function get_sumpart($wdf,$len) {
		return TradWeight_get_sumpart($this->_cPtr,$wdf,$len);
	}

	function get_maxpart() {
		return TradWeight_get_maxpart($this->_cPtr);
	}

	function get_sumextra($len) {
		return TradWeight_get_sumextra($this->_cPtr,$len);
	}

	function get_maxextra() {
		return TradWeight_get_maxextra($this->_cPtr);
	}

	function get_sumpart_needs_doclength() {
		return TradWeight_get_sumpart_needs_doclength($this->_cPtr);
	}
}

class XapianDatabase {
	public $_cPtr=null;

	function add_database($database) {
		Database_add_database($this->_cPtr,$database);
	}

	function __construct($path_or_other=null) {
		switch (func_num_args()) {
		case 0: $r=new_Database(); break;
		default: $r=new_Database($path_or_other);
		}
		$this->_cPtr=$r;
	}

	function reopen() {
		Database_reopen($this->_cPtr);
	}

	function get_description() {
		return Database_get_description($this->_cPtr);
	}

	function postlist_begin($tname) {
		$r=Database_postlist_begin($this->_cPtr,$tname);
		return is_resource($r) ? new XapianPostingIterator($r) : $r;
	}

	function postlist_end($tname) {
		$r=Database_postlist_end($this->_cPtr,$tname);
		return is_resource($r) ? new XapianPostingIterator($r) : $r;
	}

	function termlist_begin($did) {
		$r=Database_termlist_begin($this->_cPtr,$did);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function termlist_end($did) {
		$r=Database_termlist_end($this->_cPtr,$did);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function positionlist_begin($did,$tname) {
		$r=Database_positionlist_begin($this->_cPtr,$did,$tname);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function positionlist_end($did,$tname) {
		$r=Database_positionlist_end($this->_cPtr,$did,$tname);
		return is_resource($r) ? new XapianPositionIterator($r) : $r;
	}

	function allterms_begin($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_allterms_begin($this->_cPtr); break;
		default: $r=Database_allterms_begin($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function allterms_end($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_allterms_end($this->_cPtr); break;
		default: $r=Database_allterms_end($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function get_doccount() {
		return Database_get_doccount($this->_cPtr);
	}

	function get_lastdocid() {
		return Database_get_lastdocid($this->_cPtr);
	}

	function get_avlength() {
		return Database_get_avlength($this->_cPtr);
	}

	function get_termfreq($tname) {
		return Database_get_termfreq($this->_cPtr,$tname);
	}

	function term_exists($tname) {
		return Database_term_exists($this->_cPtr,$tname);
	}

	function get_collection_freq($tname) {
		return Database_get_collection_freq($this->_cPtr,$tname);
	}

	function get_doclength($docid) {
		return Database_get_doclength($this->_cPtr,$docid);
	}

	function keep_alive() {
		Database_keep_alive($this->_cPtr);
	}

	function get_document($did) {
		$r=Database_get_document($this->_cPtr,$did);
		return is_resource($r) ? new XapianDocument($r) : $r;
	}

	function get_spelling_suggestion($word,$max_edit_distance=2) {
		return Database_get_spelling_suggestion($this->_cPtr,$word,$max_edit_distance);
	}

	function spellings_begin() {
		$r=Database_spellings_begin($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function spellings_end() {
		$r=Database_spellings_end($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function synonyms_begin($term) {
		$r=Database_synonyms_begin($this->_cPtr,$term);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function synonyms_end($arg1) {
		$r=Database_synonyms_end($this->_cPtr,$arg1);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function synonym_keys_begin($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_synonym_keys_begin($this->_cPtr); break;
		default: $r=Database_synonym_keys_begin($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function synonym_keys_end($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_synonym_keys_end($this->_cPtr); break;
		default: $r=Database_synonym_keys_end($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function get_metadata($key) {
		return Database_get_metadata($this->_cPtr,$key);
	}

	function metadata_keys_begin($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_metadata_keys_begin($this->_cPtr); break;
		default: $r=Database_metadata_keys_begin($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function metadata_keys_end($prefix=null) {
		switch (func_num_args()) {
		case 0: $r=Database_metadata_keys_end($this->_cPtr); break;
		default: $r=Database_metadata_keys_end($this->_cPtr,$prefix);
		}
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}
}

class XapianWritableDatabase extends XapianDatabase {
	public $_cPtr=null;

	function __construct($path_or_other=null,$action=null) {
		switch (func_num_args()) {
		case 0: $r=new_WritableDatabase(); break;
		case 1: $r=new_WritableDatabase($path_or_other); break;
		default: $r=new_WritableDatabase($path_or_other,$action);
		}
		$this->_cPtr=$r;
	}

	function flush() {
		WritableDatabase_flush($this->_cPtr);
	}

	function begin_transaction($flushed=true) {
		WritableDatabase_begin_transaction($this->_cPtr,$flushed);
	}

	function commit_transaction() {
		WritableDatabase_commit_transaction($this->_cPtr);
	}

	function cancel_transaction() {
		WritableDatabase_cancel_transaction($this->_cPtr);
	}

	function add_document($document) {
		return WritableDatabase_add_document($this->_cPtr,$document);
	}

	function delete_document($did_or_unique_term) {
		WritableDatabase_delete_document($this->_cPtr,$did_or_unique_term);
	}

	function replace_document($did_or_unique_term,$document) {
		return WritableDatabase_replace_document($this->_cPtr,$did_or_unique_term,$document);
	}

	function add_spelling($word,$freqinc=1) {
		WritableDatabase_add_spelling($this->_cPtr,$word,$freqinc);
	}

	function remove_spelling($word,$freqdec=1) {
		WritableDatabase_remove_spelling($this->_cPtr,$word,$freqdec);
	}

	function add_synonym($term,$synonym) {
		WritableDatabase_add_synonym($this->_cPtr,$term,$synonym);
	}

	function remove_synonym($term,$synonym) {
		WritableDatabase_remove_synonym($this->_cPtr,$term,$synonym);
	}

	function clear_synonyms($term) {
		WritableDatabase_clear_synonyms($this->_cPtr,$term);
	}

	function set_metadata($key,$value) {
		WritableDatabase_set_metadata($this->_cPtr,$key,$value);
	}

	function get_description() {
		return WritableDatabase_get_description($this->_cPtr);
	}
}

class XapianQuery {
	public $_cPtr=null;

	const OP_AND = 0;

	const OP_OR = Query_OP_OR;

	const OP_AND_NOT = Query_OP_AND_NOT;

	const OP_XOR = Query_OP_XOR;

	const OP_AND_MAYBE = Query_OP_AND_MAYBE;

	const OP_FILTER = Query_OP_FILTER;

	const OP_NEAR = Query_OP_NEAR;

	const OP_PHRASE = Query_OP_PHRASE;

	const OP_VALUE_RANGE = Query_OP_VALUE_RANGE;

	const OP_SCALE_WEIGHT = Query_OP_SCALE_WEIGHT;

	const OP_ELITE_SET = 10;

	const OP_VALUE_GE = Query_OP_VALUE_GE;

	const OP_VALUE_LE = Query_OP_VALUE_LE;

	function __construct($tname_or_op__or_copyme_or_op=null,$wqf_or_left_or_valno_or_subqs_or_q=null,$term_pos_or_right_or_begin_or_value_or_param_or_parameter=null,$end=null) {
		switch (func_num_args()) {
		case 0: $r=new_Query(); break;
		case 1: $r=new_Query($tname_or_op__or_copyme_or_op); break;
		case 2: $r=new_Query($tname_or_op__or_copyme_or_op,$wqf_or_left_or_valno_or_subqs_or_q); break;
		case 3: $r=new_Query($tname_or_op__or_copyme_or_op,$wqf_or_left_or_valno_or_subqs_or_q,$term_pos_or_right_or_begin_or_value_or_param_or_parameter); break;
		default: $r=new_Query($tname_or_op__or_copyme_or_op,$wqf_or_left_or_valno_or_subqs_or_q,$term_pos_or_right_or_begin_or_value_or_param_or_parameter,$end);
		}
		$this->_cPtr=$r;
	}

	function get_length() {
		return Query_get_length($this->_cPtr);
	}

	function get_terms_begin() {
		$r=Query_get_terms_begin($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function get_terms_end() {
		$r=Query_get_terms_end($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function is_empty() {
		return Query_is_empty($this->_cPtr);
	}

	function get_description() {
		return Query_get_description($this->_cPtr);
	}
}

abstract class XapianStopper {
	public $_cPtr=null;
	function __construct($h) {
		$this->_cPtr=$h;
	}

	function apply($term) {
		return Stopper_apply($this->_cPtr,$term);
	}

	function get_description() {
		return Stopper_get_description($this->_cPtr);
	}
}

class XapianSimpleStopper extends XapianStopper {
	public $_cPtr=null;

	function __construct() {
		$this->_cPtr=new_SimpleStopper();
	}

	function add($word) {
		SimpleStopper_add($this->_cPtr,$word);
	}

	function apply($term) {
		return SimpleStopper_apply($this->_cPtr,$term);
	}

	function get_description() {
		return SimpleStopper_get_description($this->_cPtr);
	}
}

abstract class XapianValueRangeProcessor {
	public $_cPtr=null;
	function __construct($h) {
		$this->_cPtr=$h;
	}

	function apply($begin,$end) {
		return ValueRangeProcessor_apply($this->_cPtr,$begin,$end);
	}
}

class XapianStringValueRangeProcessor extends XapianValueRangeProcessor {
	public $_cPtr=null;

	function __construct($valno_) {
		$this->_cPtr=new_StringValueRangeProcessor($valno_);
	}

	function apply($arg1,$arg2) {
		return StringValueRangeProcessor_apply($this->_cPtr,$arg1,$arg2);
	}
}

class XapianDateValueRangeProcessor extends XapianValueRangeProcessor {
	public $_cPtr=null;

	function __construct($valno_,$prefer_mdy_=false,$epoch_year_=1970) {
		$this->_cPtr=new_DateValueRangeProcessor($valno_,$prefer_mdy_,$epoch_year_);
	}

	function apply($begin,$end) {
		return DateValueRangeProcessor_apply($this->_cPtr,$begin,$end);
	}
}

class XapianNumberValueRangeProcessor extends XapianValueRangeProcessor {
	public $_cPtr=null;

	function __construct($valno_,$str_=null,$prefix_=true) {
		switch (func_num_args()) {
		case 1: $r=new_NumberValueRangeProcessor($valno_); break;
		default: $r=new_NumberValueRangeProcessor($valno_,$str_,$prefix_);
		}
		$this->_cPtr=$r;
	}

	function apply($begin,$end) {
		return NumberValueRangeProcessor_apply($this->_cPtr,$begin,$end);
	}
}

class XapianQueryParser {
	public $_cPtr=null;

	const FLAG_BOOLEAN = 1;

	const FLAG_PHRASE = 2;

	const FLAG_LOVEHATE = 4;

	const FLAG_BOOLEAN_ANY_CASE = 8;

	const FLAG_WILDCARD = 16;

	const FLAG_PURE_NOT = 32;

	const FLAG_PARTIAL = 64;

	const FLAG_SPELLING_CORRECTION = 128;

	const FLAG_SYNONYM = 256;

	const FLAG_AUTO_SYNONYMS = 512;

	const FLAG_AUTO_MULTIWORD_SYNONYMS = QueryParser_FLAG_AUTO_MULTIWORD_SYNONYMS;

	const FLAG_DEFAULT = QueryParser_FLAG_DEFAULT;

	const STEM_NONE = 0;

	const STEM_SOME = QueryParser_STEM_SOME;

	const STEM_ALL = QueryParser_STEM_ALL;

	function __construct() {
		$this->_cPtr=new_QueryParser();
	}

	function set_stemmer($stemmer) {
		QueryParser_set_stemmer($this->_cPtr,$stemmer);
	}

	function set_stemming_strategy($strategy) {
		QueryParser_set_stemming_strategy($this->_cPtr,$strategy);
	}

	function set_stopper($stop=null) {
		QueryParser_set_stopper($this->_cPtr,$stop);
	}

	function set_default_op($default_op) {
		QueryParser_set_default_op($this->_cPtr,$default_op);
	}

	function get_default_op() {
		return QueryParser_get_default_op($this->_cPtr);
	}

	function set_database($db) {
		QueryParser_set_database($this->_cPtr,$db);
	}

	function parse_query($query_string,$flags=null,$default_prefix=null) {
		switch (func_num_args()) {
		case 1: $r=QueryParser_parse_query($this->_cPtr,$query_string); break;
		case 2: $r=QueryParser_parse_query($this->_cPtr,$query_string,$flags); break;
		default: $r=QueryParser_parse_query($this->_cPtr,$query_string,$flags,$default_prefix);
		}
		return is_resource($r) ? new XapianQuery($r) : $r;
	}

	function add_prefix($field,$prefix) {
		QueryParser_add_prefix($this->_cPtr,$field,$prefix);
	}

	function add_boolean_prefix($field,$prefix) {
		QueryParser_add_boolean_prefix($this->_cPtr,$field,$prefix);
	}

	function stoplist_begin() {
		$r=QueryParser_stoplist_begin($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function stoplist_end() {
		$r=QueryParser_stoplist_end($this->_cPtr);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function unstem_begin($term) {
		$r=QueryParser_unstem_begin($this->_cPtr,$term);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function unstem_end($arg1) {
		$r=QueryParser_unstem_end($this->_cPtr,$arg1);
		return is_resource($r) ? new XapianTermIterator($r) : $r;
	}

	function add_valuerangeprocessor($vrproc) {
		QueryParser_add_valuerangeprocessor($this->_cPtr,$vrproc);
	}

	function get_corrected_query_string() {
		return QueryParser_get_corrected_query_string($this->_cPtr);
	}

	function get_description() {
		return QueryParser_get_description($this->_cPtr);
	}
}

class XapianStem {
	public $_cPtr=null;

	function __construct($language) {
		$this->_cPtr=new_Stem($language);
	}

	function apply($word) {
		return Stem_apply($this->_cPtr,$word);
	}

	function get_description() {
		return Stem_get_description($this->_cPtr);
	}

	static function get_available_languages() {
		return Stem_get_available_languages();
	}
}

class XapianTermGenerator {
	public $_cPtr=null;

	function __construct() {
		$this->_cPtr=new_TermGenerator();
	}

	function set_stemmer($stemmer) {
		TermGenerator_set_stemmer($this->_cPtr,$stemmer);
	}

	function set_stopper($stop=null) {
		TermGenerator_set_stopper($this->_cPtr,$stop);
	}

	function set_document($doc) {
		TermGenerator_set_document($this->_cPtr,$doc);
	}

	function get_document() {
		$r=TermGenerator_get_document($this->_cPtr);
		return is_resource($r) ? new XapianDocument($r) : $r;
	}

	function set_database($db) {
		TermGenerator_set_database($this->_cPtr,$db);
	}

	const FLAG_SPELLING = 128;

	function set_flags($toggle,$mask=null) {
		switch (func_num_args()) {
		case 1: $r=TermGenerator_set_flags($this->_cPtr,$toggle); break;
		default: $r=TermGenerator_set_flags($this->_cPtr,$toggle,$mask);
		}
		return $r;
	}

	function index_text($text,$weight=1,$prefix=null) {
		switch (func_num_args()) {
		case 1: case 2: TermGenerator_index_text($this->_cPtr,$text,$weight); break;
		default: TermGenerator_index_text($this->_cPtr,$text,$weight,$prefix);
		}
	}

	function index_text_without_positions($text,$weight=1,$prefix=null) {
		switch (func_num_args()) {
		case 1: case 2: TermGenerator_index_text_without_positions($this->_cPtr,$text,$weight); break;
		default: TermGenerator_index_text_without_positions($this->_cPtr,$text,$weight,$prefix);
		}
	}

	function increase_termpos($delta=100) {
		TermGenerator_increase_termpos($this->_cPtr,$delta);
	}

	function get_termpos() {
		return TermGenerator_get_termpos($this->_cPtr);
	}

	function set_termpos($termpos) {
		TermGenerator_set_termpos($this->_cPtr,$termpos);
	}

	function get_description() {
		return TermGenerator_get_description($this->_cPtr);
	}
}

class XapianMultiValueSorter {
	public $_cPtr=null;

	function __construct() {
		$this->_cPtr=new_MultiValueSorter();
	}

	function apply($doc) {
		return MultiValueSorter_apply($this->_cPtr,$doc);
	}

	function add($valno,$forward=true) {
		MultiValueSorter_add($this->_cPtr,$valno,$forward);
	}
}


?>
