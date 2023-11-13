<?php

function debug($chaine, $die = false)
{
	echo "<hr /><pre>";
	var_dump($chaine);
	echo "</pre><hr />";
	if ($die) {
		die();
	}
}

/**
 * Convert a date from french month name to another format
 *
 * @param string  Date to convert
 * @param string  Format of date to convert
 * @param string  Format for output
 * @return string
 *
 * @php_version  >= 5.3
 * @link http://php.net/manual/en/function.date.php  All date formats
 */
function convert_date($date, $format_in = 'Y-m-d', $format_out = 'd/m/Y')
{
	// French to english month names
	$months = array(
		'janvier' => 'january',
		'février' => 'february',
		'mars' => 'march',
		'avril' => 'april',
		'mai' => 'may',
		'juin' => 'june',
		'juillet' => 'july',
		'août' => 'august',
		'septembre' => 'september',
		'octobre' => 'october',
		'novembre' => 'november',
		'décembre' => 'december',
	);

	// List of available formats for date
	$formats_list = array(
		'd',
		'D',
		'j',
		'l',
		'N',
		'S',
		'w',
		'z',
		'S',
		'W',
		'M',
		'F',
		'm',
		'M',
		'n',
		't',
		'A',
		'L',
		'o',
		'Y',
		'y',
		'H',
		'a',
		'A',
		'B',
		'g',
		'G',
		'h',
		'H',
		'i',
		's',
		'u',
		'v',
		'F',
		'e',
		'I',
		'O',
		'P',
		'T',
		'Z',
		'D',
		'c',
		'r',
		'U'
	);

	// We get separators between elements in $date, based on $format_in
	$split = str_split($format_in);
	$separators = array();
	$_continue = false;
	foreach ($split as $k => $s) {
		if ($_continue) {
			$_continue = false;
			continue;
		}
		// For escaped chars (like "\h")
		if ($s == '\\' && isset($split[$k + 1])) {
			$separators[] = '\\' . $split[$k + 1];
			$_continue = true;
			continue;
		}
		if (!in_array($s, $formats_list)) {
			$separators[] = $s;
		}
	}

	// Translate month name
	$tmp = preg_split(
		'/(' . implode(
			'|',
			array_map(
				function ($v) {
					if ($v == '/') {
						return '\/';
					}
					return str_replace('\\', '\\\\', $v);
				},
				$separators
			)
		) . ')/',
		$date
	);

	foreach ($tmp as $k => $v) {
		$v = mb_strtolower($v, 'UTF-8');
		if (isset($months[$v])) {
			$tmp[$k] = $months[$v];
		}
	}

	// Re-construct the date
	$imploded = '';
	foreach ($tmp as $k => $v) {
		$imploded .= $v . (isset($separators[$k]) ? str_replace('\\', '', $separators[$k]) : '');
	}

	return DateTime::createFromFormat($format_in, $imploded)->format($format_out);
}

function designations($designations = '')
{
	$return = [];

	$pos = strripos($designations, ' - ');
	$return['designation'] = substr($designations, 0, $pos);
	$declinaisons = substr($designations, $pos + 3);

	if (!empty($declinaisons)) {
		$ds = explode(', ', $declinaisons);
		if (count($ds) > 1) {
			foreach ($ds as $d) {
				if (count(explode(' : ', $d)) > 1) {
					list($key, $value) = explode(' : ', $d);
					$return['declinaisons'][$key] = $value;
				}
			}
		} else {
			$ds = explode('- ', $declinaisons);
			if (!empty($ds)) {
				foreach ($ds as $d) {
					if (count(explode(' : ', $d)) > 1) {
						list($key, $value) = explode(' : ', $d);
						$return['declinaisons'][$key] = $value;
					}
				}
			}
		}
	}

	return $return;
}